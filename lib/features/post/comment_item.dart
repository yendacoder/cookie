import 'dart:math';

import 'package:cookie/api/model/comment.dart';
import 'package:cookie/common/ui/widgets/common/markdown_text.dart';
import 'package:cookie/common/ui/widgets/common/tappable_item.dart';
import 'package:cookie/common/ui/widgets/nested_indicator.dart';
import 'package:cookie/common/ui/widgets/username.dart';
import 'package:cookie/common/util/context_util.dart';
import 'package:cookie/common/util/string_util.dart';
import 'package:cookie/settings/consts.dart';
import 'package:flutter/material.dart';

const _kNestedIndicatorSize = 6.0;
const _kNestedIndicatorPadding = 2.0;

class CommentItem extends StatelessWidget {
  const CommentItem(
      {super.key,
      required this.comment,
      required this.isOp,
      this.nestingIndicatorColor,
      this.onNestingClicked});

  final Comment comment;
  final bool isOp;
  final Color? nestingIndicatorColor;
  final VoidCallback? onNestingClicked;

  Widget _buildNestedDisplay(BuildContext context, int level) {
    return TappableItem(
      onTap: onNestingClicked,
      padding: const EdgeInsets.only(
          top: kUserIconSize / 2 -
              _kNestedIndicatorSize / 2 -
              _kNestedIndicatorPadding),
      child: Wrap(
        alignment: WrapAlignment.end,
        // runAlignment: WrapAlignment.end,
        children: [
          for (int i = 0; i < level; i++)
            NestedIndicator(
              size: _kNestedIndicatorSize,
              padding: _kNestedIndicatorPadding,
              color: nestingIndicatorColor,
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nestedWidth = min(comment.depth + 1, 5) *
        (_kNestedIndicatorPadding + _kNestedIndicatorSize);
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kPrimaryPadding, vertical: kSecondaryPadding),
      // This would have looked cleaner with IntrinsicHeight,
      // but it breaks on markdown with lists
      // Stack idea is picked from here https://github.com/flutter/flutter/issues/81768
      child: Stack(
        children: [
          Positioned(
            left: 0,
            width: nestedWidth,
            bottom: 0,
            top: 0,
            child: _buildNestedDisplay(context, comment.depth + 1),
          ),
          Padding(
            padding: EdgeInsets.only(left: nestedWidth + 4),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Username(
                        username: comment.username,
                        isDeleted: comment.deletedAt != null,
                      ),
                      if (isOp)
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            context.l.commentOp,
                            style: theme.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary),
                          ),
                        ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      MarkdownText(
                        context.displayElapsedTime(comment.createdAtDate(),
                            short: true),
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: theme.hintColor),
                      ),
                      const Spacer(),
                      Text(formatRating(comment.upvotes, comment.downvotes),
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: theme.hintColor)),
                    ],
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  MarkdownText(
                    comment.body,
                    style: comment.deletedAt != null
                        ? theme.textTheme.bodyMedium!.copyWith(
                            color: theme.hintColor, fontStyle: FontStyle.italic)
                        : null,
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
