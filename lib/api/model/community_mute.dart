import 'package:cookie/api/model/community.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community_mute.g.dart';

@JsonSerializable()
class CommunityMute {
  CommunityMute(
      this.id,
      this.mutedCommunityId,
      this.createdAt,
      this.mutedCommunity,
      );

  final String id;
  final String mutedCommunityId;
  final DateTime createdAt;
  final Community mutedCommunity;

  factory CommunityMute.fromJson(Map<String, dynamic> json) => _$CommunityMuteFromJson(json);
}
