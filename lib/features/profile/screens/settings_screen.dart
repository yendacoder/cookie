import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_app_bar.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_dialog.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_divider.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_list_tile.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_progress_indicator.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_scaffold.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_segmented_button.dart';
import 'package:cookie/features/auth/providers/auth_provider.dart';
import 'package:cookie/features/feed/models/feed_type.dart';
import 'package:cookie/features/feed/providers/visible_feed_types_provider.dart';
import 'package:cookie/features/shell/models/content_text_size.dart';
import 'package:cookie/features/shell/providers/content_text_sizes_provider.dart';
import 'package:cookie/features/shell/providers/text_scale_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textScale = ref.watch(textScaleProvider);
    final contentTextSizes = ref.watch(contentTextSizesProvider);
    final visibleFeedTypes = ref.watch(visibleFeedTypesProvider);
    final textTheme = Theme.of(context).textTheme;

    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(title: Text(context.l10n.settingsScreenTitle)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(context.l10n.textScaleSetting, style: textTheme.titleMedium),
          AdaptiveSegmentedButton<double>(
            showSelectedIcon: false,
            emptySelectionAllowed: false,
            segments: [
              for (final (iosLabel, scale) in [
                ('100%', 1.0),
                ('115%', 1.15),
                ('130%', 1.3),
                ('150%', 1.5),
              ])
                AdaptiveButtonSegment(
                  value: scale,
                  label: iosLabel,
                  androidWidget: Container(
                    alignment: .center,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: .min,
                      children: [
                        Text(
                          'A',
                          textScaler: TextScaler.linear(1.0),
                          style: textTheme.bodyMedium!.copyWith(
                            fontSize: textTheme.bodyMedium!.fontSize! * scale,
                          ),
                        ),
                        Text(
                          '${(scale * 100).round().toInt()}%',
                          textScaler: TextScaler.linear(1.0),
                          style: textTheme.labelMedium!.copyWith(
                            fontSize: textTheme.labelMedium!.fontSize! * scale,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
            selected: {textScale},
            onSelectionChanged: (selected) =>
                ref.read(textScaleProvider.notifier).set(selected.first),
          ),
          const SizedBox(height: 32),
          const AdaptiveDivider(height: 1),
          const SizedBox(height: 24),
          Text(
            context.l10n.contentTextSizeSectionTitle,
            style: textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          _ContentTextSizeRow(
            label: context.l10n.postListTextSizeLabel,
            value: contentTextSizes.postCard,
            onChanged: (size) =>
                ref.read(contentTextSizesProvider.notifier).setPostCard(size),
          ),
          _ContentTextSizeRow(
            label: context.l10n.postBodyTextSizeLabel,
            value: contentTextSizes.postDetail,
            onChanged: (size) =>
                ref.read(contentTextSizesProvider.notifier).setPostDetail(size),
          ),
          _ContentTextSizeRow(
            label: context.l10n.commentTextSizeLabel,
            value: contentTextSizes.comment,
            onChanged: (size) =>
                ref.read(contentTextSizesProvider.notifier).setComment(size),
          ),
          const SizedBox(height: 24),
          const AdaptiveDivider(height: 1),
          const SizedBox(height: 24),
          Text(
            context.l10n.navigationTabsSetting,
            style: textTheme.titleMedium,
          ),
          for (final type in FeedType.values)
            AdaptiveSwitchListTile(
              title: Text(type.title(context.l10n)),
              value: visibleFeedTypes.contains(type),
              onChanged:
                  visibleFeedTypes.length == 1 &&
                      visibleFeedTypes.contains(type)
                  ? null
                  : (_) => ref
                        .read(visibleFeedTypesProvider.notifier)
                        .toggle(type),
            ),
          const SizedBox(height: 8),
          const AdaptiveDivider(height: 1),
          const SizedBox(height: 8),
          AdaptiveListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.delete_outline,
              color: Theme.of(context).colorScheme.error,
            ),
            title: Text(
              context.l10n.deleteAccountSetting,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            isLast: true,
            onTap: () => _confirmDeleteAccount(context, ref),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDeleteAccount(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final deleted = await showPlatformDialog<bool>(
      context: context,
      builder: (ctx) => const _DeleteAccountDialog(),
    );
    if (deleted == true && context.mounted) {
      context.pop();
    }
  }
}

class _DeleteAccountDialog extends ConsumerStatefulWidget {
  const _DeleteAccountDialog();

  @override
  ConsumerState<_DeleteAccountDialog> createState() =>
      _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends ConsumerState<_DeleteAccountDialog> {
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isSubmitting = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      if (_errorText != null) setState(() => _errorText = null);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final password = _passwordController.text;
    if (password.isEmpty || _isSubmitting) return;
    setState(() {
      _isSubmitting = true;
      _errorText = null;
    });
    try {
      await ref.read(authProvider.notifier).deleteAccount(password);
      if (mounted) Navigator.pop(context, true);
    } on DioException catch (e) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
        _errorText = switch (e.response?.statusCode) {
          403 => context.l10n.deleteAccountErrorWrongPassword,
          429 => context.l10n.deleteAccountErrorRateLimit,
          _ => context.l10n.errorGeneric,
        };
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isSubmitting = false;
        _errorText = context.l10n.errorGeneric;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AdaptiveAlertDialog(
      title: Text(l10n.deleteAccountConfirmTitle),
      content: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          children: [
            Text(l10n.deleteAccountConfirmBody),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              autofocus: true,
              obscureText: _obscurePassword,
              enabled: !_isSubmitting,
              decoration: InputDecoration(
                labelText: l10n.deleteAccountPasswordLabel,
                errorText: _errorText,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              onSubmitted: (_) => _submit(),
            ),
          ],
        ),
      ),
      actions: [
        AdaptiveDialogAction(
          onPressed: _isSubmitting ? null : () => Navigator.pop(context, false),
          child: Text(l10n.cancelButton),
        ),
        AdaptiveDialogAction(
          isDefault: true,
          isDestructive: true,
          onPressed: _passwordController.text.isEmpty || _isSubmitting
              ? null
              : _submit,
          child: _isSubmitting
              ? const SizedBox.square(
                  dimension: 16,
                  child: AdaptiveProgressIndicator(strokeWidth: 2),
                )
              : Text(l10n.deleteButton),
        ),
      ],
    );
  }
}

class _ContentTextSizeRow extends StatelessWidget {
  const _ContentTextSizeRow({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final ContentTextSize value;
  final ValueChanged<ContentTextSize> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          AdaptiveSegmentedButton<ContentTextSize>(
            showSelectedIcon: false,
            emptySelectionAllowed: false,
            segments: [
              AdaptiveButtonSegment(value: .small, label: l10n.textSizeSmall),
              AdaptiveButtonSegment(value: .medium, label: l10n.textSizeMedium),
              AdaptiveButtonSegment(value: .large, label: l10n.textSizeLarge),
            ],
            selected: {value},
            onSelectionChanged: (selected) => onChanged(selected.first),
          ),
        ],
      ),
    );
  }
}
