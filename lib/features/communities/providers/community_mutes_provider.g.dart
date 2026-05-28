// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_mutes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CommunityMutes)
final communityMutesProvider = CommunityMutesProvider._();

final class CommunityMutesProvider
    extends $NotifierProvider<CommunityMutes, Set<String>> {
  CommunityMutesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communityMutesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communityMutesHash();

  @$internal
  @override
  CommunityMutes create() => CommunityMutes();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$communityMutesHash() => r'e989d1b6b38b8a90db142aac5c602f356ae6a0a8';

abstract class _$CommunityMutes extends $Notifier<Set<String>> {
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
