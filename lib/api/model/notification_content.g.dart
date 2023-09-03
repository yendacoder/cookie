// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationContent _$NotificationContentFromJson(Map<String, dynamic> json) =>
    NotificationContent(
      json['addedBy'] as String?,
      json['commentAuthor'] as String?,
      json['postId'] as String?,
      json['post'] == null
          ? null
          : Post.fromJson(json['post'] as Map<String, dynamic>),
      json['communityId'] as String?,
      json['community'] == null
          ? null
          : Community.fromJson(json['community'] as Map<String, dynamic>),
      json['commentId'] as String?,
    );

Map<String, dynamic> _$NotificationContentToJson(
        NotificationContent instance) =>
    <String, dynamic>{
      'addedBy': instance.addedBy,
      'commentAuthor': instance.commentAuthor,
      'postId': instance.postId,
      'post': instance.post,
      'communityId': instance.communityId,
      'community': instance.community,
      'commentId': instance.commentId,
    };
