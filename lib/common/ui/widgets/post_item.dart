import 'package:auto_route/auto_route.dart';
import 'package:cookie/api/model/enums.dart';
import 'package:cookie/api/model/link.dart';
import 'package:cookie/api/model/post.dart';
import 'package:cookie/common/controller/initial_controller.dart';
import 'package:cookie/common/repository/settings_repository.dart';
import 'package:cookie/common/ui/notifications.dart';
import 'package:cookie/common/ui/widgets/common/icon_text.dart';
import 'package:cookie/common/ui/widgets/common/markdown_text.dart';
import 'package:cookie/common/ui/widgets/common/tappable_item.dart';
import 'package:cookie/common/ui/widgets/common/voting.dart';
import 'package:cookie/common/ui/widgets/community_icon.dart';
import 'package:cookie/common/ui/widgets/post_image.dart';
import 'package:cookie/common/ui/widgets/username.dart';
import 'package:cookie/common/util/context_util.dart';
import 'package:cookie/common/util/datetime_util.dart';
import 'package:cookie/features/feed/feed_controller.dart';
import 'package:cookie/features/post/post_controller.dart';
import 'package:cookie/router/router.gr.dart';
import 'package:cookie/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PostItem extends StatefulWidget {
  const PostItem(
      {super.key,
      required this.post,
      required this.showCommunity,
      required this.isDetailScreen,
      this.isContentClickable = true,
      this.viewType = FeedViewType.full});

  final Post post;
  final bool showCommunity;
  final bool isDetailScreen;
  final FeedViewType viewType;

  /// If showed on the detail page, the main content should not lead anywhere
  final bool isContentClickable;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  final ValueNotifier<bool?> _isVotingUp = ValueNotifier(null);

  @override
  void dispose() {
    _isVotingUp.dispose();
    super.dispose();
  }

  Future<void> _vote(BuildContext context, bool up) async {
    try {
      _isVotingUp.value = up;
      if (widget.isDetailScreen) {
        final postController =
            Provider.of<PostController>(context, listen: false);
        final feedController =
            Provider.of<FeedController>(context, listen: false);
        await postController.vote(up);
        feedController.updateVoted(postController.post);
      } else {
        await Provider.of<FeedController>(context, listen: false)
            .vote(widget.post.id, up);
      }
    } catch (e) {
      showApiErrorMessage(context, e);
    } finally {
      _isVotingUp.value = null;
    }
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPrimaryPadding),
      child: Row(
        children: [
          Expanded(
              child: Username(
            username: widget.post.username,
          )),
          const SizedBox(
            width: 6.0,
          ),
          if (widget.post.isPinned) ...[
            Icon(
              Icons.push_pin,
              size: 18.0,
              color: theme.colorScheme.primary,
            ),
            if (widget.showCommunity)
              const SizedBox(
                width: 4.0,
              ),
          ],
          if (widget.showCommunity)
            TappableItem(
                onTap: () {
                  context.router.push(FeedRoute(
                    feedType: FeedType.community.name,
                    communityId: widget.post.communityId,
                  ));
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.post.communityName,
                      style: theme.textTheme.labelMedium!
                          .copyWith(color: theme.hintColor),
                    ),
                    const SizedBox(
                      width: 6.0,
                    ),
                    Opacity(
                        opacity: 0.6,
                        child:
                            CommunityIcon(image: widget.post.communityProPic)),
                  ],
                )),
        ],
      ),
    );
  }

  Widget _buildTextLink(BuildContext context, Link link) {
    final theme = Theme.of(context);
    return TappableItem(
      child: Text(link.url,
          style: theme.textTheme.titleMedium!.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline)),
      onTap: () =>
          launchUrlString(link.url, mode: LaunchMode.externalApplication),
    );
  }

  Widget _buildFullBody(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.post.title,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(
            height: 12.0,
          ),
          if (widget.post.body != null) MarkdownText(widget.post.body!),
          if (widget.post.postType == PostType.link &&
              widget.post.link?.image != null)
            PostImage(link: widget.post.link),
          if (widget.post.postType == PostType.image &&
              widget.post.image != null)
            PostImage(image: widget.post.image),
          if (widget.post.postType == PostType.link &&
              widget.post.link != null &&
              widget.post.link?.image == null)
            _buildTextLink(context, widget.post.link!)
        ]);
  }

  Widget _buildRegularBody(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.post.title,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(
            height: 12.0,
          ),
          if (widget.post.body != null)
            MarkdownText(
              widget.post.body!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          if (widget.post.postType == PostType.link &&
              widget.post.link?.image != null)
            PostImage(
              link: widget.post.link,
              aspectRatio: kDefaultImageAspectRatio,
              previewOnTap: true,
            ),
          if (widget.post.postType == PostType.image &&
              widget.post.image != null)
            PostImage(
              image: widget.post.image,
              aspectRatio: kDefaultImageAspectRatio,
              previewOnTap: true,
            ),
          if (widget.post.postType == PostType.link &&
              widget.post.link != null &&
              widget.post.link?.image == null)
            _buildTextLink(context, widget.post.link!)
        ]);
  }

  Widget _buildCompactBody(BuildContext context) {
    final theme = Theme.of(context);
    return IntrinsicHeight(
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: Text(
            widget.post.title,
            style: theme.textTheme.titleLarge,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        if (widget.post.postType == PostType.link &&
            widget.post.link?.image != null)
          SizedBox(
              width: 100,
              height: 60,
              child: PostImage(
                link: widget.post.link,
                previewOnTap: true,
              )),
        if (widget.post.postType == PostType.image && widget.post.image != null)
          SizedBox(
              width: 100,
              height: 60,
              child: PostImage(
                image: widget.post.image,
                previewOnTap: true,
              ))
      ]),
    );
  }

  Widget _buildMicroBody(BuildContext context) {
    return Text(
      widget.post.title,
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _buildCommonBody(BuildContext context) {
    late final Widget body;
    switch (widget.viewType) {
      case FeedViewType.full:
        body = _buildFullBody(context);
      case FeedViewType.regular:
        body = _buildRegularBody(context);
      case FeedViewType.compact:
        body = _buildCompactBody(context);
      case FeedViewType.micro:
        body = _buildMicroBody(context);
    }
    return TappableItem(
        onTap: !widget.isContentClickable
            ? null
            : () {
                context.router.push(
                    PostRoute(postId: widget.post.publicId, post: widget.post));
              },
        padding: const EdgeInsets.symmetric(
            horizontal: kPrimaryPadding, vertical: 4.0),
        child: body);
  }

  Widget _buildFooter(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(
          left: kPrimaryPadding - 8.0, right: kPrimaryPadding),
      child: Row(
        children: [
          ValueListenableBuilder(
              valueListenable: _isVotingUp,
              builder: (context, isVotingUp, _) {
                return Voting(
                    upvotes: widget.post.upvotes,
                    downvotes: widget.post.downvotes,
                    isVotedUp: widget.post.userVoted == true &&
                        widget.post.userVotedUp == true,
                    isVotedDown: widget.post.userVoted == true &&
                        widget.post.userVotedUp != true,
                    isLoadingUp: isVotingUp == true,
                    isLoadingDown: isVotingUp == false,
                    onVote:
                        !Provider.of<InitialController>(context, listen: false)
                                .isLoggedIn
                            ? null
                            : (up) => _vote(context, up));
              }),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: TappableItem(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              onTap: !widget.isContentClickable
                  ? null
                  : () => context.router.push(PostRoute(
                      postId: widget.post.publicId, post: widget.post)),
              child: IconText(
                icon: Icons.comment,
                text: widget.post.noComments.toString(),
                iconColor: theme.hintColor,
                style: theme.textTheme.labelMedium!
                    .copyWith(color: theme.hintColor),
              ),
            ),
          ),
          Tooltip(
            message: widget.post.createdAtDate.toDisplayDateTimeShort(),
            child: Text(
              context.displayElapsedTime(widget.post.createdAtDate),
              style:
                  theme.textTheme.labelMedium!.copyWith(color: theme.hintColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kSecondaryPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          if (widget.viewType != FeedViewType.micro)
            const SizedBox(
              height: 8.0,
            ),
          _buildCommonBody(context),
          if (widget.viewType != FeedViewType.micro) _buildFooter(context),
        ],
      ),
    );
  }
}
