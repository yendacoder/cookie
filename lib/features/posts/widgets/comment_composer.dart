import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_progress_indicator.dart';
import 'package:cookie/models/comment.dart';
import 'package:flutter/material.dart';

// ── Comment composer ──────────────────────────────────────────────────────────

class CommentComposer extends StatelessWidget {
  const CommentComposer({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.replyToComment,
    required this.isSubmitting,
    required this.onCancelReply,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final Comment? replyToComment;
  final bool isSubmitting;
  final VoidCallback onCancelReply;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final canSend = controller.text.trim().isNotEmpty && !isSubmitting;

        return Material(
          color: colorScheme.surface,
          elevation: 4,
          shadowColor: Colors.transparent,
          surfaceTintColor: colorScheme.surfaceTint,
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (replyToComment != null)
                  _ReplyChip(
                    username: replyToComment!.username,
                    onCancel: onCancelReply,
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
                  child: Row(
                    crossAxisAlignment: .center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            hintText: context.l10n.commentHint,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: colorScheme.outline,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            isDense: true,
                          ),
                          minLines: 1,
                          maxLines: 5,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.newline,
                        ),
                      ),
                      const SizedBox(width: 4),
                      SizedBox(
                        height: 44,
                        child: IconButton(
                          icon: isSubmitting
                              ? SizedBox.square(
                                  dimension: 20,
                                  child: AdaptiveProgressIndicator(
                                    strokeWidth: 2,
                                    color: colorScheme.primary,
                                  ),
                                )
                              : Icon(
                                  Icons.send_rounded,
                                  color: canSend
                                      ? colorScheme.primary
                                      : colorScheme.onSurface.withValues(
                                          alpha: 0.38,
                                        ),
                                ),
                          onPressed: canSend ? onSubmit : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ReplyChip extends StatelessWidget {
  const _ReplyChip({required this.username, required this.onCancel});

  final String username;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final muted = colorScheme.onSurfaceVariant;

    return ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 4, 4),
        child: Row(
          children: [
            Icon(Icons.reply_rounded, size: 14, color: muted),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                context.l10n.commentReplyingTo(username),
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: muted),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              onPressed: onCancel,
              icon: Icon(context.closeIcon, size: 16, color: muted),
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
