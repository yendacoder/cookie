import 'package:cookie/common/controller/initial_controller.dart';
import 'package:cookie/common/repository/initial_repository.dart';
import 'package:cookie/router/router.dart';
import 'package:cookie/settings/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import 'settings/themes.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppRouter _appRouter;
  final _themes = Themes();
  final _config = ProdAppConfig();

  @override
  void initState() {
    _appRouter = AppRouter();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppConfigProvider(
        config: _config,
        child: ChangeNotifierProvider<InitialController>(
            create: (_) => InitialController(InitialRepository()),
            child: PlatformProvider(
                initialPlatform: Themes.targetPlatform,
                builder: (BuildContext context) {
                  return Theme(
                      data: _themes.materialTheme,
                      child: PlatformApp.router(
                        title: _config.appTitle,
                        shortcuts: {
                          LogicalKeySet(LogicalKeyboardKey.space):
                              const ActivateIntent(),
                        },
                        debugShowCheckedModeBanner: false,
                        routerDelegate: _appRouter.delegate(),
                        routeInformationParser: _appRouter.defaultRouteParser(),
                        material: (_, __) => MaterialAppRouterData(
                          themeMode: Themes.targetThemeMode,
                          theme: _themes.lightTheme,
                          darkTheme: _themes.darkTheme,
                        ),
                        cupertino: (_, __) => CupertinoAppRouterData(
                          theme: _themes.cupertinoTheme,
                        ),
                        localizationsDelegates:
                            AppLocalizations.localizationsDelegates,
                        supportedLocales: AppLocalizations.supportedLocales,
                      ));
                })));
  }
}
