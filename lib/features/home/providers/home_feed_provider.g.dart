// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_feed_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeFeedSort)
final homeFeedSortProvider = HomeFeedSortProvider._();

final class HomeFeedSortProvider
    extends $AsyncNotifierProvider<HomeFeedSort, PostSort> {
  HomeFeedSortProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeFeedSortProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeFeedSortHash();

  @$internal
  @override
  HomeFeedSort create() => HomeFeedSort();
}

String _$homeFeedSortHash() => r'5d68a4f366e1e102c22c29eaea9204f4e3ff5e44';

abstract class _$HomeFeedSort extends $AsyncNotifier<PostSort> {
  FutureOr<PostSort> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PostSort>, PostSort>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PostSort>, PostSort>,
              AsyncValue<PostSort>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(HomeFeedNotifier)
final homeFeedProvider = HomeFeedNotifierProvider._();

final class HomeFeedNotifierProvider
    extends $AsyncNotifierProvider<HomeFeedNotifier, PostFeedState> {
  HomeFeedNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeFeedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeFeedNotifierHash();

  @$internal
  @override
  HomeFeedNotifier create() => HomeFeedNotifier();
}

String _$homeFeedNotifierHash() => r'605fb695afdf4f7789d982f261975f87235535e2';

abstract class _$HomeFeedNotifier extends $AsyncNotifier<PostFeedState> {
  FutureOr<PostFeedState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PostFeedState>, PostFeedState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PostFeedState>, PostFeedState>,
              AsyncValue<PostFeedState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
