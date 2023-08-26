import 'dart:async';

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
}
