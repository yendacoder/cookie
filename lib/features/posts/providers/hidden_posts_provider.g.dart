// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hidden_posts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HiddenPosts)
final hiddenPostsProvider = HiddenPostsProvider._();

final class HiddenPostsProvider
    extends $NotifierProvider<HiddenPosts, Set<String>> {
  HiddenPostsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hiddenPostsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hiddenPostsHash();

  @$internal
  @override
  HiddenPosts create() => HiddenPosts();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$hiddenPostsHash() => r'7abc970f962f855f539219f0f77c6e239360c350';

abstract class _$HiddenPosts extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
