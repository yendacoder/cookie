import 'dart:async';

import 'package:cookie/api/model/comment.dart';
import 'package:cookie/api/model/comments.dart';
import 'package:cookie/api/model/community.dart';
import 'package:cookie/api/model/enums.dart';
import 'package:cookie/api/model/feed.dart';
import 'package:cookie/api/model/post.dart';
import 'package:cookie/common/controller/initial_controller.dart';
import 'package:cookie/common/repository/repository.dart';

class PostRepository extends Repository {
  PostRepository(this._authRecordProvider);

  final AuthRecordProvider _authRecordProvider;

  Future<Post> getPost(String postId) async {
    final uri = client.initRequest('posts/$postId');
    final authRecord = await _authRecordProvider.getAuthRecord();
    return performRequestObjectResult(authRecord, () => client.http.getUrl(uri),
        (json, _) => Post.fromJson(json));
  }

  Future<Comments> getComments(String postId, {String? next}) async {
    final uri = client.initRequest('posts/$postId/comments', parameters: {
      if (next != null) 'next': next,
    });
    final authRecord = await _authRecordProvider.getAuthRecord();
    return performRequestObjectResult(authRecord, () => client.http.getUrl(uri),
        (json, _) => Comments.fromJson(json));
  }

  Future<Feed> getFeed(ContentSorting contentSorting, FeedType feedType,
      {String? next, String? communityId}) async {
    final uri = client.initRequest('posts', parameters: {
      'feed': feedType.name,
      'sort': contentSorting.name,
      if (communityId != null) 'communityId': communityId,
      if (next != null) 'next': next,
    });
    final authRecord = await _authRecordProvider.getAuthRecord();
    return performRequestObjectResult(authRecord, () => client.http.getUrl(uri),
        (json, _) => Feed.fromJson(json));
  }

  Future<Community> getCommunity(String communityId) async {
    final uri = client.initRequest('communities/$communityId');
    final authRecord = await _authRecordProvider.getAuthRecord();
    return performRequestObjectResult(authRecord, () => client.http.getUrl(uri),
        (json, _) => Community.fromJson(json));
  }

  Future<Post> vote(String postId, bool voteUp) async {
    final uri = client.initRequest('_postVote');
    final authRecord = await _authRecordProvider.getAuthRecord();
    return performRequestObjectResult(
      authRecord,
      () => client.http.postUrl(uri),
      (json, _) => Post.fromJson(json),
      body: {'postId': postId, 'up': voteUp},
    );
  }

  Future<Comment> voteComment(String commentId, bool voteUp) async {
    final uri = client.initRequest('_commentVote');
    final authRecord = await _authRecordProvider.getAuthRecord();
    return performRequestObjectResult(
      authRecord,
      () => client.http.postUrl(uri),
      (json, _) => Comment.fromJson(json),
      body: {'commentId': commentId, 'up': voteUp},
    );
  }

  Future<Comment> addComment(
      String postId, String text, String? parentId) async {
    final uri = client.initRequest('posts/$postId/comments');
    final authRecord = await _authRecordProvider.getAuthRecord();
    return performRequestObjectResult(
      authRecord,
      () => client.http.postUrl(uri),
      (json, _) => Comment.fromJson(json),
      body: {'body': text, if (parentId != null) 'parentCommentId': parentId},
    );
  }

  Future<Comment> editComment(
      String postId, String commentId, String text) async {
    final uri = client.initRequest('posts/$postId/comments/$commentId');
    final authRecord = await _authRecordProvider.getAuthRecord();
    return performRequestObjectResult(
      authRecord,
      () => client.http.putUrl(uri),
      (json, _) => Comment.fromJson(json),
      body: {'body': text},
    );
  }

  Future<Comment> deleteComment(
      String postId, String commentId) async {
    final uri = client.initRequest('posts/$postId/comments/$commentId');
    final authRecord = await _authRecordProvider.getAuthRecord();
    return performRequestObjectResult(authRecord,
        () => client.http.deleteUrl(uri), (json, _) => Comment.fromJson(json));
  }
}
