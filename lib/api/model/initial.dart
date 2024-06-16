import 'package:cookie/api/model/community.dart';
import 'package:cookie/api/model/mutes.dart';
import 'package:cookie/api/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'initial.g.dart';

@JsonSerializable()
class Initial {
  Initial(
      // this.reportReasons,
      this.user,
      this.communities,
      this.noUsers,
      this.bannedFrom,
      this.mutes);

  // List<ReportReason> reportReasons;
  User? user;
  List<Community> communities;
  int noUsers;
  List<String>? bannedFrom;
  Mutes mutes;

  factory Initial.fromJson(Map<String, dynamic> json) =>
      _$InitialFromJson(json);
}
