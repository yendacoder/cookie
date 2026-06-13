import 'package:cookie/core/hero_tag_scope.dart';
import 'package:cookie/l10n/app_localizations.dart';

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
}
