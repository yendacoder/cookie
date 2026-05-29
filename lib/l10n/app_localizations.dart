import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// The name of the application
  ///
  /// In en, this message translates to:
  /// **'Cookie'**
  String get appTitle;

  /// No description provided for @appNameVersion.
  ///
  /// In en, this message translates to:
  /// **'Cookie for Discuit, version {version}'**
  String appNameVersion(String version);

  /// Home navigation tab label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// Subscriptions navigation tab label
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get navSubscriptions;

  /// Communities navigation tab label
  ///
  /// In en, this message translates to:
  /// **'Communities'**
  String get navCommunities;

  /// Lists navigation tab label
  ///
  /// In en, this message translates to:
  /// **'Lists'**
  String get navLists;

  /// Profile navigation tab label
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginTitle;

  /// No description provided for @navPost.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get navPost;

  /// No description provided for @loginUsernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get loginUsernameLabel;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordLabel;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginButton;

  /// No description provided for @loginRegisterPrompt.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get loginRegisterPrompt;

  /// No description provided for @loginRegisterLink.
  ///
  /// In en, this message translates to:
  /// **'Register on the web'**
  String get loginRegisterLink;

  /// No description provided for @loginErrorInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid username or password'**
  String get loginErrorInvalid;

  /// No description provided for @loginErrorSuspended.
  ///
  /// In en, this message translates to:
  /// **'This account has been suspended'**
  String get loginErrorSuspended;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorGeneric;

  /// No description provided for @errorNetworkTitle.
  ///
  /// In en, this message translates to:
  /// **'Network error'**
  String get errorNetworkTitle;

  /// No description provided for @errorNetworkBody.
  ///
  /// In en, this message translates to:
  /// **'Unable to reach the server. Check your internet connection.'**
  String get errorNetworkBody;

  /// No description provided for @errorParseTitle.
  ///
  /// In en, this message translates to:
  /// **'Parsing error'**
  String get errorParseTitle;

  /// No description provided for @errorParseBody.
  ///
  /// In en, this message translates to:
  /// **'The server returned an unexpected response. The app may need to be updated.'**
  String get errorParseBody;

  /// No description provided for @errorParseField.
  ///
  /// In en, this message translates to:
  /// **'Field: {field}'**
  String errorParseField(String field);

  /// No description provided for @errorUnknownTitle.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error'**
  String get errorUnknownTitle;

  /// No description provided for @errorUnknownBody.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  String get errorUnknownBody;

  /// No description provided for @errorAuthRequired.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get errorAuthRequired;

  /// No description provided for @errorAuthRequiredBody.
  ///
  /// In en, this message translates to:
  /// **'You need to be signed in to view this section.'**
  String get errorAuthRequiredBody;

  /// No description provided for @sortHot.
  ///
  /// In en, this message translates to:
  /// **'Hot'**
  String get sortHot;

  /// No description provided for @sortNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get sortNew;

  /// No description provided for @sortTop.
  ///
  /// In en, this message translates to:
  /// **'Top'**
  String get sortTop;

  /// No description provided for @sortActivity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get sortActivity;

  /// No description provided for @sortDay.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get sortDay;

  /// No description provided for @sortWeek.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get sortWeek;

  /// No description provided for @sortMonth.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get sortMonth;

  /// No description provided for @sortYear.
  ///
  /// In en, this message translates to:
  /// **'This year'**
  String get sortYear;

  /// No description provided for @sortAll.
  ///
  /// In en, this message translates to:
  /// **'All time'**
  String get sortAll;

  /// No description provided for @loadingLabel.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get loadingLabel;

  /// No description provided for @timeJustNow.
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get timeJustNow;

  /// No description provided for @timeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 min ago} other{{count} min ago}}'**
  String timeMinutesAgo(int count);

  /// No description provided for @timeHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 hr ago} other{{count} hr ago}}'**
  String timeHoursAgo(int count);

  /// No description provided for @timeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day ago} other{{count} days ago}}'**
  String timeDaysAgo(int count);

  /// No description provided for @timeWeeksAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 week ago} other{{count} weeks ago}}'**
  String timeWeeksAgo(int count);

  /// No description provided for @timeMonthsAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 month ago} other{{count} months ago}}'**
  String timeMonthsAgo(int count);

  /// No description provided for @timeYearsAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 year ago} other{{count} years ago}}'**
  String timeYearsAgo(int count);

  /// No description provided for @postDetailNoComments.
  ///
  /// In en, this message translates to:
  /// **'No comments yet'**
  String get postDetailNoComments;

  /// No description provided for @postDetailLoadMoreComments.
  ///
  /// In en, this message translates to:
  /// **'Load more comments'**
  String get postDetailLoadMoreComments;

  /// No description provided for @postDetailCommentDeleted.
  ///
  /// In en, this message translates to:
  /// **'[deleted]'**
  String get postDetailCommentDeleted;

  /// No description provided for @feedEndOfContent.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up'**
  String get feedEndOfContent;

  /// No description provided for @feedLoadMoreError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load more posts'**
  String get feedLoadMoreError;

  /// No description provided for @retryButton.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retryButton;

  /// No description provided for @signInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInButton;

  /// No description provided for @upvote.
  ///
  /// In en, this message translates to:
  /// **'Upvote'**
  String get upvote;

  /// No description provided for @downvote.
  ///
  /// In en, this message translates to:
  /// **'Downvote'**
  String get downvote;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @commentsLabel.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No comments} =1{1 comment} other{{count} comments}}'**
  String commentsLabel(int count);

  /// No description provided for @pointsLabel.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 point} other{{count} points}}'**
  String pointsLabel(int count);

  /// No description provided for @membersLabel.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 member} other{{count} members}}'**
  String membersLabel(int count);

  /// No description provided for @joinButton.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get joinButton;

  /// No description provided for @leaveButton.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get leaveButton;

  /// No description provided for @communityRulesTitle.
  ///
  /// In en, this message translates to:
  /// **'Rules'**
  String get communityRulesTitle;

  /// No description provided for @communityNoRules.
  ///
  /// In en, this message translates to:
  /// **'This community has no rules.'**
  String get communityNoRules;

  /// No description provided for @communityModeratorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Moderators'**
  String get communityModeratorsTitle;

  /// No description provided for @communityNoModerators.
  ///
  /// In en, this message translates to:
  /// **'No moderators listed.'**
  String get communityNoModerators;

  /// No description provided for @communityCreatePost.
  ///
  /// In en, this message translates to:
  /// **'New post'**
  String get communityCreatePost;

  /// No description provided for @postBy.
  ///
  /// In en, this message translates to:
  /// **'by {username}'**
  String postBy(String username);

  /// No description provided for @inCommunity.
  ///
  /// In en, this message translates to:
  /// **'in {community}'**
  String inCommunity(String community);

  /// No description provided for @homeScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeScreenTitle;

  /// No description provided for @subscriptionsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get subscriptionsScreenTitle;

  /// No description provided for @communitiesScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Communities'**
  String get communitiesScreenTitle;

  /// No description provided for @listsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Lists'**
  String get listsScreenTitle;

  /// No description provided for @profileScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileScreenTitle;

  /// No description provided for @logoutButton.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get logoutButton;

  /// No description provided for @logoutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out?'**
  String get logoutConfirmTitle;

  /// No description provided for @logoutConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'You will need to sign in again to access your account.'**
  String get logoutConfirmBody;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @okayButton.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okayButton;

  /// No description provided for @confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// No description provided for @communityMute.
  ///
  /// In en, this message translates to:
  /// **'Mute'**
  String get communityMute;

  /// No description provided for @communityUnmute.
  ///
  /// In en, this message translates to:
  /// **'Unmute'**
  String get communityUnmute;

  /// No description provided for @userTabAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get userTabAll;

  /// No description provided for @userTabPosts.
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  String get userTabPosts;

  /// No description provided for @userTabComments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get userTabComments;

  /// No description provided for @userMute.
  ///
  /// In en, this message translates to:
  /// **'Mute'**
  String get userMute;

  /// No description provided for @userUnmute.
  ///
  /// In en, this message translates to:
  /// **'Unmute'**
  String get userUnmute;

  /// No description provided for @userJoined.
  ///
  /// In en, this message translates to:
  /// **'Joined {date}'**
  String userJoined(String date);

  /// No description provided for @userAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get userAdmin;

  /// No description provided for @postsLabel.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 post} other{{count} posts}}'**
  String postsLabel(int count);

  /// No description provided for @commentHint.
  ///
  /// In en, this message translates to:
  /// **'Add a comment…'**
  String get commentHint;

  /// No description provided for @commentPostReference.
  ///
  /// In en, this message translates to:
  /// **'on {post}'**
  String commentPostReference(String post);

  /// No description provided for @commentReplyingTo.
  ///
  /// In en, this message translates to:
  /// **'Replying to @{username}'**
  String commentReplyingTo(String username);

  /// No description provided for @commentReplyButton.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get commentReplyButton;

  /// No description provided for @commentOP.
  ///
  /// In en, this message translates to:
  /// **'OP'**
  String get commentOP;

  /// No description provided for @commentAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get commentAdmin;

  /// No description provided for @commentSubmitError.
  ///
  /// In en, this message translates to:
  /// **'Failed to post comment'**
  String get commentSubmitError;

  /// No description provided for @mutedUsersScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Muted Users'**
  String get mutedUsersScreenTitle;

  /// No description provided for @mutedCommunitiesScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Muted Communities'**
  String get mutedCommunitiesScreenTitle;

  /// No description provided for @mutedUsersEmpty.
  ///
  /// In en, this message translates to:
  /// **'No muted users'**
  String get mutedUsersEmpty;

  /// No description provided for @mutedCommunitiesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No muted communities'**
  String get mutedCommunitiesEmpty;

  /// No description provided for @notificationsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsScreenTitle;

  /// No description provided for @notificationsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get notificationsEmpty;

  /// No description provided for @notifNewComment.
  ///
  /// In en, this message translates to:
  /// **'{author} commented on your post'**
  String notifNewComment(String author);

  /// No description provided for @notifNewCommentMultiple.
  ///
  /// In en, this message translates to:
  /// **'{author} and {others} others commented on your post'**
  String notifNewCommentMultiple(String author, int others);

  /// No description provided for @notifCommentReply.
  ///
  /// In en, this message translates to:
  /// **'{author} replied to your comment'**
  String notifCommentReply(String author);

  /// No description provided for @notifNewVotesSingle.
  ///
  /// In en, this message translates to:
  /// **'1 new upvote on your {targetType}'**
  String notifNewVotesSingle(String targetType);

  /// No description provided for @notifNewVotesMultiple.
  ///
  /// In en, this message translates to:
  /// **'{count} new upvotes on your {targetType}'**
  String notifNewVotesMultiple(int count, String targetType);

  /// No description provided for @notifDeletedPost.
  ///
  /// In en, this message translates to:
  /// **'Your post was removed by moderators'**
  String get notifDeletedPost;

  /// No description provided for @notifModAdd.
  ///
  /// In en, this message translates to:
  /// **'You were added as a moderator in {community}'**
  String notifModAdd(String community);

  /// No description provided for @notifNewBadge.
  ///
  /// In en, this message translates to:
  /// **'You earned a new badge'**
  String get notifNewBadge;

  /// No description provided for @communitiesTabAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get communitiesTabAll;

  /// No description provided for @communitiesTabJoined.
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get communitiesTabJoined;

  /// No description provided for @communitiesSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get communitiesSearchHint;

  /// No description provided for @communitiesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No communities found'**
  String get communitiesEmpty;

  /// No description provided for @communitiesJoinedEmpty.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t joined any communities yet'**
  String get communitiesJoinedEmpty;

  /// No description provided for @communitiesSelectTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Community'**
  String get communitiesSelectTitle;

  /// No description provided for @listsEmpty.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t created any lists yet'**
  String get listsEmpty;

  /// No description provided for @listsCreateTitle.
  ///
  /// In en, this message translates to:
  /// **'New list'**
  String get listsCreateTitle;

  /// No description provided for @listsEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit list'**
  String get listsEditTitle;

  /// No description provided for @listsDisplayNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get listsDisplayNameLabel;

  /// No description provided for @listsDisplayNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get listsDisplayNameRequired;

  /// No description provided for @listsDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get listsDescriptionLabel;

  /// No description provided for @listsPublicToggle.
  ///
  /// In en, this message translates to:
  /// **'Public'**
  String get listsPublicToggle;

  /// No description provided for @listsDeleteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete list'**
  String get listsDeleteTooltip;

  /// No description provided for @listsDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete list?'**
  String get listsDeleteConfirmTitle;

  /// No description provided for @listsDeleteConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'All saved items will be permanently lost.'**
  String get listsDeleteConfirmBody;

  /// No description provided for @listItemCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Empty} =1{1 item} other{{count} items}}'**
  String listItemCount(int count);

  /// No description provided for @listItemsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No saved items'**
  String get listItemsEmpty;

  /// No description provided for @listItemRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get listItemRemove;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @postMenuOpenInBrowser.
  ///
  /// In en, this message translates to:
  /// **'Open in browser'**
  String get postMenuOpenInBrowser;

  /// No description provided for @postMenuSaveToList.
  ///
  /// In en, this message translates to:
  /// **'Save to list'**
  String get postMenuSaveToList;

  /// No description provided for @postMenuRemoveFromList.
  ///
  /// In en, this message translates to:
  /// **'Remove from list'**
  String get postMenuRemoveFromList;

  /// No description provided for @postMenuHide.
  ///
  /// In en, this message translates to:
  /// **'Hide post'**
  String get postMenuHide;

  /// No description provided for @postMenuMuteUser.
  ///
  /// In en, this message translates to:
  /// **'Mute user'**
  String get postMenuMuteUser;

  /// No description provided for @postMenuMuteCommunity.
  ///
  /// In en, this message translates to:
  /// **'Mute community'**
  String get postMenuMuteCommunity;

  /// No description provided for @postHiddenLabel.
  ///
  /// In en, this message translates to:
  /// **'Post hidden'**
  String get postHiddenLabel;

  /// No description provided for @undoButton.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undoButton;

  /// No description provided for @postSavedToList.
  ///
  /// In en, this message translates to:
  /// **'Saved to \"{name}\"'**
  String postSavedToList(String name);

  /// No description provided for @editProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfileTitle;

  /// No description provided for @editProfilePictureLabel.
  ///
  /// In en, this message translates to:
  /// **'Change photo'**
  String get editProfilePictureLabel;

  /// No description provided for @editProfileDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'About me'**
  String get editProfileDescriptionLabel;

  /// No description provided for @editProfileDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Tell people about yourself'**
  String get editProfileDescriptionHint;

  /// No description provided for @profileSaved.
  ///
  /// In en, this message translates to:
  /// **'Profile saved'**
  String get profileSaved;

  /// No description provided for @composeScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'New post'**
  String get composeScreenTitle;

  /// No description provided for @composeCommunityHint.
  ///
  /// In en, this message translates to:
  /// **'Select a community'**
  String get composeCommunityHint;

  /// No description provided for @composeTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Post Title'**
  String get composeTitleHint;

  /// No description provided for @composeTypeText.
  ///
  /// In en, this message translates to:
  /// **'Text / Link'**
  String get composeTypeText;

  /// No description provided for @composeTypeImage.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get composeTypeImage;

  /// No description provided for @composeBodyHint.
  ///
  /// In en, this message translates to:
  /// **'Text or link (optional)'**
  String get composeBodyHint;

  /// No description provided for @composeUrlDetected.
  ///
  /// In en, this message translates to:
  /// **'Will be posted as a link'**
  String get composeUrlDetected;

  /// No description provided for @composeAddImage.
  ///
  /// In en, this message translates to:
  /// **'Add image'**
  String get composeAddImage;

  /// No description provided for @composeAltTextHint.
  ///
  /// In en, this message translates to:
  /// **'Alt text (optional)'**
  String get composeAltTextHint;

  /// No description provided for @composeSubmitButton.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get composeSubmitButton;

  /// No description provided for @composePreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get composePreviewTitle;

  /// No description provided for @composePreviewEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing to preview yet'**
  String get composePreviewEmpty;

  /// No description provided for @composeMarkdownGuideTitle.
  ///
  /// In en, this message translates to:
  /// **'Markdown guide'**
  String get composeMarkdownGuideTitle;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @communityModTools.
  ///
  /// In en, this message translates to:
  /// **'Mod tools'**
  String get communityModTools;

  /// No description provided for @modToolsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Mod tools'**
  String get modToolsScreenTitle;

  /// No description provided for @modToolsTabSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get modToolsTabSettings;

  /// No description provided for @modToolsTabRules.
  ///
  /// In en, this message translates to:
  /// **'Rules'**
  String get modToolsTabRules;

  /// No description provided for @modToolsDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get modToolsDescriptionLabel;

  /// No description provided for @modToolsDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Community description (supports markdown)'**
  String get modToolsDescriptionHint;

  /// No description provided for @modToolsNsfwLabel.
  ///
  /// In en, this message translates to:
  /// **'NSFW community'**
  String get modToolsNsfwLabel;

  /// No description provided for @modToolsPostingRestrictedLabel.
  ///
  /// In en, this message translates to:
  /// **'Restrict posting to moderators'**
  String get modToolsPostingRestrictedLabel;

  /// No description provided for @modToolsSaved.
  ///
  /// In en, this message translates to:
  /// **'Settings saved'**
  String get modToolsSaved;

  /// No description provided for @modToolsAddRule.
  ///
  /// In en, this message translates to:
  /// **'Add rule'**
  String get modToolsAddRule;

  /// No description provided for @modToolsRuleLabel.
  ///
  /// In en, this message translates to:
  /// **'Rule'**
  String get modToolsRuleLabel;

  /// No description provided for @modToolsRuleRequired.
  ///
  /// In en, this message translates to:
  /// **'Rule text is required'**
  String get modToolsRuleRequired;

  /// No description provided for @modToolsRuleDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get modToolsRuleDescriptionLabel;

  /// No description provided for @modToolsNewRuleTitle.
  ///
  /// In en, this message translates to:
  /// **'New rule'**
  String get modToolsNewRuleTitle;

  /// No description provided for @modToolsEditRuleTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit rule'**
  String get modToolsEditRuleTitle;

  /// No description provided for @modToolsNoRules.
  ///
  /// In en, this message translates to:
  /// **'No rules yet'**
  String get modToolsNoRules;

  /// No description provided for @modToolsDeleteRuleTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete rule'**
  String get modToolsDeleteRuleTitle;

  /// No description provided for @modToolsDeleteRuleConfirm.
  ///
  /// In en, this message translates to:
  /// **'This rule will be permanently deleted.'**
  String get modToolsDeleteRuleConfirm;

  /// No description provided for @postMenuEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit post'**
  String get postMenuEdit;

  /// No description provided for @postMenuDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete post'**
  String get postMenuDelete;

  /// No description provided for @postMenuReport.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get postMenuReport;

  /// No description provided for @reportTitle.
  ///
  /// In en, this message translates to:
  /// **'Select reason'**
  String get reportTitle;

  /// No description provided for @reportReasons.
  ///
  /// In en, this message translates to:
  /// **'Breaks community rules\nCopyright violation\nSpam\nPornography'**
  String get reportReasons;

  /// No description provided for @postReportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Post reported'**
  String get postReportSuccess;

  /// No description provided for @commentReportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Comment reported'**
  String get commentReportSuccess;

  /// No description provided for @reportFail.
  ///
  /// In en, this message translates to:
  /// **'Report failed, please try again later.'**
  String get reportFail;

  /// No description provided for @postDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete post'**
  String get postDeleteTitle;

  /// No description provided for @postDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete your post.'**
  String get postDeleteConfirm;

  /// No description provided for @composeEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit post'**
  String get composeEditTitle;

  /// No description provided for @commentMenuEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit comment'**
  String get commentMenuEdit;

  /// No description provided for @commentMenuDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete comment'**
  String get commentMenuDelete;

  /// No description provided for @commentDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete comment'**
  String get commentDeleteTitle;

  /// No description provided for @commentDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete your comment.'**
  String get commentDeleteConfirm;

  /// No description provided for @commentEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit comment'**
  String get commentEditTitle;

  /// No description provided for @imageViewerAltText.
  ///
  /// In en, this message translates to:
  /// **'Alt text'**
  String get imageViewerAltText;

  /// No description provided for @imageViewerSave.
  ///
  /// In en, this message translates to:
  /// **'Save image'**
  String get imageViewerSave;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
