import 'package:cookie/api/model/community.dart';
import 'package:cookie/api/model/enums.dart';
import 'package:cookie/api/model/post.dart';
import 'package:cookie/common/repository/post_repository.dart';
import 'package:cookie/common/util/common_util.dart';
import 'package:cookie/common/util/iterable_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kContentSortingPrefs = 'content_sorting_';
const _kDefaultFeedTypePrefs = 'default_feed_type';

class FeedController with ChangeNotifier {
  FeedController(this._postRepository, this._feedType, this._communityId);

  final PostRepository _postRepository;

  final List<Post> _posts = [];
  FeedType? _feedType;
  final String? _communityId;
  Community? _community;

  Community? get community => _community;

  FeedType get feedType => _feedType ?? FeedType.all;
  String? _next;
  Object? _lastError;
  bool _allPagesLoaded = false;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  ContentSorting? _contentSorting;

  Object? get lastError => _lastError;

  ContentSorting get contentSorting => _contentSorting ?? ContentSorting.hot;

  List<Post> get posts => _posts;

  /// Returns number of items the displaying list should report
  /// Later the builder part should check if the index is reaching
  /// outside of the actual data size, progress cell should be displayed
  int get displayItemsCount {
    int count = _posts.length;
    if (_posts.isNotEmpty &&
        !_allPagesLoaded &&
        (isLoading || lastError == null)) {
      count += 1;
    }
    return count;
  }

  void reset() {
    _allPagesLoaded = false;
    _isLoading = false;
    _next = null;
    _lastError = null;
    _posts.clear();
  }

  void _saveContentSorting() async {
    if (_contentSorting == null) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _kContentSortingPrefs + feedType.name, _contentSorting!.name);
  }

  Future<void> _loadContentSorting() async {
    final prefs = await SharedPreferences.getInstance();
    _contentSorting = prefs
            .getString(_kContentSortingPrefs + feedType.name)
            ?.toEnumOrNull(ContentSorting.values) ??
        ContentSorting.hot;
  }

  void _saveFeedType() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kDefaultFeedTypePrefs, feedType.name);
  }

  Future<void> _loadFeedType() async {
    final prefs = await SharedPreferences.getInstance();
    _feedType = prefs
            .getString(_kDefaultFeedTypePrefs)
            ?.toEnumOrNull(FeedType.values) ??
        FeedType.all;
  }

  set contentSorting(ContentSorting sorting) {
    _contentSorting = sorting;
    _saveContentSorting();
    reset();
    _isLoading = true;
    notifyListeners();
    loadPage();
  }

  set feedType(FeedType feedType) {
    _feedType = feedType;
    _saveFeedType();
    _contentSorting = null;
    reset();
    _isLoading = true;
    notifyListeners();
    loadPage();
  }

  void toggleFeedType() {
    feedType = _feedType == FeedType.home ? FeedType.all : FeedType.home;
  }

  Future<void> loadPage() async {
    if (_allPagesLoaded) {
      return;
    }
    _isLoading = true;
    _lastError = null;
    if (_posts.isEmpty) {
      if (_contentSorting == null) {
        await _loadContentSorting();
      }
      if (_feedType == null) {
        await _loadFeedType();
      }
      notifyListeners();
    }
    try {
      if (feedType == FeedType.community && _community == null) {
        _community = await _postRepository.getCommunity(_communityId!);
      }
      bool added = false;
      while (!added && !_allPagesLoaded) {
        final feed = await _postRepository.getFeed(contentSorting, feedType,
            communityId: _communityId, next: _next);
        _next = feed.next.toString();
        _allPagesLoaded = _next == null;
        if (feed.posts != null) {
          for (final post in feed.posts!) {
            if (!_posts.any((p) => p.id == post.id)) {
              _posts.add(post);
              added = true;
            }
          }
        }
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _lastError = e;
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> vote(String postId, bool up) async {
    try {
      final updatedPost = await _postRepository.vote(postId, up);
      final post = _posts.firstWhere((element) => element.id == postId);
      post.userVoted = updatedPost.userVoted;
      post.userVotedUp = updatedPost.userVotedUp;
      post.upvotes = updatedPost.upvotes;
      post.downvotes = updatedPost.downvotes;

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  /// Update voting stats from another post object
  void updateVoted(Post? post) {
    if (post == null) {
      return;
    }
    final updatingPost =
        _posts.firstWhereOrNull((element) => element.id == post.id);
    if (updatingPost != null) {
      updatingPost.userVoted = post.userVoted;
      updatingPost.userVotedUp = post.userVotedUp;
      updatingPost.upvotes = post.upvotes;
      updatingPost.downvotes = post.downvotes;
      notifyListeners();
    }
  }

  /// Update commenting stats from another post object
  void updateCommented(Post? post) {
    if (post == null) {
      return;
    }
    final updatingPost =
        _posts.firstWhereOrNull((element) => element.id == post.id);
    if (updatingPost != null) {
      updatingPost.noComments = post.noComments;
      notifyListeners();
    }
  }
}
