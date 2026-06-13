import 'package:cookie/core/api/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hidden_posts_provider.g.dart';

@Riverpod(keepAlive: true)
class HiddenPosts extends _$HiddenPosts {
  @override
  Set<String> build() => {};

  Future<void> hide(String postId) async {
    state = {...state, postId};
    try {
      await ref
          .read(apiClientProvider)
          .post('hidden_posts', data: {'postId': postId});
    } catch (_) {
      state = state.difference({postId});
      rethrow;
    }
  }

  void unhide(String postId) {
    state = state.difference({postId});
  }
}
