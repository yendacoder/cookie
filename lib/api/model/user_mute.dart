import 'package:cookie/api/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_mute.g.dart';

@JsonSerializable()
class UserMute {
  UserMute(
    this.id,
    this.type,
    this.mutedUserId,
    this.createdAt,
    this.mutedUser,
  );

  final String id;
  final String type;
  final String mutedUserId;
  final DateTime createdAt;
  final User mutedUser;

  factory UserMute.fromJson(Map<String, dynamic> json) => _$UserMuteFromJson(json);
}
