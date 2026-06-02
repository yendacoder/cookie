import 'package:cookie/features/shell/providers/text_scale_provider.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'core/api/api_client.dart';
import 'features/shell/providers/last_tab_provider.dart';
import 'features/shell/providers/package_info_provider.dart';

Future<void> bootstrap({List<Override> additionalOverrides = const []}) async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([.portraitUp, .portraitDown]);

  final appDocDir = await getApplicationDocumentsDirectory();
  final jar = PersistCookieJar(
    storage: FileStorage('${appDocDir.path}/.cookies/'),
  );
  // Pre-load persisted cookies into memory so the first /_initial request
  // already carries the stored SID and csrftoken without an extra disk read.
  await jar.forceInit();

  final savedTab =
      await SharedPreferencesAsync().getInt(LastTab.kPrefsName) ?? 0;
  final textScale =
      await SharedPreferencesAsync().getDouble(TextScale.kPrefsName) ?? 1.0;

  final packageInfo = await PackageInfo.fromPlatform();

  runApp(
    ProviderScope(
      overrides: [
        packageInfoProvider.overrideWithValue(packageInfo),
        cookieJarProvider.overrideWith((_) => jar),
        lastTabProvider.overrideWith(() => _SavedLastTab(savedTab)),
        textScaleProvider.overrideWith(
          () => _SavedTextScale(textScale.clamp(1.0, 3.0)),
        ),
        ...additionalOverrides,
      ],
      child: const CookieApp(),
    ),
  );
}

// Overrides LastTab.build() to return the value read from SharedPreferences
// before the app started, so the router can use it synchronously.
class _SavedLastTab extends LastTab {
  _SavedLastTab(this._saved);

  final int _saved;

  @override
  int build() => _saved;
}

class _SavedTextScale extends TextScale {
  _SavedTextScale(this._saved);

  final double _saved;

  @override
  double build() => _saved;
}
