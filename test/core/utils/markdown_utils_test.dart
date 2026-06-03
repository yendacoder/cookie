import 'package:cookie/core/utils/markdown_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('markdownToPlainText', () {
    test('returns empty string for empty input', () {
      expect(markdownToPlainText(''), '');
    });

    test('passes through plain text unchanged', () {
      expect(markdownToPlainText('Hello world'), 'Hello world');
    });

    test('strips bold markers', () {
      expect(markdownToPlainText('**bold**'), 'bold');
    });

    test('strips italic markers', () {
      expect(markdownToPlainText('*italic*'), 'italic');
    });

    test('strips inline code backticks', () {
      expect(markdownToPlainText('use `null`'), 'use null');
    });

    test('strips heading markers', () {
      expect(markdownToPlainText('# Title'), 'Title');
      expect(markdownToPlainText('## Sub'), 'Sub');
    });

    test('extracts link label, discards URL', () {
      expect(
        markdownToPlainText('[click here](https://example.com)'),
        'click here',
      );
    });

    test('collapses paragraph breaks into a single space', () {
      expect(markdownToPlainText('first\n\nsecond'), 'first second');
    });

    test('collapses multiple whitespace chars', () {
      expect(markdownToPlainText('a   b'), 'a b');
    });

    test('trims leading and trailing whitespace', () {
      expect(markdownToPlainText('  hello  '), 'hello');
    });

    test('strips single-line HTML comment', () {
      expect(
        markdownToPlainText('before\n<!-- hidden -->\nafter'),
        'before after',
      );
    });

    test('strips multi-line HTML comment', () {
      expect(
        markdownToPlainText('before\n<!--\nhidden\n-->\nafter'),
        'before after',
      );
    });

    test('list items appear separated by spaces', () {
      final result = markdownToPlainText('- item one\n- item two');
      expect(result, contains('item one'));
      expect(result, contains('item two'));
    });

    test('blockquote content is preserved', () {
      expect(markdownToPlainText('> quoted text'), 'quoted text');
    });

    test('mixed formatting is fully stripped', () {
      final input = '**Bold** and *italic* with [a link](https://x.com).';
      expect(markdownToPlainText(input), 'Bold and italic with a link.');
    });
  });
}
