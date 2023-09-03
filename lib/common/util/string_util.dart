

String formatRating(int upvotes, int downvotes) {
  int rating = upvotes - downvotes;
  if (rating > 0) {
    return '+$rating';
  }
  return rating.toString();
}

bool isImageUrl(String url) {
  url = url.toLowerCase();
  return url.endsWith('.jpg') ||
      url.endsWith('.jpeg') ||
      url.endsWith('.png') ||
      url.endsWith('.webp');
}

bool isAbsoluteUrl(String url) {
  return url.startsWith('http://') || url.startsWith('https://');
}

extension StringUtil on String {
  bool isUpperCase() {
    return this == toUpperCase();
  }

  /// From https://pub.dev/packages/basic_utils
  /// Converts a string from camel case to snake case.
  /// The library doesn't have the reverse conversion
  String camelCaseToSnakeCase() {
    var sb = StringBuffer();
    var first = true;
    for (var rune in runes) {
      var char = String.fromCharCode(rune);
      if (char.isUpperCase() && !first) {
        if (char != '_') {
          sb.write('_');
        }
        sb.write(char.toLowerCase());
      } else {
        first = false;
        sb.write(char.toLowerCase());
      }
    }
    return sb.toString();
  }

  String snakeCaseToCamelCase() {
    var sb = StringBuffer();
    var capitalize = false;
    for (var rune in runes) {
      var char = String.fromCharCode(rune);
      if (char == '_') {
        capitalize = true;
      } else {
        if (capitalize) {
          sb.write(char.toUpperCase());
          capitalize = false;
        } else {
          sb.write(char);
        }
      }
    }
    return sb.toString();
  }
}