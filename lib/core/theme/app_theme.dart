import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const kUpvoteColor = Color(0xFF3AAF4E);
  static const kDownvoteColor = Color(0xFFE4667C);

  // Warm cookie-orange seed color
  static const _seed = Color(0xFFD97040);

  static ThemeData light() => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seed,
          brightness: .light,
        ),
        navigationBarTheme: const NavigationBarThemeData(
          labelBehavior: .alwaysShow,
        ),
        cardTheme: const CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
        ),
        dividerTheme: const DividerThemeData(
          space: 0,
          thickness: 0,
        ),
      );

  static ThemeData dark() => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seed,
          brightness: .dark,
        ),
        navigationBarTheme: const NavigationBarThemeData(
          labelBehavior: .alwaysShow,
        ),
        cardTheme: const CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
        ),
        dividerTheme: const DividerThemeData(
          space: 0,
          thickness: 0,
        ),
      );
}
