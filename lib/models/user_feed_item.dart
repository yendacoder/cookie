import 'comment.dart';
import 'post.dart';

sealed class UserFeedItem {
  const UserFeedItem();
}

final class UserFeedPost extends UserFeedItem {
  const UserFeedPost(this.post);

  final Post post;
}

final class UserFeedComment extends UserFeedItem {
  const UserFeedComment(this.comment);

  final Comment comment;
}
