// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_banned_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CommunityBannedUsers)
final communityBannedUsersProvider = CommunityBannedUsersFamily._();

final class CommunityBannedUsersProvider
    extends $AsyncNotifierProvider<CommunityBannedUsers, List<User>> {
  CommunityBannedUsersProvider._({
    required CommunityBannedUsersFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'communityBannedUsersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$communityBannedUsersHash();

  @override
  String toString() {
    return r'communityBannedUsersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CommunityBannedUsers create() => CommunityBannedUsers();

  @override
  bool operator ==(Object other) {
    return other is CommunityBannedUsersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$communityBannedUsersHash() =>
    r'eb9e61b6d8e41cf3dfb24c44f65432a5cddc4983';

final class CommunityBannedUsersFamily extends $Family
    with
        $ClassFamilyOverride<
          CommunityBannedUsers,
          AsyncValue<List<User>>,
          List<User>,
          FutureOr<List<User>>,
          String
        > {
  CommunityBannedUsersFamily._()
    : super(
        retry: null,
        name: r'communityBannedUsersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CommunityBannedUsersProvider call(String communityId) =>
      CommunityBannedUsersProvider._(argument: communityId, from: this);

  @override
  String toString() => r'communityBannedUsersProvider';
}

abstract class _$CommunityBannedUsers extends $AsyncNotifier<List<User>> {
  late final _$args = ref.$arg as String;
  String get communityId => _$args;

  FutureOr<List<User>> build(String communityId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<User>>, List<User>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<User>>, List<User>>,
              AsyncValue<List<User>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
