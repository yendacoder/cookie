// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_mod_posts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CommunityModPosts)
final communityModPostsProvider = CommunityModPostsFamily._();

final class CommunityModPostsProvider
    extends $AsyncNotifierProvider<CommunityModPosts, CommunityModPostsState> {
  CommunityModPostsProvider._({
    required CommunityModPostsFamily super.from,
    required (String, ModPostsFilter) super.argument,
  }) : super(
         retry: null,
         name: r'communityModPostsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$communityModPostsHash();

  @override
  String toString() {
    return r'communityModPostsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  CommunityModPosts create() => CommunityModPosts();

  @override
  bool operator ==(Object other) {
    return other is CommunityModPostsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$communityModPostsHash() => r'8ee5c64b1cdf062d2a698875e543e7bb0e9d57de';

final class CommunityModPostsFamily extends $Family
    with
        $ClassFamilyOverride<
          CommunityModPosts,
          AsyncValue<CommunityModPostsState>,
          CommunityModPostsState,
          FutureOr<CommunityModPostsState>,
          (String, ModPostsFilter)
        > {
  CommunityModPostsFamily._()
    : super(
        retry: null,
        name: r'communityModPostsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CommunityModPostsProvider call(String communityId, ModPostsFilter filter) =>
      CommunityModPostsProvider._(argument: (communityId, filter), from: this);

  @override
  String toString() => r'communityModPostsProvider';
}

abstract class _$CommunityModPosts
    extends $AsyncNotifier<CommunityModPostsState> {
  late final _$args = ref.$arg as (String, ModPostsFilter);
  String get communityId => _$args.$1;
  ModPostsFilter get filter => _$args.$2;

  FutureOr<CommunityModPostsState> build(
    String communityId,
    ModPostsFilter filter,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<CommunityModPostsState>, CommunityModPostsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<CommunityModPostsState>,
                CommunityModPostsState
              >,
              AsyncValue<CommunityModPostsState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
