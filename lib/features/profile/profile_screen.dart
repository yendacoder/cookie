import 'package:auto_route/auto_route.dart';
import 'package:cookie/api/model/community.dart';
import 'package:cookie/api/model/community_mute.dart';
import 'package:cookie/api/model/enums.dart';
import 'package:cookie/api/model/user.dart';
import 'package:cookie/api/model/user_mute.dart';
import 'package:cookie/common/controller/initial_controller.dart';
import 'package:cookie/common/ui/notifications.dart';
import 'package:cookie/common/ui/widgets/common/icon_text.dart';
import 'package:cookie/common/ui/widgets/common/tappable_item.dart';
import 'package:cookie/common/ui/widgets/community_icon.dart';
import 'package:cookie/common/ui/widgets/user_image.dart';
import 'package:cookie/common/util/context_util.dart';
import 'package:cookie/router/router.gr.dart';
import 'package:cookie/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login(InitialController controller) async {
    try {
      await controller.login(
          _usernameController.text, _passwordController.text);
    } catch (e) {
      if (mounted) {
        showApiErrorMessage(context, e);
      }
    }
  }

  void _logout(InitialController controller) async {
    try {
      await controller.logout();
    } catch (e) {
      if (mounted) {
        showApiErrorMessage(context, e);
      }
    }
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData iconData,
      VoidCallback onTap) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildProfileItem(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kPrimaryPaddingDouble, vertical: kSecondaryPaddingHalf),
      child: IconText(
        icon: icon,
        text: text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _buildCommunity(BuildContext context, Community community) {
    return TappableItem(
      child: ListTile(
        leading: CommunityIcon(
          image: community.proPic,
        ),
        title: Text(community.name),
      ),
      onTap: () => context.router.push(FeedRoute(
          feedType: FeedType.community.name, communityId: community.id)),
    );
  }

  Widget _buildUser(BuildContext context, User user) {
    return TappableItem(
      child: ListTile(
        leading: UserImage(
          username: user.username,
          userImage: user.proPic,
        ),
        title: Text('@${user.username}'),
      ),
      onTap: () => context.router.push(UserRoute(username: user.username)),
    );
  }

  Widget _buildSection(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kPrimaryPadding),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context, InitialController initialController) {
    final theme = Theme.of(context);
    return TappableItem(
      onTap: !initialController.isLoggedIn
          ? null
          : () => context.router.push(
              UserRoute(username: initialController.initial!.user!.username)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!initialController.isLoggedIn) ...[
            PlatformTextField(
              controller: _usernameController,
              hintText: context.l.authUsernameHint,
            ),
            const SizedBox(height: kSecondaryPadding),
            PlatformTextField(
              controller: _passwordController,
              obscureText: true,
              hintText: context.l.authPasswordHint,
            ),
            const SizedBox(height: kSecondaryPadding),
            PlatformElevatedButton(
                child: Text(context.l.authLogin),
                onPressed: () => _login(initialController)),
            const SizedBox(height: kSecondaryPadding),
            PlatformTextButton(
                child: Text(context.l.authRegister),
                onPressed: () => launchUrlString('https://discuit.net/',
                    mode: LaunchMode.externalApplication)),
          ] else ...[
            const SizedBox(
              height: kSecondaryPadding,
            ),
            Center(
              child: UserImage(
                username: initialController.initial!.user!.username,
                userImage: initialController.initial!.user!.proPic,
                size: 80,
              ),
            ),
            Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: kSecondaryPadding),
                child: Text(
                  initialController.initial!.user!.username,
                  style: theme.textTheme.headlineMedium,
                )),
            _buildProfileItem(
                context,
                Icons.score,
                context.l
                    .profilePoints(initialController.initial!.user!.points)),
            _buildProfileItem(
                context,
                Icons.message,
                context.l
                    .profilePosts(initialController.initial!.user!.noPosts)),
            _buildProfileItem(
                context,
                Icons.comment,
                context.l.profileComments(
                    initialController.initial!.user!.noComments)),
          ],
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(),
        _buildMenuItem(
            context,
            context.l.profileAbout,
            Icons.info,
            () => launchUrlString(
                'https://github.com/yendacoder/cookie/blob/main/README.md',
                mode: LaunchMode.externalApplication)),
        _buildMenuItem(
            context, context.l.profileOpenSourceLicenses, Icons.text_snippet,
            () {
          showLicensePage(context: context);
        }),
        FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  snapshot.data?.version != null) {
                return Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, kPrimaryPadding,
                        kSecondaryPadding, kSecondaryPadding),
                    child: Text(
                        context.l.profileVersion(snapshot.data!.version),
                        style: theme.textTheme.bodySmall));
              }
              return const SizedBox();
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final initialController = Provider.of<InitialController>(context);
    final theme = Theme.of(context);
    final List<dynamic> items = [
      if ((initialController.initial?.communities.length ?? 0) > 0) ...[
        context.l.profileCommunities,
        ...initialController.initial!.communities,
      ],
      if ((initialController.initial?.mutes.communityMutes.length ?? 0) >
          0) ...[
        context.l.profileMutedCommunities,
        ...initialController.initial!.mutes.communityMutes,
      ],
      if ((initialController.initial?.mutes.userMutes.length ?? 0) > 0) ...[
        context.l.profileMutedUsers,
        ...initialController.initial!.mutes.userMutes,
      ],
    ];
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(
          context.l.profile,
        ),
        trailingActions: [
          PlatformIconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => context.router.push(const SettingsRoute())),
          if (initialController.isLoggedIn) ...[
            PlatformIconButton(
                icon: Badge(
                    backgroundColor: theme.colorScheme.secondary,
                    isLabelVisible: (initialController
                                .initial?.user?.notificationsNewCount ??
                            0) >
                        0,
                    child: const Icon(Icons.notifications)),
                onPressed: () =>
                    context.router.push(const NotificationsRoute())),
            PlatformIconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => _logout(initialController)),
          ]
        ],
      ),
      body: ListView.builder(
        itemCount: items.length + 2,
        padding: const EdgeInsets.all(kPrimaryPadding),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _buildHeader(context, initialController);
          } else if (index > items.length) {
            return _buildFooter(context);
          } else {
            final item = items[index - 1];
            if (item is String) {
              return _buildSection(context, item);
            } else if (item is UserMute) {
              return _buildUser(context, item.mutedUser);
            } else if (item is CommunityMute) {
              return _buildCommunity(context, item.mutedCommunity);
            } else if (item is Community) {
              return _buildCommunity(context, item);
            }
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
