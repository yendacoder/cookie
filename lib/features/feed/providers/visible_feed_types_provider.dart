import 'package:cookie/features/feed/models/feed_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'visible_feed_types_provider.g.dart';

@Riverpod(keepAlive: true)
class VisibleFeedTypes extends _$VisibleFeedTypes {
  static const kPrefsName = 'visible_feed_types';

  @override
  Set<FeedType> build() => FeedType.values.toSet();

  void toggle(FeedType type) {
    final updated = {...state};
    if (updated.contains(type)) {
      if (updated.length == 1) return;
      updated.remove(type);
    } else {
      updated.add(type);
    }
    SharedPreferencesAsync().setStringList(
      kPrefsName,
      updated.map((t) => t.name).toList(),
    );
    state = updated;
  }
}
