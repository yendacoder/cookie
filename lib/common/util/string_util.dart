

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