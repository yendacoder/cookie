import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'last_tab_provider.g.dart';

@Riverpod(keepAlive: true)
class LastTab extends _$LastTab {
  @override
  int build() => 0;

  void set(int index) => state = index;
}
