import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nav_bar_visibility_provider.g.dart';

@Riverpod(keepAlive: true)
class NavBarVisibility extends _$NavBarVisibility {
  @override
  bool build() => true;

  void show() {
    if (!state) state = true;
  }

  void hide() {
    if (state) state = false;
  }
}
