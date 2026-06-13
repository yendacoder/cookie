import 'package:cookie/core/api/api_client.dart';
import 'package:cookie/models/comment.dart';
import 'package:cookie/models/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'voting_provider.g.dart';

// ── Value type ────────────────────────────────────────────────────────────────

/// Effective vote state for a single post or comment.
///
/// Stored in the vote override maps below. Both the feed list and the detail
/// screen read from the same map, so a vote on either screen is reflected
/// everywhere without a list reload.
class VoteState {
  const VoteState({
    required this.userVoted,
    required this.userVotedUp,
    required this.upvotes,
    required this.downvotes,
    this.isLoading = false,
    this.pendingVoteUp,
  });

  final bool? userVoted;
  final bool? userVotedUp;
  final int upvotes;
  final int downvotes;

  /// Whether a vote request is currently in-flight.
  final bool isLoading;

  /// The direction of the in-flight vote; null when not loading.
  /// Used to decide which icon shows the tiny spinner.
  final bool? pendingVoteUp;

  VoteState _withLoading(bool up) => VoteState(
    userVoted: userVoted,
    userVotedUp: userVotedUp,
    upvotes: upvotes,
    downvotes: downvotes,
    isLoading: true,
    pendingVoteUp: up,
  );
}

// ── Shared computation ────────────────────────────────────────────────────────

VoteState _optimistic({
  required bool? currentUserVoted,
  required bool? currentUserVotedUp,
  required int currentUpvotes,
  required int currentDownvotes,
  required bool newUp,
}) {
  final wasVoted = currentUserVoted == true;
  final wasUp = currentUserVotedUp == true;

  var upvotes = currentUpvotes;
  var downvotes = currentDownvotes;
  bool? userVoted;
  bool? userVotedUp;

  if (wasVoted && wasUp == newUp) {
    // Tapping the same direction toggles the vote off.
    userVoted = false;
    userVotedUp = null;
    if (newUp) {
      upvotes--;
    } else {
      downvotes--;
    }
  } else {
    // Switch direction or cast a fresh vote.
    if (wasVoted) {
      if (wasUp) {
        upvotes--;
      } else {
        downvotes--;
      }
    }
    userVoted = true;
    userVotedUp = newUp;
    if (newUp) {
      upvotes++;
    } else {
      downvotes++;
    }
  }

  return VoteState(
    userVoted: userVoted,
    userVotedUp: userVotedUp,
    upvotes: upvotes,
    downvotes: downvotes,
  );
}

// ── Post votes ────────────────────────────────────────────────────────────────

@Riverpod(keepAlive: true)
class PostVotesNotifier extends _$PostVotesNotifier {
  @override
  Map<String, VoteState> build() => {};

  Future<void> vote(Post post, bool up) async {
    final id = post.id;
    if (state[id]?.isLoading == true) return;

    final current = state[id];
    final optimistic = _optimistic(
      currentUserVoted: current?.userVoted ?? post.userVoted,
      currentUserVotedUp: current?.userVotedUp ?? post.userVotedUp,
      currentUpvotes: current?.upvotes ?? post.upvotes,
      currentDownvotes: current?.downvotes ?? post.downvotes,
      newUp: up,
    );

    state = {...state, id: optimistic._withLoading(up)};

    try {
      final response = await ref
          .read(apiClientProvider)
          .post('_postVote', data: {'postId': id, 'up': up});
      final updated = Post.fromJson(response.data as Map<String, dynamic>);
      state = {
        ...state,
        id: VoteState(
          userVoted: updated.userVoted ?? false,
          userVotedUp: updated.userVotedUp ?? false,
          upvotes: updated.upvotes,
          downvotes: updated.downvotes,
        ),
      };
    } catch (_) {
      // Revert on failure — remove the override so the original post data shows.
      state = Map.of(state)..remove(id);
    }
  }
}

// ── Comment votes ─────────────────────────────────────────────────────────────

@Riverpod(keepAlive: true)
class CommentVotesNotifier extends _$CommentVotesNotifier {
  @override
  Map<String, VoteState> build() => {};

  Future<void> vote(Comment comment, bool up) async {
    final id = comment.id;
    if (state[id]?.isLoading == true) return;

    final current = state[id];
    final optimistic = _optimistic(
      currentUserVoted: current?.userVoted ?? comment.userVoted,
      currentUserVotedUp: current?.userVotedUp ?? comment.userVotedUp,
      currentUpvotes: current?.upvotes ?? comment.upvotes,
      currentDownvotes: current?.downvotes ?? comment.downvotes,
      newUp: up,
    );

    state = {...state, id: optimistic._withLoading(up)};

    try {
      final response = await ref
          .read(apiClientProvider)
          .post('_commentVote', data: {'commentId': id, 'up': up});
      final updated = Comment.fromJson(response.data as Map<String, dynamic>);
      state = {
        ...state,
        id: VoteState(
          userVoted: updated.userVoted ?? false,
          userVotedUp: updated.userVotedUp ?? false,
          upvotes: updated.upvotes,
          downvotes: updated.downvotes,
        ),
      };
    } catch (_) {
      state = Map.of(state)..remove(id);
    }
  }
}
