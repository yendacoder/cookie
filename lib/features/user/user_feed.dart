import 'package:cookie/api/model/comment.dart';
import 'package:cookie/api/model/post.dart';
import 'package:cookie/common/controller/initial_controller.dart';
import 'package:cookie/common/ui/notifications.dart';
import 'package:cookie/common/ui/widgets/common/refreshable_list.dart';
import 'package:cookie/common/ui/widgets/error_content.dart';
import 'package:cookie/common/ui/widgets/list_loading_item.dart';
import 'package:cookie/common/ui/widgets/post_item.dart';
import 'package:cookie/common/util/context_util.dart';
import 'package:cookie/common/util/iterable_util.dart';
import 'package:cookie/features/user/feed_comment.dart';
import 'package:cookie/features/user/user_controller.dart';
import 'package:cookie/features/user/user_repository.dart';
import 'package:cookie/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class UserFeed extends StatefulWidget {
  const UserFeed({super.key, required this.feedType});

  final FeedType feedType;

  @override
  State<UserFeed> createState() => _UserFeedState();
}

class _UserFeedState extends State<UserFeed>
    with AutomaticKeepAliveClientMixin {
  Future<void>? _firstPageFuture;

  @override
  bool get wantKeepAlive => true;

  void _loadPage(UserController controller, bool reload) {
    if (reload) {
      controller.reset();
      setState(() {});
    }
    controller
        .loadFeedPage(reload: reload, feedType: widget.feedType)
        .onError((e, _) {
      if (mounted) {
        showApiErrorMessage(context, e);
      }
    });
  }

  Widget _buildBody(BuildContext context) {
    final controller = Provider.of<UserController>(context, listen: false);
    final theme = Theme.of(context);
    final feedViewType =
        Provider.of<InitialController>(context, listen: false).feedViewType;

    if (controller.feed(widget.feedType).isEmpty &&
        !controller.isLoading(widget.feedType)) {
      return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(kPrimaryPaddingDouble),
          child: Text(
            context.l.genericEmpty,
            style: theme.textTheme.titleMedium!
                .copyWith(color: theme.disabledColor),
          ));
    }

    return RefreshableList(
      refreshRequest: () => _loadPage(controller, true),
      nextPageRequest: () => _loadPage(controller, false),
      isLoading: controller.isLoading(widget.feedType),
      needsOverlapInjector: true,
      itemCount: controller.displayItemsCount(widget.feedType),
      itemBuilder: (context, index) {
        final item =
            controller.feed(widget.feedType).elementAtOrNullSafe(index);
        if (item?.itemObject is Post) {
          return PostItem(
            post: item!.itemObject as Post,
            showCommunity: true,
            showAuthor: false,
            isDetailScreen: false,
            viewType: feedViewType,
          );
        } else if (item?.itemObject is Comment) {
          return FeedComment(
            comment: item!.itemObject as Comment,
          );
        }
        return const ListLoadingItem();
      },
      dividerBuilder: (context, index) => const SizedBox(height: 24.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final controller = Provider.of<UserController>(context);
    _firstPageFuture ??= controller.loadFeedPage(feedType: widget.feedType);
    return FutureBuilder(
      future: _firstPageFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorContent(
              error: snapshot.error!,
              retry: () {
                setState(() {
                  _firstPageFuture =
                      controller.loadFeedPage(feedType: widget.feedType);
                });
              });
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildBody(context);
        }
        return Center(child: PlatformCircularProgressIndicator());
      },
    );
  }
}
