import 'package:cookie/features/shell/models/content_text_size.dart';
import 'package:cookie/features/shell/providers/content_text_sizes_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  group('ContentTextSizesNotifier', () {
    test('defaults to small post card, medium post detail, small comment', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(contentTextSizesProvider);

      expect(state.postCard, ContentTextSize.small);
      expect(state.postDetail, ContentTextSize.medium);
      expect(state.comment, ContentTextSize.small);
    });

    test('setPostCard updates only postCard', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container
          .read(contentTextSizesProvider.notifier)
          .setPostCard(ContentTextSize.large);
      final state = container.read(contentTextSizesProvider);

      expect(state.postCard, ContentTextSize.large);
      expect(state.postDetail, ContentTextSize.medium);
      expect(state.comment, ContentTextSize.small);
    });

    test('setPostDetail updates only postDetail', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container
          .read(contentTextSizesProvider.notifier)
          .setPostDetail(ContentTextSize.large);
      final state = container.read(contentTextSizesProvider);

      expect(state.postCard, ContentTextSize.small);
      expect(state.postDetail, ContentTextSize.large);
      expect(state.comment, ContentTextSize.small);
    });

    test('setComment updates only comment', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container
          .read(contentTextSizesProvider.notifier)
          .setComment(ContentTextSize.large);
      final state = container.read(contentTextSizesProvider);

      expect(state.postCard, ContentTextSize.small);
      expect(state.postDetail, ContentTextSize.medium);
      expect(state.comment, ContentTextSize.large);
    });
  });
}
