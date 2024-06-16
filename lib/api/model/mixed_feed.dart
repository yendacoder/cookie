import 'package:cookie/api/model/feed_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mixed_feed.g.dart';

@JsonSerializable()
class MixedFeed {
  const MixedFeed(this.items, this.next);

  final List<FeedItem>? items;
  final String? next;

  factory MixedFeed.fromJson(Map<String, dynamic> json) =>
      _$MixedFeedFromJson(json);
}
