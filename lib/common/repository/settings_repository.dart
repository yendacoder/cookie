import 'package:cookie/common/util/common_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum FeedViewType { full, regular, compact, micro }

const _kFeedViewKey = 'feed_view';

class SettingsRepository {
  Future<FeedViewType> getSavedFeedViewType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kFeedViewKey)?.toEnumOrNull(FeedViewType.values) ??
        FeedViewType.full;
  }

  Future<void> persistFeedViewType(FeedViewType feedViewType) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_kFeedViewKey, feedViewType.name);
  }
}
