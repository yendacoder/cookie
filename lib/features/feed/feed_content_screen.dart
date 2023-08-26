import 'package:auto_route/auto_route.dart';
import 'package:cookie/api/model/enums.dart';
import 'package:cookie/common/controller/initial_controller.dart';
import 'package:cookie/common/ui/notifications.dart';
import 'package:cookie/common/ui/widgets/common/flat_appbar.dart';
import 'package:cookie/common/ui/widgets/common/platform_custom_popup_menu.dart';
import 'package:cookie/common/ui/widgets/common/refreshable_list.dart';
import 'package:cookie/common/ui/widgets/common/shimmer.dart';
import 'package:cookie/common/ui/widgets/common/shimmer_placeholders.dart';
import 'package:cookie/common/ui/widgets/common/tappable_item.dart';
import 'package:cookie/common/ui/widgets/community_icon.dart';
import 'package:cookie/common/ui/widgets/error_content.dart';
import 'package:cookie/common/ui/widgets/list_loading_item.dart';
import 'package:cookie/common/ui/widgets/post_item.dart';
import 'package:cookie/common/util/context_util.dart';
import 'package:cookie/common/util/iterable_util.dart';
import 'package:cookie/features/feed/feed_controller.dart';
import 'package:cookie/router/router.gr.dart';
import 'package:cookie/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

@RoutePage()
class FeedContentScreen extends StatefulWidget {
  const FeedContentScreen({super.key});

  @override
  State<FeedContentScreen> createState() => _FeedContentScreenScreenState();
}

class _FeedContentScreenScreenState extends State<FeedContentScreen> {
  final _sortMenuKey = GlobalKey<PlatformCustomPopupMenuState>();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadPage(FeedController controller, bool reload) {
    if (reload) {
      controller.reset();
      setState(() {});
    }
    controller.loadPage().onError((e, _) => showApiErrorMessage(context, e));
  }

  Widget _buildLoadingItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kPrimaryPadding, vertical: kSecondaryPadding),
      child: Column(
        children: [
          const Row(
            children: [
              ShimmerAvatar(),
              SizedBox(
                width: 6.0,
              ),
              SizedBox(width: 80, child: ShimmerText(lines: 1)),
              Spacer(),
              SizedBox(width: 80, child: ShimmerText(lines: 1)),
              SizedBox(
                width: 6.0,
              ),
              ShimmerAvatar()
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(kDefaultCornerRadius),
            child: const AspectRatio(
                aspectRatio: 16 / 9, child: ColoredBox(color: Colors.white)),
          ),
          const SizedBox(
            height: 12.0,
          ),
          const ShimmerText(lines: 1, textSize: 32.0),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, FeedController controller) {
    if (controller.lastError != null) {
      return ErrorContent(
        error: controller.lastError!,
        retry: () {
          _loadPage(controller, true);
        },
      );
    }
    if (controller.isLoading && controller.posts.isEmpty) {
      return Shimmer(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildLoadingItem(),
            const SizedBox(
              height: 24.0,
            ),
            _buildLoadingItem(),
            const SizedBox(
              height: 24.0,
            ),
            _buildLoadingItem(),
          ],
        ),
      );
    }
    return RefreshableList(
      refreshRequest: () => _loadPage(controller, true),
      nextPageRequest: () => _loadPage(controller, false),
      isLoading: controller.isLoading,
      itemCount: controller.displayItemsCount,
      scrollController: _scrollController,
      itemBuilder: (context, index) {
        final post = controller.posts.elementAtOrNullSafe(index);
        if (post != null) {
          return PostItem(
            post: post,
            showCommunity: controller.feedType != FeedType.community,
            isDetailScreen: false,
          );
        }
        return const ListLoadingItem();
      },
      dividerBuilder: (context, index) => const SizedBox(height: 24.0),
    );
  }

  Widget _buildToolbarItem(BuildContext context, IconData icon,
      Color? backgroundColor, VoidCallback? onTap,
      {String? label}) {
    final theme = Theme.of(context);
    // padding has to be applied on the item level, so that
    // spacing is equal on all items
    final item = TappableItem(
      onTap: onTap,
      padding: label == null
          ? const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0)
          : const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 4.0),
      child: Icon(icon,
          color: onTap == null
              ? theme.disabledColor
              : theme.colorScheme.onBackground),
    );
    if (backgroundColor != null) {
      return DecoratedBox(
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: backgroundColor,
        ),
        child: item,
      );
    }
    if (label != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22.0),
            child: Text(label, style: theme.textTheme.labelSmall),
          ),
          item,
        ],
      );
    }
    return item;
  }

  String _getSortingOrderName(FeedController controller) {
    switch (controller.contentSorting) {
      case ContentSorting.hot:
        return context.l.sortingHot;
      case ContentSorting.all:
        return context.l.sortingAll;
      case ContentSorting.activity:
        return context.l.sortingActivity;
      case ContentSorting.latest:
        return context.l.sortingLatest;
      case ContentSorting.day:
        return context.l.sortingDay;
      case ContentSorting.week:
        return context.l.sortingWeek;
      case ContentSorting.month:
        return context.l.sortingMonth;
      case ContentSorting.year:
        return context.l.sortingYear;
    }
  }

  void _setSorting(FeedController controller, ContentSorting sorting) {
    controller.contentSorting = sorting;
  }

  List<Widget> _buildCommonToolbarActions(
      BuildContext context, FeedController controller) {
    final isLoggedIn =
        Provider.of<InitialController>(context, listen: false).isLoggedIn;
    return [
      PlatformCustomPopupMenu(
        key: _sortMenuKey,
        options: [
          PopupMenuOption(
              label: context.l.sortingHot,
              onTap: (_) => _setSorting(controller, ContentSorting.hot)),
          PopupMenuOption(
              label: context.l.sortingActivity,
              onTap: (_) => _setSorting(controller, ContentSorting.activity)),
          PopupMenuOption(
              label: context.l.sortingLatest,
              onTap: (_) => _setSorting(controller, ContentSorting.latest)),
          PopupMenuOption(
              label: context.l.sortingDay,
              onTap: (_) => _setSorting(controller, ContentSorting.day)),
          PopupMenuOption(
              label: context.l.sortingWeek,
              onTap: (_) => _setSorting(controller, ContentSorting.week)),
          PopupMenuOption(
              label: context.l.sortingMonth,
              onTap: (_) => _setSorting(controller, ContentSorting.month)),
          PopupMenuOption(
              label: context.l.sortingYear,
              onTap: (_) => _setSorting(controller, ContentSorting.year)),
        ],
        child: _buildToolbarItem(context, Icons.sort, null, () {
          _sortMenuKey.currentState?.showButtonMenu();
        }, label: _getSortingOrderName(controller)),
      ),
      _buildToolbarItem(
          context,
          Icons.post_add,
          null,
          !isLoggedIn
              ? null
              : () {
                  context.router.push(const ComposeRoute());
                })
    ];
  }

  /// Build a panel that pretends to be a bottom navigation bar,
  /// but we will use it for buttons
  Widget _buildToolbar(BuildContext context, FeedController controller) {
    final theme = Theme.of(context);
    final isLoggedIn =
        Provider.of<InitialController>(context, listen: false).isLoggedIn;
    return Container(
      height: kNavigationBarHeight,
      color: theme.colorScheme.background,
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildToolbarItem(
              context,
              controller.feedType == FeedType.home
                  ? Icons.home
                  : Icons.all_inclusive,
              isLoggedIn
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.primary, () {
            if (_scrollController.offset > 0) {
              _loadPage(controller, true);
            } else {
              if (isLoggedIn) {
                controller.toggleFeedType();
              }
            }
          }),
          ..._buildCommonToolbarActions(context, controller),
          _buildToolbarItem(context, Icons.person, null, () {
            context.router.push(const ProfileRoute());
          }),
        ],
      ),
    );
  }

  Widget _buildCommunityToolbar(
      BuildContext context, FeedController controller) {
    final theme = Theme.of(context);
    final community = controller.community!;
    final initialController = Provider.of<InitialController>(context);
    return Container(
      height: kNavigationBarHeight,
      color: theme.colorScheme.background,
      child: Row(
        children: [
          const SizedBox(
            width: kPrimaryPadding,
          ),
          TappableItem(
              onTap: () => _loadPage(controller, true),
              child: CommunityIcon(image: community.proPic, size: 40.0)),
          const SizedBox(
            width: 12.0,
          ),
          if (community.userMod != true)
            PlatformElevatedButton(
                color:
                    initialController.isLoggedIn && community.userJoined != true
                        ? theme.colorScheme.secondary
                        : null,
                onPressed: initialController.isLoggedIn
                    ? () async {
                        try {
                          await initialController
                              .toggleJoinCommunity(community);
                          if (mounted) {
                            if (community.userJoined == true) {
                              showNotification(
                                  context,
                                  context.l
                                      .communityJoinMessage(community.name));
                            } else {
                              showNotification(
                                  context,
                                  context.l
                                      .communityLeaveMessage(community.name));
                            }
                          }
                        } catch (e) {
                          if (mounted) {
                            showApiErrorMessage(context, e);
                          }
                        }
                      }
                    : null,
                child: Text(community.userJoined == true
                    ? context.l.communityLeave
                    : context.l.communityJoin)),
          const Spacer(),
          Container(
              height: kNavigationBarHeight,
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: _buildCommonToolbarActions(context, controller))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FeedController>(
      builder: (context, controller, _) {
        if (controller.lastError == null &&
            !controller.isLoading &&
            controller.posts.isEmpty) {
          controller.loadPage().ignore();
        }
        return PlatformScaffold(
          appBar:
              controller.feedType == FeedType.community ? FlatAppBar() : null,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(child: _buildBody(context, controller)),
                if (controller.feedType == FeedType.community &&
                    controller.community != null)
                  _buildCommunityToolbar(context, controller),
                if (controller.feedType != FeedType.community)
                  _buildToolbar(context, controller),
              ],
            ),
          ),
        );
      },
    );
  }
}
