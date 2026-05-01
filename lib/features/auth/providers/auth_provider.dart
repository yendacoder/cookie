import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';
import '../../../models/initial_response.dart';
import '../../../models/user.dart';

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
      return data.user;
    } on DioException {
      // Network / timeout failure — treat as unauthenticated so the home
      // screen can show the retry button rather than the sign-in prompt.
      return null;
    }
    // Any other exception (JSON parse, cast, etc.) propagates as AsyncError
    // so the home screen's error view is shown with a retry button.
  }

  Future<void> login(String username, String password) async {
    final response = await ref.read(apiClientProvider).post(
      '_login',
      data: {'username': username, 'password': password},
    );
    final user = User.fromJson(response.data as Map<String, dynamic>);
    state = AsyncValue.data(user);
  }

  Future<void> logout() async {
    try {
      await ref.read(apiClientProvider).post(
        '_login',
        queryParameters: {'action': 'logout'},
      );
    } finally {
      state = const AsyncValue.data(null);
    }
  }
}
