// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visible_feed_types_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VisibleFeedTypes)
final visibleFeedTypesProvider = VisibleFeedTypesProvider._();

final class VisibleFeedTypesProvider
    extends $NotifierProvider<VisibleFeedTypes, Set<FeedType>> {
  VisibleFeedTypesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'visibleFeedTypesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$visibleFeedTypesHash();

  @$internal
  @override
  VisibleFeedTypes create() => VisibleFeedTypes();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<FeedType> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<FeedType>>(value),
    );
  }
}

String _$visibleFeedTypesHash() => r'd54e2768252165c33fa132d71d7f8049ea44fb03';

abstract class _$VisibleFeedTypes extends $Notifier<Set<FeedType>> {
  Set<FeedType> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Set<FeedType>, Set<FeedType>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<FeedType>, Set<FeedType>>,
              Set<FeedType>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
