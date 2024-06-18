import 'package:auto_route/auto_route.dart';
import 'package:cookie/api/model/community.dart';
import 'package:cookie/api/model/enums.dart';
import 'package:cookie/common/controller/initial_controller.dart';
import 'package:cookie/common/repository/settings_repository.dart';
import 'package:cookie/common/ui/notifications.dart';
import 'package:cookie/common/ui/widgets/common/custom_dropdown_button.dart';
import 'package:cookie/common/ui/widgets/common/dynamic_sliver_app_bar.dart';
import 'package:cookie/common/ui/widgets/common/flat_appbar.dart';
import 'package:cookie/common/ui/widgets/common/icon_text.dart';
import 'package:cookie/common/ui/widgets/common/markdown_text.dart';
import 'package:cookie/common/ui/widgets/common/platform_custom_popup_menu.dart';
import 'package:cookie/common/ui/widgets/common/refreshable_list.dart';
import 'package:cookie/common/ui/widgets/common/shimmer.dart';
import 'package:cookie/common/ui/widgets/common/shimmer_placeholders.dart';
import 'package:cookie/common/ui/widgets/community_icon.dart';
import 'package:cookie/common/ui/widgets/error_content.dart';
import 'package:cookie/common/ui/widgets/list_loading_item.dart';
import 'package:cookie/common/ui/widgets/post_item.dart';
import 'package:cookie/common/util/context_util.dart';
import 'package:cookie/common/util/iterable_util.dart';
import 'package:cookie/common/util/datetime_util.dart';
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

const _kToolbarItemSize = 56.0;

class _FeedContentScreenScreenState extends State<FeedContentScreen> {
  final _sortMenuKey = GlobalKey<PlatformCustomPopupMenuState>();
  final _listKey = GlobalKey();
  ScrollController? _scrollController;
  double _toolbarOffset = 0.0;

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  void _loadPage(FeedController controller, bool reload) {
    if (reload) {
      controller.reset();
      setState(() {});
    }
    controller.loadPage().onError((e, _) {
      if (mounted) {
        showApiErrorMessage(context, e);
      }
    });
  }

  void _toggleMute(BuildContext context, Community community) async {
    try {
      final controller = Provider.of<InitialController>(context, listen: false);
      final isMuted = await controller.toggleCommunityMute(community);
      if (context.mounted) {
        showNotification(
            context, isMuted ? context.l.mutedAdded : context.l.mutedRemoved);
      }
    } catch (e) {
      if (context.mounted) {
        showApiErrorMessage(context, e);
      }
    }
  }

  Widget _buildLoadingItem(FeedViewType viewType) {
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
          if (viewType == FeedViewType.full ||
              viewType == FeedViewType.regular) ...[
            const SizedBox(
              height: 12.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(kDefaultCornerRadius),
              child: const AspectRatio(
                  aspectRatio: 16 / 9, child: ColoredBox(color: Colors.white)),
            ),
          ],
          const SizedBox(
            height: 12.0,
          ),
          const ShimmerText(lines: 1, textSize: 32.0),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, FeedController controller) {
    final feedViewType =
        Provider.of<InitialController>(context, listen: false).feedViewType;
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
          // would be cleaner to add overlapInjector to this list,
          // but it would be a big overhead, will add fake padding instead
          padding: controller.feedType == FeedType.community
              ? const EdgeInsets.only(top: kToolbarHeight)
              : null,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (int i = 0;
                i <
                    ((feedViewType == FeedViewType.full ||
                            feedViewType == FeedViewType.regular)
                        ? 3
                        : 5);
                i++) ...[
              _buildLoadingItem(feedViewType),
              const SizedBox(
                height: 24.0,
              ),
            ]
          ],
        ),
      );
    }
    return RefreshableList(
      key: _listKey,
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
            viewType: feedViewType,
          );
        }
        return const ListLoadingItem();
      },
      dividerBuilder: (context, index) => const SizedBox(height: 24.0),
      needsOverlapInjector: controller.feedType == FeedType.community,
      onScroll: (delta, controller) {
        if (_toolbarOffset < 0 &&
            (controller.position.extentBefore == 0 || delta < -10)) {
          setState(() {
            _toolbarOffset = 0;
          });
        }
        if (_toolbarOffset == 0 && delta > 10) {
          setState(() {
            _toolbarOffset = -_kToolbarItemSize - kSecondaryPadding * 2;
          });
        }
      },
    );
  }

  Widget _buildToolbarItem(BuildContext context, IconData? icon,
      Color? backgroundColor, VoidCallback? onTap,
      {String? label, bool withBadge = false, Widget? customContent}) {
    final theme = Theme.of(context);
    Widget content = customContent ??
        Icon(
          icon,
          color:
              onTap == null ? theme.disabledColor : theme.colorScheme.onSurface,
        );
    if (label != null) {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label,
              style: theme.textTheme.labelSmall!.copyWith(
                fontSize: 8.0,
              )),
          content,
        ],
      );
    }
    // padding has to be applied on the item level, so that
    // spacing is equal on all items
    return IconButton(
      onPressed: onTap,
      style: theme.iconButtonTheme.style!.copyWith(
        backgroundColor: WidgetStateProperty.all(
            backgroundColor ?? theme.colorScheme.surface),
        shape: WidgetStateProperty.all(CircleBorder(
            side: BorderSide(color: theme.colorScheme.onSurface, width: 1.0))),
        minimumSize: WidgetStateProperty.all(
            const Size(_kToolbarItemSize, _kToolbarItemSize)),
      ),
      padding: label == null
          ? const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0)
          : const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 4.0),
      icon: Badge(
          backgroundColor: theme.colorScheme.secondary,
          isLabelVisible: withBadge,
          child: content),
    );
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
                  context.router
                      .push(ComposeRoute(community: controller.community));
                })
    ];
  }

  /// Build a panel that pretends to be a bottom navigation bar,
  /// but we will use it for buttons
  Widget _buildToolbar(BuildContext context, FeedController controller) {
    final theme = Theme.of(context);
    final isLoggedIn =
        Provider.of<InitialController>(context, listen: false).isLoggedIn;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kSecondaryPadding),
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
            if (_scrollController!.offset > 0) {
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
          },
              withBadge: (Provider.of<InitialController>(context)
                          .initial
                          ?.user
                          ?.notificationsNewCount ??
                      0) >
                  0),
        ],
      ),
    );
  }

  Widget _buildCommunityToolbar(
      BuildContext context, FeedController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kSecondaryPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            width: _kToolbarItemSize,
          ),
          ..._buildCommonToolbarActions(context, controller),
          const SizedBox(
            width: _kToolbarItemSize,
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityHeader(BuildContext context, Community community,
      InitialController initialController) {
    final theme = Theme.of(context);
    return Padding(
        padding: const EdgeInsets.fromLTRB(kPrimaryPadding,
            kToolbarHeight + kSecondaryPadding, kPrimaryPadding, kSecondaryPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 6.0,
                      right: kPrimaryPadding,
                      bottom: kSecondaryPadding),
                  child: CommunityIcon(
                    image: community.proPic,
                    size: 80.0,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconText(
                        icon: Icons.people,
                        text: context.l.communityNoMembers(community.noMembers),
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        context.l.communityCreated(
                            community.createdAt.toDisplayDate()),
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.hintColor,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: kPrimaryPadding),
            if (community.about != null) MarkdownText(community.about!),
            Padding(
              padding: const EdgeInsets.only(top: kSecondaryPadding),
              child: PlatformElevatedButton(
                  color:
                      initialController.isLoggedIn && community.userJoined != true
                          ? theme.colorScheme.secondary
                          : null,
                  onPressed: initialController.isLoggedIn &&
                          community.userMod != true
                      ? () async {
                          try {
                            await initialController
                                .toggleJoinCommunity(community);
                            if (context.mounted) {
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
                            if (context.mounted) {
                              showApiErrorMessage(context, e);
                            }
                          }
                        }
                      : null,
                  child: Text(community.userJoined == true
                      ? context.l.communityLeave
                      : context.l.communityJoin)),
            ),
          ],
        ),
    );
  }

  Widget _buildCommunityBody(BuildContext context, FeedController controller) {
    final initialController =
        Provider.of<InitialController>(context, listen: false);
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: DynamicSliverAppBar(
                key: ValueKey(controller.community?.id),
                pinned: true,
                automaticallyImplyLeading: false,
                flexibleSpace: controller.community == null
                    ? null
                    : _buildCommunityHeader(
                        context, controller.community!, initialController),
                title: controller.community == null
                    ? FlatAppBar()
                    : FlatAppBar(
                        text: controller.community!.name,
                        trailingActions: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: kPrimaryPadding),
                            child: CustomDropdownButton(
                              builder: (context, open) {
                                return const Icon(Icons.more_horiz);
                              },
                              labels: [
                                initialController.isCommunityMuted(
                                        controller.community!.id)
                                    ? 'Unmute'
                                    : 'Mute',
                              ],
                              values: const [
                                'mute',
                              ],
                              onSelected: (value) {
                                if (value == 'mute') {
                                  _toggleMute(context, controller.community!);
                                }
                              },
                            ),
                          )
                        ],
                      ),
                titleSpacing: 0.0,
                collapsedHeight: kToolbarHeight,
                toolbarHeight: kToolbarHeight,
              ),
            ),
          ];
        },
        body: Stack(
          children: [
            Positioned.fill(child: _buildBody(context, controller)),
            AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: 0,
                right: 0,
                bottom: _toolbarOffset,
                child: _buildCommunityToolbar(context, controller)),
          ],
        ),
      ),
    );
  }

  Widget _buildMainBody(BuildContext context, FeedController controller) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(child: _buildBody(context, controller)),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: 0,
              right: 0,
              bottom: _toolbarOffset,
              child: _buildToolbar(context, controller)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InitialController>(builder: (context, _, __) {
      return Consumer<FeedController>(
        builder: (context, controller, _) {
          if (controller.feedType != FeedType.community && _scrollController == null) {
            _scrollController = ScrollController();
          }
          if (controller.lastError == null &&
              !controller.isLoading &&
              controller.posts.isEmpty) {
            controller.loadPage().ignore();
          }
          return PlatformScaffold(
            body: controller.feedType == FeedType.community
                ? _buildCommunityBody(context, controller)
                : _buildMainBody(context, controller),
          );
        },
      );
    });
  }
}
