import 'package:cookie/api/model/mixed_feed.dart';
import 'package:cookie/api/model/user.dart';
import 'package:cookie/common/controller/initial_controller.dart';
import 'package:cookie/common/repository/repository.dart';

enum FeedType {
  feed,
  posts,
  comments,
}

class UserRepository extends Repository {
  UserRepository(this._authRecordProvider);

  final AuthRecordProvider _authRecordProvider;

  Future<User> getUser(String username) async {
    final uri = client.initRequest('users/$username');
    final authRecord = await _authRecordProvider.getAuthRecord();
    return performRequestObjectResult(authRecord, () => client.http.getUrl(uri),
        (json, _) => User.fromJson(json));
  }

  Future<MixedFeed> getFeed(String username,
      {FeedType type = FeedType.feed, String? next}) async {
    final uri = client.initRequest('users/$username/feed', parameters: {
      if (type != FeedType.feed) 'filter': type.name,
      if (next != null) 'next': next,
    });
    final authRecord = await _authRecordProvider.getAuthRecord();
    return performRequestObjectResult(authRecord, () => client.http.getUrl(uri),
        (json, _) => MixedFeed.fromJson(json));
  }
}
