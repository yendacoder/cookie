import 'package:freezed_annotation/freezed_annotation.dart';

import 'discuit_image.dart';
import 'user.dart';

part 'community.freezed.dart';
part 'community.g.dart';

@freezed
abstract class Community with _$Community {
  const factory Community({
    required String id,
    required String userId,
    required String name,
    required bool nsfw,
    String? about,
    required int noMembers,
    DiscuitImage? proPic,
    DiscuitImage? bannerImage,
    required bool postingRestricted,
    required DateTime createdAt,
    DateTime? deletedAt,
    bool? isDefault,
    bool? userJoined,
    bool? userMod,
    @Default([]) List<User> mods,
    @Default([]) List<CommunityRule> rules,
  }) = _Community;

  factory Community.fromJson(Map<String, dynamic> json) =>
      _$CommunityFromJson(json);
}

@freezed
abstract class CommunityRule with _$CommunityRule {
  const factory CommunityRule({
    required int id,
    required String rule,
    String? description,
    required String communityId,
    required int zIndex,
    required String createdBy,
    required DateTime createdAt,
  }) = _CommunityRule;

  factory CommunityRule.fromJson(Map<String, dynamic> json) =>
      _$CommunityRuleFromJson(json);
}
