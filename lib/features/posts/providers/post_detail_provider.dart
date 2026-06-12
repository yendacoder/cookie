import 'package:cookie/core/api/api_client.dart';
import 'package:cookie/models/comment.dart';
import 'package:cookie/models/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_detail_provider.g.dart';

@riverpod
class PostDetailNotifier extends _$PostDetailNotifier {
  @override
  Future<Post> build(String publicId) async {
    final response = await ref
        .read(apiClientProvider)
        .get('posts/$publicId', queryParameters: {'fetchCommunity': 'true'});

    final res = Post.fromJson(response.data as Map<String, dynamic>);
    return res;
  }

  Future<void> editComment(String commentId, String body) async {
    final post = state.value;
    if (post == null) return;
    final response = await ref
        .read(apiClientProvider)
        .put(
          'posts/${post.publicId}/comments/$commentId',
          data: {'body': body},
        );
    final updated = Comment.fromJson(response.data as Map<String, dynamic>);
    state = AsyncData(
      post.copyWith(
        comments: post.comments
            ?.map((c) => c.id == commentId ? updated : c)
            .toList(),
      ),
    );
  }

  Future<void> deleteComment(String commentId) async {
    final post = state.value;
    if (post == null) return;
    await ref
        .read(apiClientProvider)
        .delete('posts/${post.publicId}/comments/$commentId');
    state = AsyncData(
      post.copyWith(
        comments: post.comments
            ?.map(
              (c) =>
                  c.id == commentId ? c.copyWith(deleted: true, body: '') : c,
            )
            .toList(),
        noComments: post.noComments - 1,
      ),
    );
  }

  Future<void> addComment(String body, {String? parentCommentId}) async {
    final post = state.value;
    if (post == null) return;

    final response = await ref
        .read(apiClientProvider)
        .post(
          'posts/${post.publicId}/comments',
          data: {'body': body, 'parentCommentId': parentCommentId},
        );
    final newComment = Comment.fromJson(response.data as Map<String, dynamic>);

    state = AsyncData(
      post.copyWith(
        comments: [...(post.comments ?? []), newComment],
        noComments: post.noComments + 1,
      ),
    );
  }

  Future<void> reportPost(int reportReason) async {
    final post = state.value;
    if (post == null) return;
    await ref
        .read(apiClientProvider)
        .post(
          '_report',
          data: {'targetId': post.id, 'type': 'post', 'reason': reportReason},
        );
  }

  Future<void> reportComment(String commentId, int reportReason) async {
    final post = state.value;
    if (post == null) return;
    await ref
        .read(apiClientProvider)
        .post(
          '_report',
          data: {
            'targetId': commentId,
            'type': 'comment',
            'reason': reportReason,
          },
        );
  }
}
