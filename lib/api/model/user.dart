import 'package:cookie/api/model/image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User(
    this.id,
    this.username,
    this.proPic,
    this.email,
    this.emailConfirmedAt,
    this.aboutMe,
    this.points,
    this.isAdmin,
    this.noPosts,
    this.noComments,
    this.createdAt,
    this.deletedAt,
    this.isBanned,
    this.bannedAt,
    this.notificationsNewCount,
    this.moddingList,
  );

  final String id;
  final String username;
  final Image? proPic;
  final String? email;
  final String? emailConfirmedAt;
  final String? aboutMe;
  final int points;
  final bool isAdmin;
  final int noPosts;
  final int noComments;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final bool isBanned;
  final DateTime? bannedAt;
  final int notificationsNewCount;
  // modding list can be either the list of names or objects
  final List<dynamic>? moddingList;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}