import 'package:cookie/settings/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  // use to debug UI
  static const TargetPlatform? targetPlatform =
      kDebugMode ? TargetPlatform.android : null;

  // Light theme is disabled until we set up nice colors
  static const ThemeMode targetThemeMode =
      ThemeMode.dark; //kDebugMode ? ThemeMode.light : null;

  late final ThemeData lightTheme;
  late final ThemeData darkTheme;
  late final ThemeData materialTheme;
  late final CupertinoThemeData cupertinoTheme;

  ThemeData _applyCommonMaterialTheme(ThemeData base) {
    return base.copyWith(
      platform: targetPlatform,
      applyElevationOverlayColor: false,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.fromLTRB(12.0, 8.0, 40.0, 8.0),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: base.disabledColor),
            borderRadius: BorderRadius.circular(kDefaultCornerRadius)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kDefaultCornerRadius)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(60, 44),
          foregroundColor: base.colorScheme.onBackground,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(60, 44),
          foregroundColor: base.colorScheme.onBackground,
        ),
      ),
      textTheme: GoogleFonts.openSansTextTheme(base.textTheme),
    );
  }

  Themes() {
    final baseLightTheme = _applyCommonMaterialTheme(ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.light,
        primarySwatch: Colors.cyan,
        accentColor: Colors.orangeAccent,
      ),
    ));

    final baseDarkTheme = _applyCommonMaterialTheme(ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.deepOrangeAccent,
        backgroundColor: Colors.blueGrey.shade900,
      ),
      disabledColor: Colors.blueGrey.shade800,
    ));

    final Brightness brightness;
    switch (targetThemeMode) {
      case ThemeMode.light:
        brightness = Brightness.light;
      case ThemeMode.dark:
        brightness = Brightness.dark;
      default:
        brightness = PlatformDispatcher.instance.platformBrightness;
    }

    lightTheme = baseLightTheme;
    darkTheme = baseDarkTheme;
    materialTheme = brightness == Brightness.light ? lightTheme : darkTheme;

    final cupertinoBaseTheme =
        MaterialBasedCupertinoThemeData(materialTheme: materialTheme);
    cupertinoTheme = cupertinoBaseTheme.copyWith(
        primaryColor: materialTheme.colorScheme.onBackground,
        textTheme: cupertinoBaseTheme.textTheme.copyWith(
            navTitleTextStyle: cupertinoBaseTheme.textTheme.navActionTextStyle
                .copyWith(color: materialTheme.colorScheme.onPrimary)));
  }
}
