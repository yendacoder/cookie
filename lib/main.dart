import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'core/api/api_client.dart';
import 'features/shell/providers/last_tab_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final appDocDir = await getApplicationDocumentsDirectory();
  final jar = PersistCookieJar(
    storage: FileStorage('${appDocDir.path}/.cookies/'),
  );
  // Pre-load persisted cookies into memory so the first /_initial request
  // already carries the stored SID and csrftoken without an extra disk read.
  await jar.forceInit();

  final savedTab = await SharedPreferencesAsync().getInt('last_tab') ?? 0;

  runApp(
    ProviderScope(
      overrides: [
        cookieJarProvider.overrideWith((_) => jar),
        lastTabProvider.overrideWith(() => _SavedLastTab(savedTab)),
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
