import 'package:markdown/markdown.dart' as md;

/// Converts a markdown string to plain text by walking the parsed AST.
///
/// Block-level elements (paragraphs, headings, list items, etc.) are separated
/// by a space so sentences from adjacent blocks don't run together. The result
/// is then whitespace-collapsed and trimmed, making it safe to display in a
/// single-line or clamped [Text] widget.
String markdownToPlainText(String source) {
  final nodes = md.Document(
    extensionSet: md.ExtensionSet.gitHubFlavored,
  ).parseLines(source.split('\n'));

  final buffer = StringBuffer();
  _extractText(nodes, buffer);
  return buffer.toString().replaceAll(RegExp(r'\s+'), ' ').trim();
}

void _extractText(List<md.Node> nodes, StringBuffer buffer) {
  for (final node in nodes) {
    if (node is md.Text) {
      buffer.write(node.text);
    } else if (node is md.Element) {
      _extractText(node.children ?? [], buffer);
      if (_isBlock(node.tag)) buffer.write(' ');
    }
  }
}

bool _isBlock(String tag) => const {
      'p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6',
      'li', 'blockquote', 'pre', 'hr',
    }.contains(tag);
