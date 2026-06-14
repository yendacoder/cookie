import 'package:cookie/core/api/api_client.dart';
import 'package:cookie/models/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'community_banned_provider.g.dart';

@riverpod
class CommunityBannedUsers extends _$CommunityBannedUsers {
  late String _communityId;

  @override
  Future<List<User>> build(String communityId) async {
    _communityId = communityId;
    final response = await ref
        .read(apiClientProvider)
        .get('communities/$_communityId/banned');
    return ((response.data as List?) ?? const [])
        .cast<Map<String, dynamic>>()
        .map(User.fromJson)
        .toList();
  }

  Future<void> ban(String username) async {
    final response = await ref
        .read(apiClientProvider)
        .post('communities/$_communityId/banned', data: {'username': username});
    final user = User.fromJson(response.data as Map<String, dynamic>);
    state = AsyncData([...(state.value ?? const []), user]);
  }

  Future<void> unban(String username) async {
    await ref
        .read(apiClientProvider)
        .delete(
          'communities/$_communityId/banned',
          data: {'username': username},
        );
    state = AsyncData(
      (state.value ?? const []).where((u) => u.username != username).toList(),
    );
  }
}
