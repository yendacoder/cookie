import 'package:auto_route/auto_route.dart';
import 'package:cookie/api/model/post.dart';
import 'package:cookie/common/controller/initial_controller.dart';
import 'package:cookie/common/repository/post_repository.dart';
import 'package:cookie/common/ui/notifications.dart';
import 'package:cookie/common/ui/widgets/common/flat_appbar.dart';
import 'package:cookie/common/ui/widgets/common/refreshable_list.dart';
import 'package:cookie/common/ui/widgets/error_content.dart';
import 'package:cookie/common/ui/widgets/list_loading_item.dart';
import 'package:cookie/common/ui/widgets/post_item.dart';
import 'package:cookie/common/util/context_util.dart';
import 'package:cookie/common/util/iterable_util.dart';
import 'package:cookie/features/post/comment_item.dart';
import 'package:cookie/features/post/compose_comment.dart';
import 'package:cookie/features/post/post_controller.dart';
import 'package:cookie/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

@RoutePage()
class PostScreen extends StatefulWidget {
  const PostScreen({super.key, @PathParam() required this.postId, this.post});

  final String postId;
  final Post? post;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  void _loadPage(PostController controller, bool reload) {
    controller
        .loadCommentsPage(reload: reload)
        .onError((e, _) => showApiErrorMessage(context, e));
    setState(() {});
  }

  Widget _buildPost(BuildContext context, PostController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (controller.post != null)
          PostItem(
            post: controller.post!,
            showCommunity: true,
            isContentClickable: false,
            isDetailScreen: true,
          ),
        if (controller.lastError != null && controller.comments.isEmpty)
          ErrorContent(
              error: controller.lastError!,
              retry: () {
                _loadPage(controller, true);
                setState(() {});
              }),
        if (controller.isLoading && controller.post == null)
          Center(child: PlatformCircularProgressIndicator()),
        if (controller.lastError == null)
          Divider(
            color: Theme.of(context).colorScheme.surface,
          )
      ],
    );
  }

  Widget _buildBody(BuildContext context, PostController controller) {
    final initialController = Provider.of<InitialController>(context);
    if (controller.lastError != null) {
      return ErrorContent(
        error: controller.lastError!,
        retry: () {
          controller.reset();
          controller.loadCommentsPage().ignore();
          setState(() {});
        },
      );
    }
    if (controller.isLoading && controller.post == null) {
      return Center(
        child: PlatformCircularProgressIndicator(),
      );
    }
    final theme = Theme.of(context);
    final itemsCount = controller.displayItemsCount == 0
        ? 3
        : controller.displayItemsCount + 2;
    return RefreshableList(
      refreshRequest: () => _loadPage(controller, true),
      nextPageRequest: () => _loadPage(controller, false),
      padding: const EdgeInsets.only(bottom: kPrimaryPadding),
      isLoading: controller.isLoading,
      itemCount: itemsCount,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildPost(context, controller);
        }
        if (index == itemsCount - 1) {
          if (!initialController.isLoggedIn) {
            return const SizedBox.shrink();
          } else {
            return const Padding(
              padding: EdgeInsets.only(
                  top: 40.0, left: kPrimaryPadding, right: kPrimaryPadding),
              child: ComposeComment(parentComment: null),
            );
          }
        }
        if (controller.displayItemsCount == 0 && !controller.isLoading) {
          return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(kPrimaryPaddingDouble),
              child: Text(
                context.l.commentsEmpty,
                style: theme.textTheme.titleMedium!
                    .copyWith(color: theme.disabledColor),
              ));
        }
        final comment = controller.comments.elementAtOrNullSafe(index - 1);
        if (comment != null) {
          return CommentItem(
            comment: comment,
            isOp: comment.userId == widget.post?.userId,
            isExpanded: controller.selectedCommentId == comment.id,
            onCommentClicked: initialController.isLoggedIn
                ? () {
                    if (controller.selectedCommentId == comment.id) {
                      controller.selectedCommentId = null;
                    } else {
                      controller.selectedCommentId = comment.id;
                    }
                  }
                : null,
          );
        }
        return const ListLoadingItem();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => PostController(
            PostRepository(
                Provider.of<InitialController>(context, listen: false)),
            widget.postId,
            widget.post),
        child: Consumer<PostController>(
          builder: (context, controller, _) {
            if (controller.lastError == null &&
                !controller.isLoading &&
                controller.comments.isEmpty) {
              controller.loadCommentsPage().ignore();
            }
            return PlatformScaffold(
              appBar: FlatAppBar(),
              body: _buildBody(context, controller),
            );
          },
        ));
  }
}
