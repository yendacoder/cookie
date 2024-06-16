import 'package:cookie/api/model/comment.dart';
import 'package:cookie/api/model/post.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feed_item.g.dart';

@JsonSerializable()
class FeedItem {
  FeedItem(this.item, this.type) {
    if (type == 'post') {
      itemObject = Post.fromJson(item);
    } else if (type == 'comment') {
      itemObject = Comment.fromJson(item);
    } else {
      itemObject = null;
    }
  }

  final Map<String, dynamic> item;
  @JsonKey(includeFromJson: false)
  late final dynamic itemObject;
  final String type;


  factory FeedItem.fromJson(Map<String, dynamic> json) => _$FeedItemFromJson(json);
}