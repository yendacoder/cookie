import 'package:auto_route/auto_route.dart';
import 'package:cookie/api/model/community.dart';
import 'package:cookie/api/model/enums.dart';
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

  Widget _buildHeader(
      BuildContext context, InitialController initialController) {
    final theme = Theme.of(context);
    return Column(
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
              size: 80,
            ),
          ),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: kSecondaryPadding),
              child: Text(
                initialController.initial!.user!.username,
                style: theme.textTheme.headlineMedium,
              )),
          _buildProfileItem(context, Icons.score,
              context.l.profilePoints(initialController.initial!.user!.points)),
          _buildProfileItem(context, Icons.message,
              context.l.profilePosts(initialController.initial!.user!.noPosts)),
          _buildProfileItem(
              context,
              Icons.comment,
              context.l.profileComments(
                  initialController.initial!.user!.noComments)),
        ],
        if ((initialController.initial?.communities.length ?? 0) > 0)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kPrimaryPadding),
            child: Text(
              context.l.profileCommunities,
              style: theme.textTheme.titleMedium,
            ),
          )
      ],
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
    final communitiesCount =
        (initialController.initial?.communities.length ?? 0);
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(
          context.l.profile,
        ),
        trailingActions: [
          if (initialController.isLoggedIn)
            PlatformIconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => _logout(initialController))
        ],
      ),
      body: ListView.builder(
        itemCount: communitiesCount + 2,
        padding: const EdgeInsets.all(kPrimaryPadding),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _buildHeader(context, initialController);
          } else if (index > communitiesCount) {
            return _buildFooter(context);
          } else {
            return _buildCommunity(
                context, initialController.initial!.communities[index - 1]);
          }
        },
      ),
    );
  }
}
