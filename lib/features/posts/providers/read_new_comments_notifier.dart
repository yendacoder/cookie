import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';

part 'read_new_comments_notifier.g.dart';

/// When a post detail screen loads successfully, it might want to
/// update all lists that all new comments have been loaded
@Riverpod(keepAlive: true)
class ReadNewCommentsNotifier extends _$ReadNewCommentsNotifier {
  @override
  Set<String> build() => {};

  void clear() {
    state = {};
  }

  void setRead(String postId) {
    state = {...state, postId};
  }
}
