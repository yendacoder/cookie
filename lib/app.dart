import 'package:cookie/features/shell/providers/text_scale_provider.dart';
import 'package:flutter/cupertino.dart' show CupertinoScrollBehavior;
import 'package:flutter/material.dart';
import 'package:cookie/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/providers/platform_style_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class CookieApp extends ConsumerWidget {
  const CookieApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final scale = ref.watch(textScaleProvider);
    final useIos = ref.useIos;
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
          child: child!,
        );
      },
    );
  }
}
