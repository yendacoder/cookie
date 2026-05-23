// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muted_users_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MutedUsersList)
final mutedUsersListProvider = MutedUsersListProvider._();

final class MutedUsersListProvider
    extends $NotifierProvider<MutedUsersList, List<InitialUserMute>> {
  MutedUsersListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mutedUsersListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mutedUsersListHash();

  @$internal
  @override
  MutedUsersList create() => MutedUsersList();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<InitialUserMute> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<InitialUserMute>>(value),
    );
  }
}

String _$mutedUsersListHash() => r'bbf8a8afcba4df312e72aa6efa5f26eaa9be896a';

abstract class _$MutedUsersList extends $Notifier<List<InitialUserMute>> {
  List<InitialUserMute> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<InitialUserMute>, List<InitialUserMute>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<InitialUserMute>, List<InitialUserMute>>,
              List<InitialUserMute>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
