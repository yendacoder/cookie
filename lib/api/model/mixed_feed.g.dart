// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mixed_feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MixedFeed _$MixedFeedFromJson(Map<String, dynamic> json) => MixedFeed(
      (json['items'] as List<dynamic>?)
          ?.map((e) => FeedItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['next'] as String?,
    );

Map<String, dynamic> _$MixedFeedToJson(MixedFeed instance) => <String, dynamic>{
      'items': instance.items,
      'next': instance.next,
    };
