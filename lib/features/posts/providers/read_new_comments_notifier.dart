import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'read_new_comments_notifier.g.dart';

/// When a post detail screen loads successfully, it might want to
/// update all lists that all new comments have been loaded
@Riverpod(keepAlive: true)
class ReadNewCommentsNotifier extends _$ReadNewCommentsNotifier {
  @override
  Set<String> build(String listType) => {};

  void clear() {
    state = {};
  }

  void setRead(String postId) {
    state = {...state, postId};
  }
}
