import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';
import 'core/api/api_client.dart';

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

  runApp(
    ProviderScope(
      overrides: [
        cookieJarProvider.overrideWith((_) => jar),
      ],
      child: const CookieApp(),
    ),
  );
}
