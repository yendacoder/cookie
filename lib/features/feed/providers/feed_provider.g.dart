// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FeedSort)
final feedSortProvider = FeedSortFamily._();

final class FeedSortProvider
    extends $AsyncNotifierProvider<FeedSort, PostSort> {
  FeedSortProvider._({
    required FeedSortFamily super.from,
    required FeedType super.argument,
  }) : super(
         retry: null,
         name: r'feedSortProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$feedSortHash();

  @override
  String toString() {
    return r'feedSortProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FeedSort create() => FeedSort();

  @override
  bool operator ==(Object other) {
    return other is FeedSortProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$feedSortHash() => r'9b2d0e5302d307d606af64d22ca2e73d589a108c';

final class FeedSortFamily extends $Family
    with
        $ClassFamilyOverride<
          FeedSort,
          AsyncValue<PostSort>,
          PostSort,
          FutureOr<PostSort>,
          FeedType
        > {
  FeedSortFamily._()
    : super(
        retry: null,
        name: r'feedSortProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  FeedSortProvider call(FeedType type) =>
      FeedSortProvider._(argument: type, from: this);

  @override
  String toString() => r'feedSortProvider';
}

abstract class _$FeedSort extends $AsyncNotifier<PostSort> {
  late final _$args = ref.$arg as FeedType;
  FeedType get type => _$args;

  FutureOr<PostSort> build(FeedType type);
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
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(FeedNotifier)
final feedProvider = FeedNotifierFamily._();

final class FeedNotifierProvider
    extends $AsyncNotifierProvider<FeedNotifier, PostFeedState> {
  FeedNotifierProvider._({
    required FeedNotifierFamily super.from,
    required FeedType super.argument,
  }) : super(
         retry: null,
         name: r'feedProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$feedNotifierHash();

  @override
  String toString() {
    return r'feedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FeedNotifier create() => FeedNotifier();

  @override
  bool operator ==(Object other) {
    return other is FeedNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$feedNotifierHash() => r'ca0742f54a875cbfa5dec9b9ea3eb42b8b490afa';

final class FeedNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          FeedNotifier,
          AsyncValue<PostFeedState>,
          PostFeedState,
          FutureOr<PostFeedState>,
          FeedType
        > {
  FeedNotifierFamily._()
    : super(
        retry: null,
        name: r'feedProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  FeedNotifierProvider call(FeedType type) =>
      FeedNotifierProvider._(argument: type, from: this);

  @override
  String toString() => r'feedProvider';
}

abstract class _$FeedNotifier extends $AsyncNotifier<PostFeedState> {
  late final _$args = ref.$arg as FeedType;
  FeedType get type => _$args;

  FutureOr<PostFeedState> build(FeedType type);
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
    element.handleCreate(ref, () => build(_$args));
  }
}
