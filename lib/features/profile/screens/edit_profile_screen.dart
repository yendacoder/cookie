import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/extensions/build_context_ext.dart';
import '../../../core/widgets/adaptive/adaptive_app_bar.dart';
import '../../../core/widgets/adaptive/adaptive_button.dart';
import '../../../core/widgets/adaptive/adaptive_ink_well.dart';
import '../../../core/widgets/adaptive/adaptive_progress_indicator.dart';
import '../../../core/widgets/adaptive/adaptive_scaffold.dart';
import '../../../core/widgets/adaptive/adaptive_snackbar.dart';
import '../../../models/discuit_image.dart';
import '../../auth/providers/auth_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late final TextEditingController _aboutMeCtrl;
  File? _selectedImage;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authProvider).value;
    _aboutMeCtrl = TextEditingController(text: user?.aboutMe ?? '');
  }

  @override
  void dispose() {
    _aboutMeCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );
    if (image != null && mounted) {
      setState(() => _selectedImage = File(image.path));
    }
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      if (_selectedImage != null) {
        await ref
            .read(authProvider.notifier)
            .updateProfilePicture(_selectedImage!.path);
      }
      await ref
          .read(authProvider.notifier)
          .updateProfile(aboutMe: _aboutMeCtrl.text.trim());
      if (mounted) {
        context.pop();
        showPlatformSnackBar(context, context.l10n.profileSaved);
      }
    } catch (_) {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).value;
    if (user == null) return const Scaffold();

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AdaptiveScaffold(
      appBar: AdaptiveAppBar(
        title: Text(context.l10n.editProfileTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _saving
                ? const Center(
                    child: SizedBox.square(
                      dimension: 20,
                      child: AdaptiveProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : AdaptiveTextButton(
                    onPressed: _save,
                    child: Text(context.l10n.saveButton),
                  ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // ── Profile picture ──────────────────────────────────────────────
          Center(
            child: AdaptiveInkWell(
              onTap: _picking ? null : _pickImage,
              customBorder: const CircleBorder(),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 52,
                    backgroundColor: colorScheme.primaryContainer,
                    child: _avatarChild(
                      user.proPic,
                      colorScheme,
                      textTheme,
                      user.username,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.surface,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 16,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              context.l10n.editProfilePictureLabel,
              style: textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 32),

          // ── About me ─────────────────────────────────────────────────────
          TextField(
            controller: _aboutMeCtrl,
            decoration: InputDecoration(
              labelText: context.l10n.editProfileDescriptionLabel,
              hintText: context.l10n.editProfileDescriptionHint,
              alignLabelWithHint: true,
            ),
            maxLines: 6,
            maxLength: 10000,
            textCapitalization: TextCapitalization.sentences,
          ),
        ],
      ),
    );
  }

  bool get _picking => false;

  Widget _avatarChild(
    DiscuitImage? proPic,
    ColorScheme colorScheme,
    TextTheme textTheme,
    String username,
  ) {
    if (_selectedImage != null) {
      return ClipOval(
        child: Image.file(
          _selectedImage!,
          width: 104,
          height: 104,
          fit: BoxFit.cover,
        ),
      );
    }
    if (proPic != null) {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: proPic.fullUrl,
          width: 104,
          height: 104,
          fit: BoxFit.cover,
        ),
      );
    }
    return Text(
      username.isNotEmpty ? username[0].toUpperCase() : '?',
      style: textTheme.headlineMedium?.copyWith(
        color: colorScheme.onPrimaryContainer,
      ),
    );
  }
}
