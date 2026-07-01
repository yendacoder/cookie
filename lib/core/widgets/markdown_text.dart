import 'package:cookie/features/posts/screens/post_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';

class _MentionSyntax extends md.InlineSyntax {
  // Matches @username — adjust the character class to your username rules
  _MentionSyntax() : super(r'@([\w]+(?:\.[\w]+)*)');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final username = match[1]!;
    final anchor = md.Element('a', [md.Text('@$username')])
      ..attributes['href'] = 'mention://$username';
    parser.addNode(anchor);
    return true;
  }
}

/// Renders markdown using project-wide typography and colour settings.
///
/// [selectable] enables text selection — use it in full-read contexts
/// (post body, post detail comments).
///
/// [baseStyle] overrides the base paragraph style so the widget can be used
/// at both [bodyMedium] (post body) and [bodySmall] (comment body) sizes.
class MarkdownText extends StatelessWidget {
  const MarkdownText(
    this.data, {
    super.key,
    this.selectable = false,
    this.baseStyle,
  });

  final String data;
  final bool selectable;

  /// Overrides the paragraph/list/table base text style.
  /// Defaults to [TextTheme.bodyMedium] when null.
  final TextStyle? baseStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final base = baseStyle ?? textTheme.bodyMedium ?? const TextStyle();

    final styleSheet = MarkdownStyleSheet.fromTheme(theme).copyWith(
      p: base,
      listBullet: base,
      blockquote: base.copyWith(
        color: colorScheme.onSurfaceVariant,
        fontStyle: FontStyle.italic,
      ),
      tableBody: base,
      // Links use the primary colour instead of the hardcoded blue default.
      a: base.copyWith(
        color: colorScheme.primary,
        decoration: TextDecoration.underline,
        decorationColor: colorScheme.primary,
      ),
      // Inline code: monospace with a subtle surface tint.
      code: base.copyWith(
        fontFamily: 'monospace',
        fontSize: (base.fontSize ?? 14) * 0.85,
        backgroundColor: colorScheme.surfaceContainerHighest,
        color: colorScheme.onSurfaceVariant,
      ),
      // Code blocks: padded box matching the inline code tint.
      codeblockPadding: const EdgeInsets.all(12),
      codeblockDecoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
      ),
      // Blockquote: left-border accent instead of blue background.
      blockquotePadding: const EdgeInsets.only(left: 12, top: 4, bottom: 4),
      blockquoteDecoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: colorScheme.outlineVariant, width: 3),
        ),
      ),
      // Horizontal rule using the theme divider colour.
      horizontalRuleDecoration: BoxDecoration(
        border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
      ),
    );

    return MarkdownBody(
      data: data,
      selectable: selectable,
      styleSheet: styleSheet,
      inlineSyntaxes: [_MentionSyntax()],
      onTapLink: (text, href, title) {
        if (href == null) return;
        if (href.startsWith('mention://')) {
          final username = href.substring('mention://'.length);
          context.push('/u/$username');
        } else {
          Uri? uri = Uri.tryParse(href);
          if (uri != null) {
            if (!uri.isAbsolute ||
                uri.host.endsWith('discuit.org') ||
                uri.host.endsWith('discuit.net')) {
              if (uri.pathSegments.length == 1) {
                // user or community
                final segment = uri.pathSegments.first;
                if (segment.startsWith('@')) {
                  context.push('/u/${segment.substring(1)}');
                } else {
                  context.push('/c/$segment');
                }
              } else if (uri.pathSegments.length == 3) {
                // post
                context.push(
                  '/c/${uri.pathSegments.first}/post/${uri.pathSegments.last}',
                );
              } else if (uri.pathSegments.length == 4) {
                // comment
                context.push(
                  '/c/${uri.pathSegments.first}/post/${uri.pathSegments[2]}',
                  extra: PostDetailArgs(
                    highlightCommentId: uri.pathSegments.last,
                  ),
                );
              } else {
                // God knows what
                if (!uri.isAbsolute) {
                  uri = Uri.tryParse('https://discuit.org/$href');
                }
                if (uri != null) {
                  launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              }
            } else {
              launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          }
        }
      },
    );
  }
}
