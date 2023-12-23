import 'package:auto_route/auto_route.dart';
import 'package:cookie/api/model/enums.dart';
import 'package:cookie/common/controller/initial_controller.dart';
import 'package:cookie/common/ui/notifications.dart';
import 'package:cookie/common/ui/widgets/common/flat_appbar.dart';
import 'package:cookie/common/ui/widgets/common/markdown_text.dart';
import 'package:cookie/common/ui/widgets/common/refreshable_list.dart';
import 'package:cookie/common/ui/widgets/common/shimmer.dart';
import 'package:cookie/common/ui/widgets/common/shimmer_placeholders.dart';
import 'package:cookie/common/ui/widgets/common/tappable_item.dart';
import 'package:cookie/common/ui/widgets/community_icon.dart';
import 'package:cookie/common/ui/widgets/error_content.dart';
import 'package:cookie/common/ui/widgets/list_loading_item.dart';
import 'package:cookie/common/ui/widgets/user_image.dart';
import 'package:cookie/common/util/context_util.dart';
import 'package:cookie/common/util/datetime_util.dart';
import 'package:cookie/common/util/iterable_util.dart';
import 'package:cookie/features/notifications/notifications_controller.dart';
import 'package:cookie/features/notifications/notifications_repository.dart';
import 'package:cookie/router/router.gr.dart';
import 'package:cookie/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:cookie/api/model/notification.dart' as api_notif;
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

@RoutePage()
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  Widget _buildNotificationItem(BuildContext context,
      api_notif.Notification notification, NotificationsController controller) {
    late String title;
    if (notification.typeType == NotificationType.newComment) {
      title = context.l.notificationNewComment(
          notification.notif?.commentAuthor ?? '',
          notification.notif?.post?.title ?? '');
    } else if (notification.typeType == NotificationType.commentReply) {
      title = context.l.notificationNewReply(
          notification.notif?.commentAuthor ?? '',
          notification.notif?.post?.title ?? '');
    } else if (notification.typeType == NotificationType.modAdd) {
      title = context.l.notificationModAdd(notification.notif?.addedBy ?? '',
          notification.notif?.community?.name ?? '');
    } else {
      if (notification.notif?.postId != null) {
        title =
            '[${notification.type}] ${context.l.notificationGenericPost(notification.notif?.post?.title ?? '')}';
      } else if (notification.notif?.communityId != null) {
        title =
            '[${notification.type}] ${context.l.notificationGenericCommunity(notification.notif?.community?.name ?? '')}';
      } else {
        title = notification.type;
      }
    }
    final theme = Theme.of(context);
    return TappableItem(
      padding: const EdgeInsets.symmetric(vertical: kSecondaryPadding),
      onTap: notification.notif?.postId != null ||
              notification.notif?.commentId != null
          ? () {
              controller.markAsSeen(notification).ignore();
              if (notification.notif?.post?.publicId != null) {
                context.router.push(PostRoute(
                    postId: notification.notif!.post!.publicId,
                    post: notification.notif?.post));
              }
              if (notification.notif?.communityId != null) {
                context.router.push(FeedRoute(
                    feedType: FeedType.community.name,
                    communityId: notification.notif!.communityId!));
              }
            }
          : null,
      child: ListTile(
        leading: notification.notif?.commentAuthor != null
            ? UserImage(
                username: notification.notif!.commentAuthor!,
                userImage: null,
                size: 48.0,
              )
            : CommunityIcon(
                image: notification.notif?.community?.proPic,
                size: 48.0,
              ),
        title: MarkdownText(
          title,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleSmall!.copyWith(
              color: notification.seen
                  ? theme.disabledColor
                  : theme.colorScheme.onBackground),
        ),
        subtitle: Text(
          '${context.displayElapsedTime(notification.createdAtDate)} - ${notification.createdAtDate.toDisplayDateTimeShort()}',
          style: theme.textTheme.bodyMedium!.copyWith(
              color: notification.seen ? theme.disabledColor : theme.hintColor),
        ),
      ),
    );
  }

  void _loadPage(NotificationsController controller, bool reload) {
    if (reload) {
      controller.reset();
      setState(() {});
    }
    controller.loadNotificationsPage(reload: reload).onError((e, _) {
      if (mounted) {
        showApiErrorMessage(context, e);
      }
    });
  }

  Widget _buildLoadingItem() {
    return const Padding(
      padding: EdgeInsets.all(kPrimaryPadding),
      child: ShimmerText(
        lines: 2,
      ),
    );
  }

  Widget _buildBody(BuildContext context, NotificationsController controller) {
    if (controller.lastError != null) {
      return ErrorContent(
        error: controller.lastError!,
        retry: () {
          _loadPage(controller, true);
        },
      );
    }
    if (controller.isLoading && controller.notifications.isEmpty) {
      return Shimmer(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            for (int i = 0; i < 5; i++) ...[
              _buildLoadingItem(),
              const SizedBox(
                height: 24.0,
              ),
            ]
          ],
        ),
      );
    }
    return RefreshableList(
      refreshRequest: () => _loadPage(controller, true),
      nextPageRequest: () => _loadPage(controller, false),
      isLoading: controller.isLoading,
      itemCount: controller.displayItemsCount,
      itemBuilder: (context, index) {
        final notification =
            controller.notifications.elementAtOrNullSafe(index);
        if (notification != null) {
          return _buildNotificationItem(context, notification, controller);
        }
        return const ListLoadingItem();
      },
      dividerBuilder: (context, index) =>
          const SizedBox(height: kPrimaryPadding),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => NotificationsController(
              NotificationsRepository(
                  Provider.of<InitialController>(context, listen: false)),
            ),
        child: Consumer<NotificationsController>(
          builder: (context, controller, _) {
            if (controller.lastError == null &&
                !controller.isLoading &&
                controller.notifications.isEmpty) {
              controller.loadNotificationsPage().ignore();
            }
            return PlatformScaffold(
              appBar: FlatAppBar(text: context.l.notificationsTitle),
              body: SafeArea(
                child: _buildBody(context, controller),
              ),
            );
          },
        ));
  }
}
