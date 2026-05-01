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
  String get navHome => 'Home';

  @override
  String get navSubscriptions => 'Subscriptions';

  @override
  String get navCommunities => 'Communities';

  @override
  String get navLists => 'Lists';

  @override
  String get navProfile => 'Profile';

  @override
  String get loginTitle => 'Sign in';

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
  String get loginForgotPassword => 'Forgot password?';

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
  String get retryButton => 'Try again';

  @override
  String get signInButton => 'Sign in';

  @override
  String get upvote => 'Upvote';

  @override
  String get downvote => 'Downvote';

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
  String get confirmButton => 'Confirm';
}
