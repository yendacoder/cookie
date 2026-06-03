import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const kUpvoteColor = Color(0xFF3AAF4E);
  static const kDownvoteColor = Color(0xFFE4667C);

  // Warm cookie-orange seed color
  static const _seed = Color(0xFFD97040);

  static const _cupertinoTransitions = PageTransitionsTheme(
    builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
      TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
    },
  );

  static const _outlineBorder = OutlineInputBorder();

  static InputDecorationTheme _inputDecorationTheme(
    ColorScheme cs,
    bool useIos,
  ) {
    if (!useIos) return const InputDecorationTheme(border: _outlineBorder);
    const radius = BorderRadius.all(Radius.circular(12));
    return InputDecorationTheme(
      filled: true,
      fillColor: cs.surfaceContainerHighest,
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: radius,
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: radius,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: cs.primary, width: 1.5),
        borderRadius: radius,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: cs.error),
        borderRadius: radius,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: cs.error, width: 1.5),
        borderRadius: radius,
      ),
    );
  }

  static ThemeData light({bool useIos = false}) {
    final cs = ColorScheme.fromSeed(seedColor: _seed, brightness: .light);
    return ThemeData(
      colorScheme: cs,
      pageTransitionsTheme:
          useIos ? _cupertinoTransitions : const PageTransitionsTheme(),
      splashFactory: useIos ? NoSplash.splashFactory : null,
      inputDecorationTheme: _inputDecorationTheme(cs, useIos),
      navigationBarTheme: const NavigationBarThemeData(
        labelBehavior: .alwaysShow,
      ),
      cardTheme: const CardThemeData(elevation: 0, margin: EdgeInsets.zero),
      dividerTheme: const DividerThemeData(space: 0, thickness: 0),
    );
  }

  static ThemeData dark({bool useIos = false}) {
    final cs = ColorScheme.fromSeed(seedColor: _seed, brightness: .dark);
    return ThemeData(
      colorScheme: cs,
      pageTransitionsTheme:
          useIos ? _cupertinoTransitions : const PageTransitionsTheme(),
      splashFactory: useIos ? NoSplash.splashFactory : null,
      inputDecorationTheme: _inputDecorationTheme(cs, useIos),
      navigationBarTheme: const NavigationBarThemeData(
        labelBehavior: .alwaysShow,
      ),
      cardTheme: const CardThemeData(elevation: 0, margin: EdgeInsets.zero),
      dividerTheme: const DividerThemeData(space: 0, thickness: 0),
    );
  }
}
