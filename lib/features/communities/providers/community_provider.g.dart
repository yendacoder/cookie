// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CommunityDetail)
final communityDetailProvider = CommunityDetailFamily._();

final class CommunityDetailProvider
    extends $AsyncNotifierProvider<CommunityDetail, Community> {
  CommunityDetailProvider._({
    required CommunityDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'communityDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$communityDetailHash();

  @override
  String toString() {
    return r'communityDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CommunityDetail create() => CommunityDetail();

  @override
  bool operator ==(Object other) {
    return other is CommunityDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$communityDetailHash() => r'612feb7a0378b0e973b8a8588d62f7bb022c750f';

final class CommunityDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          CommunityDetail,
          AsyncValue<Community>,
          Community,
          FutureOr<Community>,
          String
        > {
  CommunityDetailFamily._()
    : super(
        retry: null,
        name: r'communityDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CommunityDetailProvider call(String communityName) =>
      CommunityDetailProvider._(argument: communityName, from: this);

  @override
  String toString() => r'communityDetailProvider';
}

abstract class _$CommunityDetail extends $AsyncNotifier<Community> {
  late final _$args = ref.$arg as String;
  String get communityName => _$args;

  FutureOr<Community> build(String communityName);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Community>, Community>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Community>, Community>,
              AsyncValue<Community>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(CommunityFeedSort)
final communityFeedSortProvider = CommunityFeedSortFamily._();

final class CommunityFeedSortProvider
    extends $AsyncNotifierProvider<CommunityFeedSort, PostSort> {
  CommunityFeedSortProvider._({
    required CommunityFeedSortFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'communityFeedSortProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$communityFeedSortHash();

  @override
  String toString() {
    return r'communityFeedSortProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CommunityFeedSort create() => CommunityFeedSort();

  @override
  bool operator ==(Object other) {
    return other is CommunityFeedSortProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$communityFeedSortHash() => r'7a5828b6831526d94c59da26c2c30f82182d8973';

final class CommunityFeedSortFamily extends $Family
    with
        $ClassFamilyOverride<
          CommunityFeedSort,
          AsyncValue<PostSort>,
          PostSort,
          FutureOr<PostSort>,
          String
        > {
  CommunityFeedSortFamily._()
    : super(
        retry: null,
        name: r'communityFeedSortProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CommunityFeedSortProvider call(String communityName) =>
      CommunityFeedSortProvider._(argument: communityName, from: this);

  @override
  String toString() => r'communityFeedSortProvider';
}

abstract class _$CommunityFeedSort extends $AsyncNotifier<PostSort> {
  late final _$args = ref.$arg as String;
  String get communityName => _$args;

  FutureOr<PostSort> build(String communityName);
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

@ProviderFor(CommunityFeedNotifier)
final communityFeedProvider = CommunityFeedNotifierFamily._();

final class CommunityFeedNotifierProvider
    extends $AsyncNotifierProvider<CommunityFeedNotifier, PostFeedState> {
  CommunityFeedNotifierProvider._({
    required CommunityFeedNotifierFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'communityFeedProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$communityFeedNotifierHash();

  @override
  String toString() {
    return r'communityFeedProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  CommunityFeedNotifier create() => CommunityFeedNotifier();

  @override
  bool operator ==(Object other) {
    return other is CommunityFeedNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$communityFeedNotifierHash() =>
    r'e46afcbf1a8d1871eff0e6fc5a87d69db63ad67e';

final class CommunityFeedNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          CommunityFeedNotifier,
          AsyncValue<PostFeedState>,
          PostFeedState,
          FutureOr<PostFeedState>,
          (String, String)
        > {
  CommunityFeedNotifierFamily._()
    : super(
        retry: null,
        name: r'communityFeedProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CommunityFeedNotifierProvider call(
    String communityName,
    String communityId,
  ) => CommunityFeedNotifierProvider._(
    argument: (communityName, communityId),
    from: this,
  );

  @override
  String toString() => r'communityFeedProvider';
}

abstract class _$CommunityFeedNotifier extends $AsyncNotifier<PostFeedState> {
  late final _$args = ref.$arg as (String, String);
  String get communityName => _$args.$1;
  String get communityId => _$args.$2;

  FutureOr<PostFeedState> build(String communityName, String communityId);
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
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
