import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'text_scale_provider.g.dart';

@Riverpod(keepAlive: true)
class TextScale extends _$TextScale {
  static const kPrefsName = 'text_scale';

  @override
  double build() => 1.0;

  void set(double scale) {
    SharedPreferencesAsync().setDouble(kPrefsName, scale);
    state = scale;
  }
}
