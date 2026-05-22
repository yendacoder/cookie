import 'dart:io';

import 'package:cookie/features/communities/providers/community_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/api/api_client.dart';
import '../../../core/extensions/build_context_ext.dart';
import '../../../core/widgets/avatar.dart';
import '../../../core/widgets/markdown_text.dart';
import '../../../models/community.dart';
import '../../../models/discuit_image.dart';
import '../../../models/post.dart';

// ── Image entry ───────────────────────────────────────────────────────────────

class _ImageEntry {
  _ImageEntry({required this.file}) : altCtrl = TextEditingController();

  final File file;
  final TextEditingController altCtrl;
}

// ── Post type ─────────────────────────────────────────────────────────────────

enum _PostType { text, image }

// ── Screen ────────────────────────────────────────────────────────────────────

class ComposeScreen extends ConsumerStatefulWidget {
  const ComposeScreen({super.key, this.community, this.editingPost});

  final Community? community;

  /// When set the screen is in edit mode: community and type are locked,
  /// and submit calls PUT instead of POST.
  final Post? editingPost;

  @override
  ConsumerState<ComposeScreen> createState() => _ComposeScreenState();
}

class _ComposeScreenState extends ConsumerState<ComposeScreen> {
  Community? _community;
  final _titleCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController();
  var _type = _PostType.text;
  final _images = <_ImageEntry>[];
  bool _submitting = false;
  bool _isUrlBody = false;
  bool _loadingCommunity = false;

  bool get _isEditing => widget.editingPost != null;

  @override
  void initState() {
    super.initState();
    _community = widget.community;
    final post = widget.editingPost;
    if (post != null) {
      _titleCtrl.text = post.title;
      _bodyCtrl.text = post.body ?? '';
    }
    _titleCtrl.addListener(_refresh);
    _bodyCtrl.addListener(_onBodyChanged);
  }

  void _refresh() => setState(() {});

  void _onBodyChanged() {
    final text = _bodyCtrl.text.trim();
    final uri = Uri.tryParse(text);
    final isUrl =
        uri != null &&
        (uri.scheme == 'https' || uri.scheme == 'http') &&
        uri.host.isNotEmpty;
    if (isUrl != _isUrlBody) setState(() => _isUrlBody = isUrl);
  }

  Future<void> _selectCommunity() async {
    final result = await context.push<Community>('/communities', extra: true);
    if (result != null) {
      setState(() {
        _loadingCommunity = true;
        _community = result;
      });
      try {
        final res = await ref.read(communityDetailProvider(result.name).future);
        if (mounted) {
          _loadingCommunity = false;
          setState(() => _community = res);
        }
      } catch (e) {
        setState(() => _loadingCommunity = false);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(e.toString())));
        }
      }
    }
  }

  Future<void> _addImage() async {
    if (_images.length >= 10) return;
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null && mounted) {
      setState(() => _images.add(_ImageEntry(file: File(picked.path))));
    }
  }

  void _removeImage(int index) {
    _images[index].altCtrl.dispose();
    setState(() => _images.removeAt(index));
  }

  void _showPreview() {
    showDialog<void>(
      context: context,
      builder: (ctx) => _PreviewDialog(body: _bodyCtrl.text),
    );
  }

  bool get _canSubmit {
    if (_submitting) return false;
    if (_titleCtrl.text.trim().isEmpty) return false;
    if (_isEditing) return true;
    if (_community == null) return false;
    if (_type == _PostType.image && _images.isEmpty) return false;
    return true;
  }

  Future<void> _submit() async {
    if (!_canSubmit) return;
    setState(() => _submitting = true);

    try {
      final api = ref.read(apiClientProvider);
      final title = _titleCtrl.text.trim();

      if (_isEditing) {
        final post = widget.editingPost!;
        await api.put(
          'posts/${post.publicId}',
          data: {
            'title': title,
            if (post.type == 'text') 'body': _bodyCtrl.text.trim(),
          },
        );
        if (mounted) context.pop();
        return;
      }

      final communityName = _community!.name;
      Post newPost;

      if (_type == _PostType.image) {
        final uploaded = <Map<String, String>>[];
        for (final entry in _images) {
          final formData = FormData.fromMap({
            'image': await MultipartFile.fromFile(
              entry.file.path,
              filename: entry.file.path.split('/').last,
            ),
          });
          final res = await api.post('_uploads', data: formData);
          final imageId = (res.data as Map<String, dynamic>)['id'] as String;
          uploaded.add({'imageId': imageId});

          if (entry.altCtrl.text.trim().isNotEmpty) {
            await api.put(
              'images/$imageId',
              data: {'altText': entry.altCtrl.text},
            );
          }
        }
        final res = await api.post(
          'posts',
          data: {
            'type': 'image',
            'title': title,
            'community': communityName,
            'images': uploaded,
          },
        );
        newPost = Post.fromJson(res.data as Map<String, dynamic>);
      } else {
        final body = _bodyCtrl.text.trim();
        final res = await api.post(
          'posts',
          data: {
            'type': _isUrlBody ? 'link' : 'text',
            'title': title,
            'community': communityName,
            if (_isUrlBody) 'url': body,
            if (!_isUrlBody && body.isNotEmpty) 'body': body,
          },
        );
        newPost = Post.fromJson(res.data as Map<String, dynamic>);
      }

      if (mounted) {
        context.pop();
        context.push(
          '/c/${newPost.communityName}/post/${newPost.publicId}',
          extra: newPost,
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _submitting = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _bodyCtrl.dispose();
    for (final img in _images) {
      img.altCtrl.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? l10n.composeEditTitle : l10n.composeScreenTitle,
        ),
        actions: [
          if (_submitting)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            )
          else
            TextButton(
              onPressed: _canSubmit ? _submit : null,
              child: Text(l10n.composeSubmitButton),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          // ── Community selector ────────────────────────────────────────
          if (_isEditing)
            ListTile(
              leading: Avatar(
                radius: 16,
                imageUrl: widget.editingPost!.communityProPic?.fullUrl,
                fallback: widget.editingPost!.communityName,
              ),
              title: Text(
                widget.editingPost!.communityName,
                style: textTheme.bodyMedium,
              ),
            )
          else
            ListTile(
              leading: _loadingCommunity
                  ? SizedBox.square(
                      dimension: 16,
                      child: CircularProgressIndicator(),
                    )
                  : Avatar(
                      radius: 16,
                      imageUrl: _community?.proPic?.fullUrl,
                      fallback: _community?.name ?? '',
                    ),
              title: Text(
                _community?.name ?? l10n.composeCommunityHint,
                style: _community == null
                    ? textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      )
                    : textTheme.bodyMedium,
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: _selectCommunity,
            ),

          // ── Community rules ───────────────────────────────────────────
          if (!_isEditing && _community != null && _community!.rules.isNotEmpty)
            _RulesSection(rules: _community!.rules),

          const Divider(height: 1),

          // ── Type toggle (hidden when editing) ────────────────────────
          if (!_isEditing) ...[
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SegmentedButton<_PostType>(
                segments: [
                  ButtonSegment(
                    value: _PostType.text,
                    icon: const Icon(Icons.text_fields_outlined),
                    label: Text(l10n.composeTypeText),
                  ),
                  ButtonSegment(
                    value: _PostType.image,
                    icon: const Icon(Icons.image_outlined),
                    label: Text(l10n.composeTypeImage),
                  ),
                ],
                selected: {_type},
                onSelectionChanged: (sel) => setState(() => _type = sel.first),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // ── Title ─────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              controller: _titleCtrl,
              decoration: InputDecoration(
                labelText: l10n.composeTitleHint,
                border: const OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              style: textTheme.titleMedium,
              maxLines: 3,
              minLines: 1,
              textCapitalization: TextCapitalization.sentences,
            ),
          ),

          const SizedBox(height: 16),

          // ── Content ───────────────────────────────────────────────────
          if (_isEditing) ...[
            // Text posts: editable body with preview/help toolbar.
            // Link and image posts: title-only editing (body/images not supported by API).
            if (widget.editingPost!.type == 'text') ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _bodyCtrl,
                  decoration: InputDecoration(
                    labelText: l10n.composeBodyHint,
                    border: const OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  style: textTheme.bodyMedium,
                  minLines: 5,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: _showPreview,
                      label: Text(l10n.composePreviewTitle),
                      icon: const Icon(Icons.preview_outlined),
                    ),
                  ],
                ),
              ),
              _MarkdownGuide(),
            ],
          ] else if (_type == _PostType.text) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _bodyCtrl,
                decoration: InputDecoration(
                  labelText: l10n.composeBodyHint,
                  border: const OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                style: textTheme.bodyMedium,
                maxLines: null,
                minLines: 5,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            if (_isUrlBody)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  children: [
                    Icon(
                      Icons.link_rounded,
                      size: 14,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      l10n.composeUrlDetected,
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: _showPreview,
                    label: Text(l10n.composePreviewTitle),
                    icon: const Icon(Icons.preview_outlined),
                  ),
                ],
              ),
            ),
            _MarkdownGuide(),
          ] else ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (int i = 0; i < _images.length; i++)
                    _ImageEntryTile(
                      entry: _images[i],
                      onRemove: () => _removeImage(i),
                    ),
                  if (_images.length < 10)
                    OutlinedButton.icon(
                      onPressed: _addImage,
                      icon: const Icon(Icons.add_photo_alternate_outlined),
                      label: Text(l10n.composeAddImage),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Rules section ─────────────────────────────────────────────────────────────

class _RulesSection extends StatelessWidget {
  const _RulesSection({required this.rules});

  final List<CommunityRule> rules;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return ExpansionTile(
      leading: const Icon(Icons.gavel_outlined),
      title: Text(context.l10n.communityRulesTitle),
      children: [
        for (int i = 0; i < rules.length; i++)
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            dense: true,
            title: Text(
              '${i + 1}. ${rules[i].rule}',
              style: textTheme.bodySmall,
            ),
            subtitle: (rules[i].description?.isNotEmpty ?? false)
                ? Text(
                    rules[i].description!,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  )
                : null,
          ),
        const SizedBox(height: 8),
      ],
    );
  }
}

// ── Image entry tile ──────────────────────────────────────────────────────────

class _ImageEntryTile extends StatelessWidget {
  const _ImageEntryTile({required this.entry, required this.onRemove});

  final _ImageEntry entry;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ColoredBox(
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                child: Image.file(entry.file, fit: .contain),
              ),
            ),
          ),
          const SizedBox(height: 12),

          TextField(
            controller: entry.altCtrl,
            decoration: InputDecoration(
              hintText: context.l10n.composeAltTextHint,
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 5,
            minLines: 1,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onRemove,
              icon: const Icon(Icons.delete_outline, size: 16),
              label: Text(context.l10n.listItemRemove),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Preview dialog ────────────────────────────────────────────────────────────

class _PreviewDialog extends StatelessWidget {
  const _PreviewDialog({required this.body});

  final String body;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isEmpty = body.trim().isEmpty;

    return AlertDialog(
      title: Text(l10n.composePreviewTitle),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: isEmpty
              ? Text(
                  l10n.composePreviewEmpty,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                )
              : MarkdownText(body, selectable: true),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.confirmButton),
        ),
      ],
    );
  }
}

// ── Markdown guide dialog ─────────────────────────────────────────────────────

class _MarkdownGuide extends StatelessWidget {
  const _MarkdownGuide();

  static const _entries = [
    ('**bold**', 'Bold'),
    ('*italic*', 'Italic'),
    ('~~strikethrough~~', 'Strikethrough'),
    ('# Heading', 'Heading (# to ######)'),
    ('> quote', 'Blockquote'),
    ('`code`', 'Inline code'),
    ('```\ncode block\n```', 'Code block'),
    ('[text](url)', 'Link'),
    ('- item', 'Unordered list'),
    ('1. item', 'Ordered list'),
    ('---', 'Horizontal rule'),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            'Formatting guide',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _entries.length,
            separatorBuilder: (_, _) => const Divider(height: 12),
            itemBuilder: (_, i) {
              final (syntax, description) = _entries[i];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      syntax,
                      style: textTheme.bodySmall?.copyWith(
                        fontFamily: 'monospace',
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(description, style: textTheme.bodySmall),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
