import 'package:cookie/core/hero_tag_scope.dart';
import 'package:cookie/l10n/app_localizations.dart';
import 'package:flutter/material.dart' show IconData, Icons;

/// The different "/posts" feeds the app can display.
enum FeedType {
  home(
    apiFeedParam: null,
    sortPrefsKey: 'home_feed_sort',
    heroTagScope: .home,
    requiresAuth: false,
  ),
  subscriptions(
    apiFeedParam: 'home',
    sortPrefsKey: 'subscriptions_feed_sort',
    heroTagScope: .subscriptions,
  ),
  moderating(
    apiFeedParam: 'moderating',
    sortPrefsKey: 'moderating_feed_sort',
    heroTagScope: .moderating,
  );

  const FeedType({
    required this.apiFeedParam,
    required this.sortPrefsKey,
    required this.heroTagScope,
    this.requiresAuth = true,
  });

  /// Value for the API's `feed` query parameter, or `null` to omit it.
  final String? apiFeedParam;

  /// SharedPreferences key used to persist the selected [PostSort].
  final String sortPrefsKey;

  final HeroTagScopeType heroTagScope;

  /// Whether the user must be signed in to view this feed.
  final bool requiresAuth;

  String title(AppLocalizations l10n) => switch (this) {
    home => l10n.homeScreenTitle,
    subscriptions => l10n.subscriptionsScreenTitle,
    moderating => l10n.moderatingScreenTitle,
  };

  /// Path of the main-navigation route for this feed.
  String get routePath => switch (this) {
    home => '/',
    subscriptions => '/subscriptions',
    moderating => '/moderating',
  };

  /// Label shown in the bottom navigation bar.
  String navLabel(AppLocalizations l10n) => switch (this) {
    home => l10n.navHome,
    subscriptions => l10n.navSubscriptions,
    moderating => l10n.navModerating,
  };

  /// Icon shown in the bottom navigation bar when this tab is not selected.
  IconData get navIcon => switch (this) {
    home => Icons.home_outlined,
    subscriptions => Icons.dynamic_feed_outlined,
    moderating => Icons.admin_panel_settings_outlined,
  };

  /// Icon shown in the bottom navigation bar when this tab is selected.
  IconData get navIconSelected => switch (this) {
    home => Icons.home,
    subscriptions => Icons.dynamic_feed,
    moderating => Icons.admin_panel_settings,
  };
}
