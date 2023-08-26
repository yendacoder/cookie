import 'package:cookie/common/ui/widgets/common/progress_icon_button.dart';
import 'package:cookie/common/util/string_util.dart';
import 'package:flutter/material.dart';

class Voting extends StatelessWidget {
  const Voting(
      {super.key,
      required this.upvotes,
      required this.downvotes,
      required this.isLoadingUp,
      required this.isLoadingDown,
      required this.isVotedUp,
      required this.isVotedDown,
      this.onVote});

  final int upvotes;
  final int downvotes;
  final bool isLoadingUp;
  final bool isLoadingDown;
  final bool isVotedUp;
  final bool isVotedDown;

  /// Callback for when the user votes up or down. If null, the voting is
  /// disabled (user not logged in).
  final void Function(bool up)? onVote;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        ProgressIconButton(
          icon: Icons.arrow_upward,
          color: isVotedUp ? Colors.green : null,
          isRunning: isLoadingUp,
          onPressed: isLoadingUp || isLoadingDown || onVote == null
              ? null
              : () => onVote!(true),
        ),
        Text(
          formatRating(upvotes, downvotes),
          style: theme.textTheme.labelMedium!.copyWith(color: theme.hintColor),
        ),
        ProgressIconButton(
          icon: Icons.arrow_downward,
          color: isVotedDown ? Colors.red : null,
          isRunning: isLoadingDown,
          onPressed: isLoadingUp || isLoadingDown || onVote == null
              ? null
              : () => onVote!(false),
        ),
      ],
    );
  }
}
