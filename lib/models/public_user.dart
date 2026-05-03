import 'package:freezed_annotation/freezed_annotation.dart';

import 'discuit_image.dart';
import 'user.dart';

part 'public_user.freezed.dart';
part 'public_user.g.dart';

@freezed
abstract class PublicUser with _$PublicUser {
  const factory PublicUser({
    required String id,
    required String username,
    String? aboutMe,
    required int points,
    required bool isAdmin,
    DiscuitImage? proPic,
    @Default([]) List<Badge> badges,
    required int noPosts,
    required int noComments,
    required DateTime createdAt,
    required bool deleted,
    DateTime? deletedAt,
    DateTime? bannedAt,
    required bool isBanned,
  }) = _PublicUser;

  factory PublicUser.fromJson(Map<String, dynamic> json) =>
      _$PublicUserFromJson(json);
}
