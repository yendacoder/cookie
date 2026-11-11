import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_app_bar.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_button.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_filter_chip.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_list_tile.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_progress_indicator.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_scaffold.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_snackbar.dart';
import 'package:cookie/features/feedback/providers/feedback_provider.dart';
import 'package:cookie/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackScreen extends ConsumerStatefulWidget {
  const FeedbackScreen({super.key});

  @override
  ConsumerState<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends ConsumerState<FeedbackScreen> {
  final _messageCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  FeedbackCategory _category = .bug;
  bool _includeDiagnostics = true;
  bool _sending = false;
  bool _emailInvalid = false;

  @override
  void initState() {
    super.initState();
    _messageCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _messageCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  String get _supportEmail =>
      ref.read(feedbackConfigProvider)?.supportEmail ?? '';

  bool get _canSend => !_sending && _messageCtrl.text.trim().isNotEmpty;

  Future<void> _send() async {
    final email = _emailCtrl.text.trim();
    if (email.isNotEmpty && !isValidFeedbackEmail(email)) {
      setState(() => _emailInvalid = true);
      return;
    }
    setState(() {
      _emailInvalid = false;
      _sending = true;
    });
    try {
      await ref
          .read(feedbackServiceProvider)
          .send(
            category: _category,
            message: _messageCtrl.text,
            email: email,
            includeDiagnostics: _includeDiagnostics,
          );
      if (!mounted) return;
      context.pop();
      showPlatformSnackBar(context, context.l10n.feedbackSent);
    } on FeedbackException catch (e) {
      if (!mounted) return;
      setState(() => _sending = false);
      showPlatformSnackBar(context, switch (e.failure) {
        .rateLimited => context.l10n.feedbackRateLimited,
        .failed =>
          _supportEmail.isEmpty
              ? context.l10n.feedbackFailedNoEmail
              : context.l10n.feedbackFailed(_supportEmail),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final diagnostics = ref.watch(feedbackDiagnosticsProvider);

    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(
        title: Text(l10n.feedbackScreenTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _sending
                ? const Center(
                    child: SizedBox.square(
                      dimension: 20,
                      child: AdaptiveProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : AdaptiveTextButton(
                    onPressed: _canSend ? _send : null,
                    child: Text(l10n.feedbackSendButton),
                  ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(l10n.feedbackIntro, style: textTheme.bodyMedium),
          const SizedBox(height: 24),
          Text(l10n.feedbackCategoryLabel, style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final category in FeedbackCategory.values)
                AdaptiveFilterChip(
                  label: category.label(l10n),
                  selected: _category == category,
                  onSelected: (_) => setState(() => _category = category),
                ),
            ],
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _messageCtrl,
            enabled: !_sending,
            decoration: InputDecoration(
              labelText: l10n.feedbackMessageLabel,
              hintText: _category.hint(l10n),
              alignLabelWithHint: true,
            ),
            minLines: 5,
            maxLines: 10,
            maxLength: feedbackMessageMaxLength,
            textCapitalization: .sentences,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _emailCtrl,
            enabled: !_sending,
            decoration: InputDecoration(
              labelText: l10n.feedbackEmailLabel,
              helperText: l10n.feedbackEmailHelper,
              errorText: _emailInvalid ? l10n.feedbackEmailInvalid : null,
            ),
            keyboardType: .emailAddress,
            autocorrect: false,
            onChanged: (_) {
              if (_emailInvalid) setState(() => _emailInvalid = false);
            },
          ),
          const SizedBox(height: 16),
          AdaptiveSwitchListTile(
            title: Text(l10n.feedbackIncludeDiagnostics),
            value: _includeDiagnostics,
            onChanged: _sending
                ? null
                : (v) => setState(() => _includeDiagnostics = v),
          ),
          if (_includeDiagnostics)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                diagnostics.values.join(' · '),
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          if (_supportEmail.isNotEmpty) ...[
            const SizedBox(height: 32),
            Center(
              child: AdaptiveTextButton(
                onPressed: () =>
                    launchUrl(Uri(scheme: 'mailto', path: _supportEmail)),
                child: Text(l10n.feedbackEmailFallback(_supportEmail)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

extension on FeedbackCategory {
  String label(AppLocalizations l10n) => switch (this) {
    .bug => l10n.feedbackCategoryBug,
    .suggestion => l10n.feedbackCategorySuggestion,
    .content => l10n.feedbackCategoryContent,
    .other => l10n.feedbackCategoryOther,
  };

  String hint(AppLocalizations l10n) => switch (this) {
    .bug => l10n.feedbackHintBug,
    .suggestion => l10n.feedbackHintSuggestion,
    .content => l10n.feedbackHintContent,
    .other => l10n.feedbackHintOther,
  };
}
