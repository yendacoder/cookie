import 'package:cookie/api/model/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feed.g.dart';

@JsonSerializable()
class Feed {
  const Feed(this.posts, this.next);

  final List<Post>? posts;
  final String? next;

  factory Feed.fromJson(Map<String, dynamic> json) => _$FeedFromJson(json);
}