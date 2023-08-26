import 'package:cookie/common/util/string_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class Voting extends StatelessWidget {
  const Voting(
      {super.key,
      required this.upvotes,
      required this.downvotes,
      required this.isLoading,
      required this.isVotedUp,
      required this.isVotedDown,
      this.onVote});

  final int upvotes;
  final int downvotes;
  final bool isLoading;
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
        PlatformIconButton(
          icon: Icon(
            Icons.arrow_upward,
            color: isVotedUp ? Colors.green : null,
          ),
          onPressed: isLoading || onVote == null ? null : () => onVote!(true),
        ),
        if (isLoading)
          SizedBox(width: 20, height: 20, child: PlatformCircularProgressIndicator())
        else
          Text(
            formatRating(upvotes, downvotes),
            style:
                theme.textTheme.labelMedium!.copyWith(color: theme.hintColor),
          ),
        PlatformIconButton(
          icon: Icon(
            Icons.arrow_downward,
            color: isVotedDown ? Colors.red : null,
          ),
          onPressed: isLoading || onVote == null ? null : () => onVote!(false),
        ),
      ],
    );
  }
}
