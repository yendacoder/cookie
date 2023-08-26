import 'package:cookie/api/model/comment.dart';
import 'package:cookie/common/controller/initial_controller.dart';
import 'package:cookie/common/ui/confirmation_dialog.dart';
import 'package:cookie/common/ui/notifications.dart';
import 'package:cookie/common/ui/widgets/common/icon_text.dart';
import 'package:cookie/common/ui/widgets/common/progress_icon_button.dart';
import 'package:cookie/common/ui/widgets/common/tappable_item.dart';
import 'package:cookie/common/util/context_util.dart';
import 'package:cookie/features/feed/feed_controller.dart';
import 'package:cookie/features/post/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class ComposeComment extends StatefulWidget {
  const ComposeComment({super.key, required this.parentComment});

  final Comment? parentComment;

  @override
  State<ComposeComment> createState() => _ComposeCommentState();
}

class _ComposeCommentState extends State<ComposeComment> {
  bool? _isVotingUp;
  bool _isCommenting = false;
  bool _isEditing = false;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _voteComment(BuildContext context, bool up) async {
    try {
      setState(() {
        _isVotingUp = up;
      });
      final postController =
          Provider.of<PostController>(context, listen: false);
      await postController.voteComment(widget.parentComment!.id, up);
    } catch (e) {
      showApiErrorMessage(context, e);
    } finally {
      setState(() {
        _isVotingUp = null;
      });
    }
  }

  Future<void> _postComment(BuildContext context) async {
    if (_textEditingController.text.isEmpty) {
      return;
    }
    try {
      setState(() {
        _isCommenting = true;
      });
      final postController =
          Provider.of<PostController>(context, listen: false);
      final feedController =
          Provider.of<FeedController>(context, listen: false);
      if (_isEditing) {
        await postController.editComment(
            widget.parentComment!.id, _textEditingController.text);
        feedController.updateCommented(postController.post);
      } else {
        await postController.addComment(
            _textEditingController.text, widget.parentComment?.id);
      }
      _textEditingController.text = '';
    } catch (e) {
      showApiErrorMessage(context, e);
    } finally {
      setState(() {
        _isCommenting = false;
      });
    }
  }

  Future<void> _deleteComment(BuildContext context) async {
    final postController = Provider.of<PostController>(context, listen: false);
    if (!await showConfirmationDialog(context, context.l.commentDeleteConfirm,
        okText: context.l.commentDeleteConfirmOk,
        cancelText: context.l.commentDeleteConfirmCancel,
        isDestructive: true)) {
      return;
    }
    try {
      await postController.deleteComment(widget.parentComment!.id);
    } catch (e) {
      if (mounted) {
        showApiErrorMessage(context, e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMyComment = widget.parentComment?.userId ==
        Provider.of<InitialController>(context).initial?.user?.id;
    return Column(
      children: [
        Row(
          children: [
            if (widget.parentComment != null) ...[
              ProgressIconButton(
                  icon: Icons.arrow_upward,
                  color: widget.parentComment?.userVotedUp == true
                      ? Colors.green
                      : null,
                  isRunning: _isVotingUp == true,
                  onPressed: _isVotingUp != null
                      ? null
                      : () => _voteComment(context, true)),
              ProgressIconButton(
                  icon: Icons.arrow_downward,
                  color: widget.parentComment?.userVotedUp == false
                      ? Colors.red
                      : null,
                  isRunning: _isVotingUp == false,
                  onPressed: _isVotingUp != null
                      ? null
                      : () => _voteComment(context, false)),
            ],
            const Spacer(),
            if (isMyComment) ...[
              TappableItem(
                padding: const EdgeInsets.all(8.0),
                child: IconText(icon: Icons.edit, text: context.l.commentEdit),
                onTap: () {
                  _textEditingController.text =
                      widget.parentComment?.body ?? '';
                  _isEditing = true;
                },
              ),
              const SizedBox(
                width: 6.0,
              ),
              TappableItem(
                padding: const EdgeInsets.all(8.0),
                child:
                    IconText(icon: Icons.delete, text: context.l.commentDelete),
                onTap: () => _deleteComment(context),
              ),
            ],
          ],
        ),
        Stack(alignment: Alignment.bottomRight, children: [
          PlatformTextField(
            material: (_, __) => MaterialTextFieldData(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(12.0, 8.0, 40.0, 8.0),
              ),
            ),
            style: Theme.of(context).textTheme.bodyMedium,
            controller: _textEditingController,
            minLines: 3,
            maxLines: 10,
            hintText: widget.parentComment == null
                ? context.l.commentHint
                : context.l.commentReplyHint,
          ),
          ProgressIconButton(
              icon: Icons.send,
              isRunning: _isCommenting,
              onPressed: () => _postComment(context)),
        ])
      ],
    );
  }
}
