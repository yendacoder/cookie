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

  /// No description provided for @loginForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get loginForgotPassword;

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

  /// No description provided for @commentSubmitError.
  ///
  /// In en, this message translates to:
  /// **'Failed to post comment'**
  String get commentSubmitError;
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
