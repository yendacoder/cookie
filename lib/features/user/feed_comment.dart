import 'package:auto_route/auto_route.dart';
import 'package:cookie/api/model/comment.dart';
import 'package:cookie/common/ui/widgets/common/markdown_text.dart';
import 'package:cookie/common/ui/widgets/common/tappable_item.dart';
import 'package:cookie/common/util/context_util.dart';
import 'package:cookie/common/util/datetime_util.dart';
import 'package:cookie/router/router.gr.dart';
import 'package:cookie/settings/consts.dart';
import 'package:flutter/material.dart';

class FeedComment extends StatelessWidget {
  const FeedComment({super.key, required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TappableItem(
      padding: const EdgeInsets.symmetric(
          horizontal: kPrimaryPadding, vertical: kSecondaryPaddingHalf),
      onTap: () {
        context.router.push(PostRoute(postId: comment.postPublicId));
      },
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        MarkdownText(
          comment.postTitle ?? '',
          style: theme.textTheme.bodyMedium!.copyWith(color: theme.hintColor),
        ),
        MarkdownText(comment.body),
        Align(
          alignment: Alignment.centerRight,
          child: Tooltip(
            message: comment.createdAt.toDisplayDateTimeShort(),
            child: Text(
              context.displayElapsedTime(comment.createdAt),
              style:
                  theme.textTheme.labelMedium!.copyWith(color: theme.hintColor),
            ),
          ),
        ),
      ]),
    );
  }
}
