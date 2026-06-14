// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Cookie';

  @override
  String appNameVersion(String version) {
    return 'Cookie for Discuit, version $version';
  }

  @override
  String get navHome => 'Home';

  @override
  String get navSubscriptions => 'Subscriptions';

  @override
  String get navModerating => 'Moderating';

  @override
  String get navCommunities => 'Communities';

  @override
  String get navLists => 'Lists';

  @override
  String get navProfile => 'Profile';

  @override
  String get loginTitle => 'Sign in';

  @override
  String get navPost => 'Post';

  @override
  String get loginUsernameLabel => 'Username';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginButton => 'Sign in';

  @override
  String get loginRegisterPrompt => 'Don\'t have an account?';

  @override
  String get loginRegisterLink => 'Register on the web';

  @override
  String get loginTermsLabel => 'By using the app you agree to';

  @override
  String get loginAppTermsLink => 'App Terms of Service';

  @override
  String get loginDiscuitTermsLink => 'Discuit Terms of Service';

  @override
  String get loginErrorInvalid => 'Invalid username or password';

  @override
  String get loginErrorSuspended => 'This account has been suspended';

  @override
  String get errorGeneric => 'Something went wrong';

  @override
  String get errorNetworkTitle => 'Network error';

  @override
  String get errorNetworkBody =>
      'Unable to reach the server. Check your internet connection.';

  @override
  String get errorParseTitle => 'Parsing error';

  @override
  String get errorParseBody =>
      'The server returned an unexpected response. The app may need to be updated.';

  @override
  String errorParseField(String field) {
    return 'Field: $field';
  }

  @override
  String get errorUnknownTitle => 'Unexpected error';

  @override
  String get errorUnknownBody => 'An unexpected error occurred.';

  @override
  String get errorAuthRequired => 'Sign in to continue';

  @override
  String get errorAuthRequiredBody =>
      'You need to be signed in to view this section.';

  @override
  String get sortHot => 'Hot';

  @override
  String get sortNew => 'New';

  @override
  String get sortTop => 'Top';

  @override
  String get sortActivity => 'Activity';

  @override
  String get sortDay => 'Today';

  @override
  String get sortWeek => 'This week';

  @override
  String get sortMonth => 'This month';

  @override
  String get sortYear => 'This year';

  @override
  String get sortAll => 'All time';

  @override
  String get loadingLabel => 'Loading…';

  @override
  String get timeJustNow => 'just now';

  @override
  String timeMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count min ago',
      one: '1 min ago',
    );
    return '$_temp0';
  }

  @override
  String timeHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hr ago',
      one: '1 hr ago',
    );
    return '$_temp0';
  }

  @override
  String timeDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days ago',
      one: '1 day ago',
    );
    return '$_temp0';
  }

  @override
  String timeWeeksAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count weeks ago',
      one: '1 week ago',
    );
    return '$_temp0';
  }

  @override
  String timeMonthsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count months ago',
      one: '1 month ago',
    );
    return '$_temp0';
  }

  @override
  String timeYearsAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count years ago',
      one: '1 year ago',
    );
    return '$_temp0';
  }

  @override
  String get postDetailNoComments => 'No comments yet';

  @override
  String get postDetailLoadMoreComments => 'Load more comments';

  @override
  String get postDetailCommentDeleted => '[deleted]';

  @override
  String get feedEndOfContent => 'You\'re all caught up';

  @override
  String get feedLoadMoreError => 'Couldn\'t load more posts';

  @override
  String get retryButton => 'Try again';

  @override
  String get signInButton => 'Sign in';

  @override
  String get upvote => 'Upvote';

  @override
  String get downvote => 'Downvote';

  @override
  String get share => 'Share';

  @override
  String commentsLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count comments',
      one: '1 comment',
      zero: 'No comments',
    );
    return '$_temp0';
  }

  @override
  String pointsLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count points',
      one: '1 point',
    );
    return '$_temp0';
  }

  @override
  String membersLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count members',
      one: '1 member',
    );
    return '$_temp0';
  }

  @override
  String get joinButton => 'Join';

  @override
  String get leaveButton => 'Leave';

  @override
  String get communityRulesTitle => 'Rules';

  @override
  String get communityNoRules => 'This community has no rules.';

  @override
  String get communityModeratorsTitle => 'Moderators';

  @override
  String get communityNoModerators => 'No moderators listed.';

  @override
  String get communityCreatePost => 'New post';

  @override
  String postBy(String username) {
    return 'by $username';
  }

  @override
  String inCommunity(String community) {
    return 'in $community';
  }

  @override
  String get homeScreenTitle => 'Home';

  @override
  String get subscriptionsScreenTitle => 'Subscriptions';

  @override
  String get moderatingScreenTitle => 'Moderating';

  @override
  String get communitiesScreenTitle => 'Communities';

  @override
  String get listsScreenTitle => 'Lists';

  @override
  String get profileScreenTitle => 'Profile';

  @override
  String get logoutButton => 'Sign out';

  @override
  String get logoutConfirmTitle => 'Sign out?';

  @override
  String get logoutConfirmBody =>
      'You will need to sign in again to access your account.';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get okayButton => 'OK';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get communityMute => 'Mute';

  @override
  String get communityUnmute => 'Unmute';

  @override
  String get userTabAll => 'All';

  @override
  String get userTabPosts => 'Posts';

  @override
  String get userTabComments => 'Comments';

  @override
  String get userMute => 'Mute';

  @override
  String get userUnmute => 'Unmute';

  @override
  String userJoined(String date) {
    return 'Joined $date';
  }

  @override
  String get userAdmin => 'Admin';

  @override
  String postsLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count posts',
      one: '1 post',
    );
    return '$_temp0';
  }

  @override
  String get commentHint => 'Add a comment…';

  @override
  String commentPostReference(String post) {
    return 'on $post';
  }

  @override
  String commentReplyingTo(String username) {
    return 'Replying to @$username';
  }

  @override
  String get commentReplyButton => 'Reply';

  @override
  String get commentOP => 'OP';

  @override
  String get commentAdmin => 'Admin';

  @override
  String get commentMutedUsername => 'Muted';

  @override
  String get commentMutedHiddenText =>
      'You\'ve muted this user. Tap to view this comment.';

  @override
  String get commentSubmitError => 'Failed to post comment';

  @override
  String commentsNewCountTooltip(int count, int total) {
    return '$count new comments since last open; $total total comments';
  }

  @override
  String get mutedUsersScreenTitle => 'Muted Users';

  @override
  String get mutedCommunitiesScreenTitle => 'Muted Communities';

  @override
  String get mutedUsersEmpty => 'No muted users';

  @override
  String get mutedCommunitiesEmpty => 'No muted communities';

  @override
  String get notificationsScreenTitle => 'Notifications';

  @override
  String get notificationsEmpty => 'No notifications yet';

  @override
  String notifNewComment(String author) {
    return '$author commented on your post';
  }

  @override
  String notifNewCommentMultiple(String author, int others) {
    return '$author and $others others commented on your post';
  }

  @override
  String notifCommentReply(String author) {
    return '$author replied to your comment';
  }

  @override
  String notifNewVotesSingle(String targetType) {
    return '1 new upvote on your $targetType';
  }

  @override
  String notifNewVotesMultiple(int count, String targetType) {
    return '$count new upvotes on your $targetType';
  }

  @override
  String get notifDeletedPost => 'Your post was removed by moderators';

  @override
  String notifModAdd(String community) {
    return 'You were added as a moderator in $community';
  }

  @override
  String get notifNewBadge => 'You earned a new badge';

  @override
  String get communitiesTabAll => 'All';

  @override
  String get communitiesTabJoined => 'Joined';

  @override
  String get communitiesSearchHint => 'Search';

  @override
  String get communitiesEmpty => 'No communities found';

  @override
  String get communitiesJoinedEmpty =>
      'You haven\'t joined any communities yet';

  @override
  String get communitiesNoMatch => 'No communities match your search';

  @override
  String get communitiesSelectTitle => 'Select Community';

  @override
  String get listsEmpty => 'You haven\'t created any lists yet';

  @override
  String get listsCreateTitle => 'New list';

  @override
  String get listsEditTitle => 'Edit list';

  @override
  String get listsDisplayNameLabel => 'Name';

  @override
  String get listsDisplayNameRequired => 'Name is required';

  @override
  String get listsDescriptionLabel => 'Description (optional)';

  @override
  String get listsPublicToggle => 'Public';

  @override
  String get listsDeleteTooltip => 'Delete list';

  @override
  String get listsDeleteConfirmTitle => 'Delete list?';

  @override
  String get listsDeleteConfirmBody =>
      'All saved items will be permanently lost.';

  @override
  String listItemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: 'Empty',
    );
    return '$_temp0';
  }

  @override
  String get listItemsEmpty => 'No saved items';

  @override
  String get listItemRemove => 'Remove';

  @override
  String get saveButton => 'Save';

  @override
  String get postMenuOpenInBrowser => 'Open in browser';

  @override
  String get postMenuSaveToList => 'Save to list';

  @override
  String get postMenuRemoveFromList => 'Remove from list';

  @override
  String get postMenuHide => 'Hide post';

  @override
  String get postMenuMuteUser => 'Mute user';

  @override
  String get postMenuMuteCommunity => 'Mute community';

  @override
  String get postMenuBlock => 'Block user';

  @override
  String get blockUserTitle => 'Block user?';

  @override
  String blockUserConfirm(String username) {
    return 'This will mute @$username, hide their posts and comments from you, and report this content for review.';
  }

  @override
  String get blockUserSuccess => 'User blocked and content reported';

  @override
  String get blockUserFail => 'Failed to block user, please try again later.';

  @override
  String get postHiddenLabel => 'Post hidden';

  @override
  String get undoButton => 'Undo';

  @override
  String postSavedToList(String name) {
    return 'Saved to \"$name\"';
  }

  @override
  String get editProfileTitle => 'Edit Profile';

  @override
  String get editProfilePictureLabel => 'Change photo';

  @override
  String get editProfileDescriptionLabel => 'About me';

  @override
  String get editProfileDescriptionHint => 'Tell people about yourself';

  @override
  String get profileSaved => 'Profile saved';

  @override
  String get composeScreenTitle => 'New post';

  @override
  String get composeCommunityHint => 'Select a community';

  @override
  String get composeTitleHint => 'Post Title';

  @override
  String get composeTypeText => 'Text / Link';

  @override
  String get composeTypeImage => 'Image';

  @override
  String get composeBodyHint => 'Text or link (optional)';

  @override
  String get composeUrlDetected => 'Will be posted as a link';

  @override
  String get composeAddImage => 'Add image';

  @override
  String get composeAltTextHint => 'Alt text (optional)';

  @override
  String get composeSubmitButton => 'Post';

  @override
  String get composePreviewTitle => 'Preview';

  @override
  String get composePreviewEmpty => 'Nothing to preview yet';

  @override
  String get composeMarkdownGuideTitle => 'Markdown guide';

  @override
  String get deleteButton => 'Delete';

  @override
  String get communityModTools => 'Mod tools';

  @override
  String get modToolsScreenTitle => 'Mod tools';

  @override
  String get modToolsTabSettings => 'Settings';

  @override
  String get modToolsTabRules => 'Rules';

  @override
  String get modToolsDescriptionLabel => 'Description';

  @override
  String get modToolsDescriptionHint =>
      'Community description (supports markdown)';

  @override
  String get modToolsNsfwLabel => 'NSFW community';

  @override
  String get modToolsPostingRestrictedLabel => 'Restrict posting to moderators';

  @override
  String get modToolsSaved => 'Settings saved';

  @override
  String get modToolsAddRule => 'Add rule';

  @override
  String get modToolsRuleLabel => 'Rule';

  @override
  String get modToolsRuleRequired => 'Rule text is required';

  @override
  String get modToolsRuleDescriptionLabel => 'Description (optional)';

  @override
  String get modToolsNewRuleTitle => 'New rule';

  @override
  String get modToolsEditRuleTitle => 'Edit rule';

  @override
  String get modToolsNoRules => 'No rules yet';

  @override
  String get modToolsDeleteRuleTitle => 'Delete rule';

  @override
  String get modToolsDeleteRuleConfirm =>
      'This rule will be permanently deleted.';

  @override
  String get modToolsTabReports => 'Reports';

  @override
  String get modToolsTabBanned => 'Banned';

  @override
  String get modToolsTabModerators => 'Moderators';

  @override
  String get modToolsModeratorsEmpty => 'No moderators';

  @override
  String get modToolsModeratorsRemove => 'Remove';

  @override
  String get modToolsModeratorsRemoveTitle => 'Remove moderator';

  @override
  String modToolsModeratorsRemoveConfirm(String username) {
    return '@$username will no longer be a moderator of this community.';
  }

  @override
  String get modToolsAddModerator => 'Add moderator';

  @override
  String get modToolsAddModeratorTitle => 'Add moderator';

  @override
  String get modToolsModeratorUsernameLabel => 'Username';

  @override
  String get modToolsModeratorUsernameRequired => 'Username is required';

  @override
  String get modToolsReportsFilterAll => 'All';

  @override
  String get modToolsReportsFilterPosts => 'Posts';

  @override
  String get modToolsReportsFilterComments => 'Comments';

  @override
  String get modToolsReportsEmpty => 'No reports';

  @override
  String modToolsReportsReason(String reason) {
    return 'Reason: $reason';
  }

  @override
  String get modToolsReportsIgnore => 'Ignore';

  @override
  String get modToolsReportsView => 'View';

  @override
  String get modToolsReportsRemoved => 'Removed';

  @override
  String get modToolsBannedEmpty => 'No banned users';

  @override
  String get modToolsBannedUnban => 'Unban';

  @override
  String get modToolsBanUserTitle => 'Ban user';

  @override
  String get modToolsBanUsernameLabel => 'Username';

  @override
  String get modToolsBanUsernameRequired => 'Username is required';

  @override
  String get modToolsBanSubmit => 'Ban';

  @override
  String get postMenuEdit => 'Edit post';

  @override
  String get postMenuDelete => 'Delete post';

  @override
  String get postMenuReport => 'Report';

  @override
  String get reportTitle => 'Select reason';

  @override
  String get reportReasons =>
      'Breaks community rules\nCopyright violation\nSpam\nPornography';

  @override
  String get postReportSuccess => 'Post reported';

  @override
  String get commentReportSuccess => 'Comment reported';

  @override
  String get reportFail => 'Report failed, please try again later.';

  @override
  String get postDeleteTitle => 'Delete post';

  @override
  String get postDeleteConfirm => 'This will permanently delete your post.';

  @override
  String get postMenuModActions => 'Mod actions';

  @override
  String get postModActionsTitle => 'Mod actions';

  @override
  String get postModActionsLocked => 'Locked';

  @override
  String get postModActionsPinned => 'Pinned in community';

  @override
  String get postModActionsDelete => 'Delete post';

  @override
  String get postModActionsDeleteConfirm =>
      'This will remove the post from the community. It cannot be undone from the app.';

  @override
  String get postModActionsDeleted => 'Post deleted';

  @override
  String get postModActionsError => 'Action failed, please try again later.';

  @override
  String get modActionsBanUser => 'Ban user';

  @override
  String modActionsBanUserConfirm(String username) {
    return '@$username won\'t be able to post or comment in this community anymore.';
  }

  @override
  String modActionsUserBanned(String username) {
    return '@$username has been banned';
  }

  @override
  String get composeEditTitle => 'Edit post';

  @override
  String get commentMenuEdit => 'Edit comment';

  @override
  String get commentMenuDelete => 'Delete comment';

  @override
  String get commentDeleteTitle => 'Delete comment';

  @override
  String get commentDeleteConfirm =>
      'This will permanently delete your comment.';

  @override
  String get commentEditTitle => 'Edit comment';

  @override
  String get commentMenuModActions => 'Mod actions';

  @override
  String get commentModActionsTitle => 'Mod actions';

  @override
  String get commentModActionsLocked => 'Locked';

  @override
  String get commentModActionsDelete => 'Delete comment';

  @override
  String get commentModActionsDeleteConfirm =>
      'This will remove the comment from the community. It cannot be undone from the app.';

  @override
  String get commentModActionsDeleted => 'Comment deleted';

  @override
  String get commentModActionsError => 'Action failed, please try again later.';

  @override
  String get imageViewerAltText => 'Alt text';

  @override
  String get imageViewerSave => 'Save image';

  @override
  String get settingsScreenTitle => 'Settings';

  @override
  String get textScaleSetting => 'Text size';

  @override
  String get navigationTabsSetting => 'Navigation tabs';

  @override
  String get deleteAccountSetting => 'Delete account';

  @override
  String get deleteAccountConfirmTitle => 'Delete account?';

  @override
  String get deleteAccountConfirmBody =>
      'This permanently deletes your account, posts, comments, and votes. This cannot be undone.\n\nEnter your password to confirm.';

  @override
  String get deleteAccountPasswordLabel => 'Password';

  @override
  String get deleteAccountErrorWrongPassword => 'Incorrect password.';

  @override
  String get deleteAccountErrorRateLimit =>
      'Too many attempts. Please wait a moment and try again.';

  @override
  String get updateAvailableTitle => 'Update available';

  @override
  String updateAvailableSubtitle(String version) {
    return 'v$version is out';
  }

  @override
  String get updateDownloadButton => 'Download';
}
