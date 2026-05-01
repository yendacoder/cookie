import 'package:freezed_annotation/freezed_annotation.dart';

import 'community.dart';
import 'user.dart';

part 'initial_response.freezed.dart';
part 'initial_response.g.dart';

@freezed
abstract class InitialResponse with _$InitialResponse {
  const factory InitialResponse({
    User? user,
    @Default([]) List<Community> communities,
    int? noUsers,
    List<String>? bannedFrom,
    String? vapidPublicKey,
  }) = _InitialResponse;

  factory InitialResponse.fromJson(Map<String, dynamic> json) =>
      _$InitialResponseFromJson(json);
}
