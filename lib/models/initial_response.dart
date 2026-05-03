import 'package:freezed_annotation/freezed_annotation.dart';

import 'community.dart';
import 'user.dart';

part 'initial_response.freezed.dart';
part 'initial_response.g.dart';

@freezed
abstract class InitialCommunityMute with _$InitialCommunityMute {
  const factory InitialCommunityMute({
    required String id,
    required String mutedCommunityId,
  }) = _InitialCommunityMute;

  factory InitialCommunityMute.fromJson(Map<String, dynamic> json) =>
      _$InitialCommunityMuteFromJson(json);
}

@freezed
abstract class InitialUserMute with _$InitialUserMute {
  const factory InitialUserMute({
    required String id,
    required String mutedUserId,
  }) = _InitialUserMute;

  factory InitialUserMute.fromJson(Map<String, dynamic> json) =>
      _$InitialUserMuteFromJson(json);
}

@freezed
abstract class InitialMutes with _$InitialMutes {
  const factory InitialMutes({
    @Default([]) List<InitialCommunityMute> communityMutes,
    @Default([]) List<InitialUserMute> userMutes,
  }) = _InitialMutes;

  factory InitialMutes.fromJson(Map<String, dynamic> json) =>
      _$InitialMutesFromJson(json);
}

@freezed
abstract class InitialResponse with _$InitialResponse {
  const factory InitialResponse({
    User? user,
    @Default([]) List<Community> communities,
    int? noUsers,
    List<String>? bannedFrom,
    String? vapidPublicKey,
    @Default(InitialMutes()) InitialMutes mutes,
  }) = _InitialResponse;

  factory InitialResponse.fromJson(Map<String, dynamic> json) =>
      _$InitialResponseFromJson(json);
}
