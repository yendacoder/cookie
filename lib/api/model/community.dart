import 'package:cookie/api/model/image.dart';
import 'package:cookie/api/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'community.g.dart';

@JsonSerializable()
class Community {
  Community(
      this.id,
      this.userId,
      this.name,
      this.nsfw,
      this.about,
      this.noMembers,
      this.proPic,
      this.bannerImage,
      this.createdAt,
      this.deletedAt,
      this.isDefault,
      this.userJoined,
      this.userMod,
      this.mods);

  String id;
  String userId;
  String name;
  bool nsfw;
  String? about;
  int noMembers;
  Image? proPic;
  Image? bannerImage;
  String createdAt;
  String? deletedAt;
  bool? isDefault;
  bool? userJoined;
  bool? userMod;

  List<User>? mods;
  // List<CommunityRule> rules;
  // ReportDetails reportDetails

  @override
  operator == (other) {
    if (other is Community) {
      return id == other.id;
    }
    return false;
  }

  factory Community.fromJson(Map<String, dynamic> json) =>
      _$CommunityFromJson(json);

  @override
  int get hashCode => id.hashCode;

}
