// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_mutes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserMutes)
final userMutesProvider = UserMutesProvider._();

final class UserMutesProvider
    extends $NotifierProvider<UserMutes, Set<String>> {
  UserMutesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userMutesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userMutesHash();

  @$internal
  @override
  UserMutes create() => UserMutes();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$userMutesHash() => r'17c95fce43dec2395e914e0c9e22499ea64d62d3';

abstract class _$UserMutes extends $Notifier<Set<String>> {
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
