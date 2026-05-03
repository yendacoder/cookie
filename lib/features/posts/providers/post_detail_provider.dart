import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';
import '../../../models/comment.dart';
import '../../../models/post.dart';

part 'post_detail_provider.g.dart';

@riverpod
class PostDetailNotifier extends _$PostDetailNotifier {
  @override
  Future<Post> build(String publicId) async {
    final response = await ref.read(apiClientProvider).get(
      'posts/$publicId',
      queryParameters: {'fetchCommunity': 'true'},
    );
    return Post.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> addComment(String body, {String? parentCommentId}) async {
    final post = state.value;
    if (post == null) return;

    final response = await ref.read(apiClientProvider).post(
      'posts/${post.publicId}/comments',
      data: {'body': body, 'parentCommentId': parentCommentId},
    );
    final newComment = Comment.fromJson(response.data as Map<String, dynamic>);

    state = AsyncData(post.copyWith(
      comments: [...(post.comments ?? []), newComment],
      noComments: post.noComments + 1,
    ));
  }
}
