import 'package:cookie/api/api_client.dart';
import 'package:flutter/material.dart';

abstract class AppConfig {
  String get appTitle;

  String get apiHost;
  String get imageHost;
}

class ProdAppConfig extends AppConfig {
  ProdAppConfig() {
    ApiClient.init(apiHost);
  }

  @override
  String get appTitle => 'Cookie';

  @override
  String get apiHost => 'discuit.net';

  @override
  String get imageHost => 'https://discuit.net';
}

class AppConfigProvider extends InheritedWidget {
  final AppConfig config;

  const AppConfigProvider({
    Key? key,
    required Widget child,
    required this.config,
  }) : super(
    key: key,
    child: child,
  );

  static AppConfigProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfigProvider>()!;
  }

  String getFullImageUrl(String relativeUrl) => config.imageHost + relativeUrl;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}


