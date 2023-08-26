

String formatRating(int upvotes, int downvotes) {
  int rating = upvotes - downvotes;
  if (rating > 0) {
    return '+$rating';
  }
  return rating.toString();
}