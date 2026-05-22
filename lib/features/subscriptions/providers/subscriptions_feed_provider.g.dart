// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscriptions_feed_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SubscriptionsFeedSort)
final subscriptionsFeedSortProvider = SubscriptionsFeedSortProvider._();

final class SubscriptionsFeedSortProvider
    extends $AsyncNotifierProvider<SubscriptionsFeedSort, PostSort> {
  SubscriptionsFeedSortProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subscriptionsFeedSortProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subscriptionsFeedSortHash();

  @$internal
  @override
  SubscriptionsFeedSort create() => SubscriptionsFeedSort();
}

String _$subscriptionsFeedSortHash() =>
    r'7a09f08078368ccbdd9028d2674430ed763162b9';

abstract class _$SubscriptionsFeedSort extends $AsyncNotifier<PostSort> {
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

@ProviderFor(SubscriptionsFeedNotifier)
final subscriptionsFeedProvider = SubscriptionsFeedNotifierProvider._();

final class SubscriptionsFeedNotifierProvider
    extends $AsyncNotifierProvider<SubscriptionsFeedNotifier, PostFeedState> {
  SubscriptionsFeedNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subscriptionsFeedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subscriptionsFeedNotifierHash();

  @$internal
  @override
  SubscriptionsFeedNotifier create() => SubscriptionsFeedNotifier();
}

String _$subscriptionsFeedNotifierHash() =>
    r'a359ecebcd49f01801efa8e0f8eb7c2092a0839a';

abstract class _$SubscriptionsFeedNotifier
    extends $AsyncNotifier<PostFeedState> {
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
