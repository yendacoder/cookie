import 'package:cookie/api/model/comment.dart';
import 'package:cookie/api/model/post.dart';
import 'package:cookie/common/repository/post_repository.dart';
import 'package:flutter/foundation.dart';

class PostController with ChangeNotifier {
  PostController(this._postRepository, this._postId, this._post) {
    if (_post?.comments != null) {
      _comments.addAll(_post!.comments!);
    }
  }

  final PostRepository _postRepository;

  Post? _post;
  final String _postId;

  Post? get post => _post;
  final List<Comment> _comments = [];

  List<Comment> get comments => _comments;
  String? _selectedCommentId;
  String? _next;

  String? get selectedCommentId => _selectedCommentId;

  set selectedCommentId(String? commentId) {
    _selectedCommentId = commentId;
    notifyListeners();
  }

  int get displayItemsCount {
    int count = _comments.length;
    if (_comments.isNotEmpty &&
        !_allPagesLoaded &&
        (isLoading || lastError != null)) {
      count += 1;
    }
    return count;
  }

  Object? _lastError;

  Object? get lastError => _lastError;
  bool _isLoading = false;
  bool _allPagesLoaded = false;

  bool get isLoading => _isLoading;

  void reset() {
    _lastError = null;
    _isLoading = false;
    _allPagesLoaded = false;
    _comments.clear();
  }

  void _addLoaded(List<Comment> comments) {
    /// The order of comments returned by API is not documented,
    /// and in practice child comments can be returned before parent comments.
    ///
    /// The logic here is:
    /// - get the max depth in the set
    /// - for each depth level, get comments of that exact depth and add after
    /// the comment with the id of the last ancestor or after the last comment
    /// with the same last ancestor id

    final depth = comments.fold<int>(
        0, (prev, comment) => prev > comment.depth ? prev : comment.depth);
    for (int i = 0; i <= depth; i++) {
      final levelComments = comments.where((c) => c.depth == i).toList();
      if (i == 0) {
        _comments.addAll(levelComments);
      } else {
        for (final comment in levelComments) {
          final ancestor = comment.ancestors!.last;
          final prev = _comments.lastIndexWhere(
              (c) => c.id == ancestor || c.ancestors?.last == ancestor);
          _comments.insert(prev + 1, comment);
        }
      }
    }
  }

  Future<void> loadCommentsPage({bool reload = false}) async {
    if (reload) {
      _comments.clear();
      _next = null;
      _allPagesLoaded = false;
    }
    if (_allPagesLoaded) {
      return;
    }
    _isLoading = true;
    _lastError = null;
    try {
      _post ??= await _postRepository.getPost(_postId);
      final comments = await _postRepository.getComments(_postId, next: _next);
      _next = comments.next;
      _allPagesLoaded = _next == null;
      _addLoaded(comments.comments);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _lastError = e;
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> vote(bool up) async {
    if (_post == null) {
      return;
    }
    final updatedPost = await _postRepository.vote(_post!.id, up);
    _post?.userVoted = true;
    _post?.userVotedUp = up;
    _post?.upvotes = updatedPost.upvotes;
    _post?.downvotes = updatedPost.downvotes;
    notifyListeners();
  }

  Future<void> voteComment(String commentId, bool up) async {
    final updatedComment = await _postRepository.voteComment(commentId, up);
    final comment = _comments.firstWhere((c) => c.id == commentId);
    comment.userVoted = true;
    comment.userVotedUp = up;
    comment.upvotes = updatedComment.upvotes;
    comment.downvotes = updatedComment.downvotes;
    selectedCommentId = null;
  }

  Future<void> addComment(String text, String? parentId) async {
    final comment = await _postRepository.addComment(_postId, text, parentId);
    _addLoaded([comment]);
    post?.noComments++;
    selectedCommentId = null;
  }

  Future<void> editComment(String commentId, String text) async {
    final newComment = await _postRepository.editComment(_postId, commentId, text);
    final comment = _comments.firstWhere((c) => c.id == commentId);
    comment.body = newComment.body;
    comment.editedAt = newComment.editedAt;
    selectedCommentId = null;
  }

  Future<void> deleteComment(String commentId) async {
    final newComment = await _postRepository.deleteComment(_postId, commentId);
    final comment = _comments.firstWhere((c) => c.id == commentId);
    post?.noComments--;
    comment.body = newComment.body;
    comment.deletedAs = newComment.deletedAs;
    comment.deletedBy = newComment.deletedBy;
    comment.deletedAt = newComment.deletedAt;
    selectedCommentId = null;
  }
}
