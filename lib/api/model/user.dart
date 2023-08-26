import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User(
      this.id,
      this.username,
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
      this.moddingList
      );

  String id;
  String username;
  String? email;
  String? emailConfirmedAt;
  String? aboutMe;
  int points;
  bool isAdmin;
  int noPosts;
  int noComments;
  String createdAt;
  String? deletedAt;
  bool isBanned;
  String? bannedAt;
  int notificationsNewCount;
  List<String>? moddingList;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}