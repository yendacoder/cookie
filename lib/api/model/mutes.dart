import 'package:cookie/api/model/community.dart';
import 'package:cookie/api/model/community_mute.dart';
import 'package:cookie/api/model/user.dart';
import 'package:cookie/api/model/user_mute.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mutes.g.dart';

@JsonSerializable()
class Mutes {
  Mutes(this.communityMutes, this.userMutes);

  List<CommunityMute> communityMutes;
  List<UserMute> userMutes;

  factory Mutes.fromJson(Map<String, dynamic> json) => _$MutesFromJson(json);
}
