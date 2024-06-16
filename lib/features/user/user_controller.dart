import 'package:cookie/api/model/feed_item.dart';
import 'package:cookie/api/model/mixed_feed.dart';
import 'package:cookie/api/model/user.dart';
import 'package:cookie/features/user/user_repository.dart';
import 'package:flutter/foundation.dart';

class UserController with ChangeNotifier {
  UserController(
    this._userRepository,
    this._username,
  );

  final UserRepository _userRepository;

  User? _user;
  final String _username;

  User? get user => _user;
  final Map<FeedType, MixedFeed?> _feeds = {};
  final Map<FeedType, bool> _loading = {
    FeedType.feed: false,
    FeedType.posts: false,
    FeedType.comments: false,
  };

  List<FeedItem> feed(FeedType feedType) => _feeds[feedType]?.items ?? [];

  int displayItemsCount(FeedType feedType) {
    int count = _feeds[feedType]?.items?.length ?? 0;
    final isLoading = _loading[feedType] == true;
    if (count > 0 && !allPagesLoaded(feedType) && isLoading) {
      count += 1;
    }
    return count;
  }

  bool isLoading(FeedType feedType) {
    return _loading[feedType] == true;
  }

  void reset() {
    _feeds.clear();
    for (final key in _loading.keys) {
      _loading[key] = false;
    }
  }

  Future<User> getUser() async {
    _user ??= await _userRepository.getUser(_username);
    return _user!;
  }

  bool allPagesLoaded(FeedType feedType) {
    return _feeds[feedType] != null && _feeds[feedType]?.next == null;
  }

  Future<void> loadFeedPage(
      {bool reload = false, required FeedType feedType}) async {
    if (reload) {
      _feeds.remove(feedType);
      _loading[feedType] = false;
    }
    if (allPagesLoaded(feedType)) {
      return;
    }
    if (_loading[feedType] == true) {
      return;
    }
    _loading[feedType] = true;
    try {
      _user ??= await _userRepository.getUser(_username);
      final feed = await _userRepository.getFeed(_username,
          type: feedType, next: _feeds[feedType]?.next);
      if (_feeds[feedType]?.items != null) {
        _feeds[feedType] =
            MixedFeed(_feeds[feedType]!.items! + (feed.items ?? []), feed.next);
      } else {
        _feeds[feedType] = feed;
      }
      _loading[feedType] = false;
      notifyListeners();
    } catch (e) {
      _loading[feedType] = false;
      notifyListeners();
      rethrow;
    }
  }
}
