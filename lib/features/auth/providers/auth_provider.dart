import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';
import '../../../models/initial_response.dart';
import '../../../models/user.dart';
import '../../communities/providers/community_mutes_provider.dart';
import '../../communities/providers/muted_communities_list_provider.dart';
import '../../user/providers/muted_users_list_provider.dart';
import '../../user/providers/user_mutes_provider.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<User?> build() async {
    try {
      final response = await ref.read(apiClientProvider).get('_initial');
      final data = InitialResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
      _seedMutes(data);
      return data.user;
    } on DioException {
      // Network / timeout failure — treat as unauthenticated so the home
      // screen can show the retry button rather than the sign-in prompt.
      return null;
    }
    // Any other exception (JSON parse, cast, etc.) propagates as AsyncError
    // so the home screen's error view is shown with a retry button.
  }

  void _seedMutes(InitialResponse data) {
    final communityIds = data.mutes.communityMutes
        .map((m) => m.mutedCommunityId)
        .toSet();
    ref.read(communityMutesProvider.notifier).initialize(communityIds);
    ref.read(mutedCommunitiesListProvider.notifier).initialize(
      data.mutes.communityMutes,
    );

    final userIds = data.mutes.userMutes
        .map((m) => m.mutedUserId)
        .toSet();
    ref.read(userMutesProvider.notifier).initialize(userIds);
    ref.read(mutedUsersListProvider.notifier).initialize(
      data.mutes.userMutes,
    );
  }

  Future<void> login(String username, String password) async {
    await ref.read(apiClientProvider).post(
      '_login',
      data: {'username': username, 'password': password},
    );
    // Re-fetch _initial to get fresh session data including mutes.
    final response = await ref.read(apiClientProvider).get('_initial');
    final data = InitialResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
    _seedMutes(data);
    state = AsyncValue.data(data.user);
  }

  Future<void> updateProfile({required String aboutMe}) async {
    final user = state.value;
    if (user == null) return;
    final response = await ref.read(apiClientProvider).post(
      '_settings',
      queryParameters: {'action': 'updateProfile'},
      data: {
        'aboutMe': aboutMe,
        'upvoteNotificationsOff': user.upvoteNotificationsOff,
        'replyNotificationsOff': user.replyNotificationsOff,
        'homeFeed': user.homeFeed,
        'rememberFeedSort': user.rememberFeedSort,
        'embedsOff': user.embedsOff,
        'email': user.email ?? '',
        'hideUserProfilePictures': user.hideUserProfilePictures,
      },
    );
    state = AsyncData(User.fromJson(response.data as Map<String, dynamic>));
  }

  Future<void> updateProfilePicture(String imagePath) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        imagePath,
        filename: imagePath.split('/').last,
      ),
    });
    final response = await ref.read(apiClientProvider).post(
      '_settings',
      queryParameters: {'action': 'updateProPic'},
      data: formData,
    );
    state = AsyncData(User.fromJson(response.data as Map<String, dynamic>));
  }

  void setNotificationCount(int count) {
    final user = state.value;
    if (user == null) return;
    state = AsyncData(user.copyWith(notificationsNewCount: count));
  }

  Future<void> logout() async {
    try {
      await ref.read(apiClientProvider).post(
        '_login',
        queryParameters: {'action': 'logout'},
      );
    } finally {
      ref.read(communityMutesProvider.notifier).clear();
      ref.read(mutedCommunitiesListProvider.notifier).clear();
      ref.read(userMutesProvider.notifier).clear();
      ref.read(mutedUsersListProvider.notifier).clear();
      state = const AsyncValue.data(null);
    }
  }
}
