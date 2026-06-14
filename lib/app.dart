import 'package:cookie/features/shell/providers/text_scale_provider.dart';
import 'package:cookie/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart' show CupertinoScrollBehavior;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/providers/platform_style_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/notifications/providers/notification_poll_provider.dart';

class CookieApp extends ConsumerWidget {
  const CookieApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final scale = ref.watch(textScaleProvider);
    final useIos = ref.useIos;
    ref.watch(notificationPollerProvider);
    return MaterialApp.router(
      title: 'Cookie',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(useIos: useIos),
      darkTheme: AppTheme.dark(useIos: useIos),
      themeMode: .system,
      scrollBehavior: useIos ? const CupertinoScrollBehavior() : null,
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(scale)),
          // Provides a themed `DefaultTextStyle` for widgets rendered via
          // `Overlay.of(context)` (e.g. GlassSnackBar), which otherwise sit
          // outside any `Material` ancestor and fall back to bare text styling.
          child: Material(type: MaterialType.transparency, child: child!),
        );
      },
    );
  }
}
