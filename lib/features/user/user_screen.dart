import 'package:auto_route/auto_route.dart';
import 'package:cookie/api/model/user.dart';
import 'package:cookie/common/controller/initial_controller.dart';
import 'package:cookie/common/ui/notifications.dart';
import 'package:cookie/common/ui/widgets/common/custom_dropdown_button.dart';
import 'package:cookie/common/ui/widgets/common/dynamic_sliver_app_bar.dart';
import 'package:cookie/common/ui/widgets/common/flat_appbar.dart';
import 'package:cookie/common/ui/widgets/common/icon_text.dart';
import 'package:cookie/common/ui/widgets/common/markdown_text.dart';
import 'package:cookie/common/ui/widgets/common/opaque_tab_bar.dart';
import 'package:cookie/common/ui/widgets/error_content.dart';
import 'package:cookie/common/ui/widgets/user_image.dart';
import 'package:cookie/common/util/context_util.dart';
import 'package:cookie/common/util/datetime_util.dart';
import 'package:cookie/features/user/user_controller.dart';
import 'package:cookie/features/user/user_feed.dart';
import 'package:cookie/features/user/user_repository.dart';
import 'package:cookie/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

@RoutePage()
class UserScreen extends StatefulWidget {
  const UserScreen({super.key, @PathParam() required this.username});

  final String username;

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  Future<User>? _loadUser;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  Widget _buildProfileStatItem(
      BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: IconText(
        icon: icon,
        text: text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _buildHeader(BuildContext context, UserController controller) {
    final user = controller.user!;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          kPrimaryPadding,
          kToolbarHeight + kSecondaryPadding,
          kPrimaryPadding,
          kTextTabBarHeight),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 6.0,
                    right: kPrimaryPadding,
                    bottom: kSecondaryPadding),
                child: UserImage(
                  username: widget.username,
                  userImage: user.proPic,
                  size: 80.0,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileStatItem(context, Icons.score,
                        context.l.profilePoints(user.points)),
                    _buildProfileStatItem(context, Icons.message,
                        context.l.profilePosts(user.noPosts)),
                    _buildProfileStatItem(context, Icons.comment,
                        context.l.profileComments(user.noComments)),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      context.l.profileJoined(user.createdAt.toDisplayDate()),
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
          if (user.aboutMe != null)
            Align(
              alignment: Alignment.centerLeft,
              child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200.0),
                  child: SingleChildScrollView(
                      child: MarkdownText(user.aboutMe!))),
            ),
        ],
      ),
    );
  }

  void _toggleMute(BuildContext context, User user) async {
    try {
      final controller = Provider.of<InitialController>(context, listen: false);
      final isMuted = await controller.toggleUserMute(user);
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

  Widget _buildBody(BuildContext context, UserController controller) {
    final initial = Provider.of<InitialController>(context, listen: false);
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: DynamicSliverAppBar(
                pinned: true,
                automaticallyImplyLeading: false,
                flexibleSpace: _buildHeader(context, controller),
                title: FlatAppBar(
                  text: '@${widget.username}',
                  trailingActions: [
                    Padding(
                      padding: const EdgeInsets.only(right: kPrimaryPadding),
                      child: CustomDropdownButton(
                        builder: (context, open) {
                          return const Icon(Icons.more_horiz);
                        },
                        labels: [
                          initial.isUserMuted(controller.user!.id)
                              ? context.l.unmute
                              : context.l.mute,
                        ],
                        values: const [
                          'mute',
                        ],
                        onSelected: (value) {
                          if (value == 'mute') {
                            _toggleMute(context, controller.user!);
                          }
                        },
                      ),
                    )
                  ],
                ),
                titleSpacing: 0.0,
                collapsedHeight: kToolbarHeight,
                toolbarHeight: kToolbarHeight,
                bottom: OpaqueTabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(
                      child: Text(
                        context.l.userFeedAll,
                      ),
                    ),
                    Tab(
                      child: Text(
                        context.l.userFeedPosts,
                      ),
                    ),
                    Tab(
                      child: Text(
                        context.l.userFeedComments,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(controller: _tabController, children: const [
          UserFeed(
            feedType: FeedType.feed,
          ),
          UserFeed(
            feedType: FeedType.posts,
          ),
          UserFeed(
            feedType: FeedType.comments,
          ),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => UserController(
            UserRepository(
                Provider.of<InitialController>(context, listen: false)),
            widget.username),
        child: Consumer<UserController>(
          builder: (context, controller, _) {
            _loadUser ??= controller.getUser();
            return PlatformScaffold(
              body: SafeArea(
                child: FutureBuilder<User>(
                  future: _loadUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return ErrorContent(
                          error: snapshot.error!,
                          retry: () {
                            setState(() {
                              _loadUser = controller.getUser();
                            });
                          });
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      return _buildBody(context, controller);
                    }
                    return Center(child: PlatformCircularProgressIndicator());
                  },
                ),
              ),
            );
          },
        ));
  }
}
