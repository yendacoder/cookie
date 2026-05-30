import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'last_tab_provider.g.dart';

@Riverpod(keepAlive: true)
class LastTab extends _$LastTab {
  static const kPrefsName = 'last_tab';

  @override
  int build() => 0;

  void set(int index) {
    SharedPreferencesAsync().setInt(kPrefsName, index);
    state = index;
  }
}
