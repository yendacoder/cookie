// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_lists_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserListsNotifier)
final userListsProvider = UserListsNotifierProvider._();

final class UserListsNotifierProvider
    extends $AsyncNotifierProvider<UserListsNotifier, List<UserList>> {
  UserListsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userListsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userListsNotifierHash();

  @$internal
  @override
  UserListsNotifier create() => UserListsNotifier();
}

String _$userListsNotifierHash() => r'8307b25fbc17d5e46d88c2e77f98eb2ee5d2db4b';

abstract class _$UserListsNotifier extends $AsyncNotifier<List<UserList>> {
  FutureOr<List<UserList>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<UserList>>, List<UserList>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<UserList>>, List<UserList>>,
              AsyncValue<List<UserList>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
