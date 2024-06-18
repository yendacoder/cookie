import 'package:cookie/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OverflowMarkdown extends MarkdownBody {
  const OverflowMarkdown({
    super.key,
    required super.data,
    super.selectable,
    super.softLineBreak,
    super.styleSheet,
    super.styleSheetTheme,
    super.syntaxHighlighter,
    super.onTapLink,
    super.onTapText,
    super.imageDirectory,
    super.blockSyntaxes,
    super.inlineSyntaxes,
    super.extensionSet,
    super.imageBuilder,
    super.checkboxBuilder,
    super.builders,
    super.listItemCrossAxisAlignment,
    this.maxLines,
    this.overflow,
  });

  final TextOverflow? overflow;
  final int? maxLines;

  T? _findWidgetOfType<T>(Widget? widget) {
    if (widget is T) {
      return widget as T;
    }

    if (widget is MultiChildRenderObjectWidget) {
      final MultiChildRenderObjectWidget multiChild = widget;
      for (final Widget child in multiChild.children) {
        return _findWidgetOfType<T>(child);
      }
    } else if (widget is SingleChildRenderObjectWidget) {
      final SingleChildRenderObjectWidget singleChild = widget;
      return _findWidgetOfType<T>(singleChild.child!);
    }

    return null;
  }

  @override
  Widget build(BuildContext context, List<Widget>? children) {
    if (children?.isNotEmpty == true && maxLines != null) {
      final RichText? richText = _findWidgetOfType<RichText>(children?.first);
      if (richText != null) {
        return RichText(
          text: richText.text,
          textScaler: richText.textScaler,
          textAlign: richText.textAlign,
          maxLines: maxLines,
          overflow: overflow ?? TextOverflow.visible,
        );
      }
    }
    return super.build(context, children);
  }
}

/// Default text view that uses markdown-style user formatting
class MarkdownText extends StatelessWidget {
  const MarkdownText(
    this.text, {
    super.key,
    this.style,
    this.strongStyle,
    this.emStyle,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final TextStyle? style;
  final TextStyle? strongStyle;
  final TextStyle? emStyle;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final linkColor = theme.brightness == Brightness.dark
        ? kLinkTextColorDark
        : kLinkTextColorLight;
    final baseStyle = style ?? theme.textTheme.bodyMedium;
    return OverflowMarkdown(
      // softLineBreak: true,
      maxLines: maxLines,
      overflow: overflow,
      styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
          p: baseStyle,
          em: emStyle ?? baseStyle?.copyWith(fontStyle: FontStyle.italic),
          strong:
              strongStyle ?? baseStyle?.copyWith(fontWeight: FontWeight.bold),
          blockquotePadding: const EdgeInsets.all(kSecondaryPadding),
          blockquoteDecoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(kDefaultCornerRadius)),
          a: baseStyle?.copyWith(
              decoration: TextDecoration.underline, color: linkColor)),
      data: text,
      onTapLink: (text, ref, title) {
        if (ref != null) {
          if (text.toLowerCase().startsWith('http')) {
            launchUrlString(text, mode: LaunchMode.externalApplication);
          } else {
            launchUrlString(ref, mode: LaunchMode.externalApplication);
          }
        }
      },
    );
  }
}
