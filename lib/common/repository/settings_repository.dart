import 'package:cookie/common/util/common_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum FeedViewType { full, regular, compact, micro }

const _kFeedViewKey = 'feed_view';
const _kDisableImageCacheKey = 'disable_image_cache';
const _kInlineFullImagesKey = 'inline_full_images';

class SettingsRepository {
  Future<FeedViewType> getSavedFeedViewType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kFeedViewKey)?.toEnumOrNull(FeedViewType.values) ??
        FeedViewType.regular;
  }

  Future<void> persistFeedViewType(FeedViewType feedViewType) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_kFeedViewKey, feedViewType.name);
  }

  Future<bool> getDisableImageCache() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kDisableImageCacheKey) ?? false;
  }

  Future<void> persistDisableImageCache(bool disable) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_kDisableImageCacheKey, disable);
  }

  Future<bool> getInlineFullImages() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kInlineFullImagesKey) ?? false;
  }

  Future<void> persistInlineFullImages(bool disable) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_kInlineFullImagesKey, disable);
  }

}
