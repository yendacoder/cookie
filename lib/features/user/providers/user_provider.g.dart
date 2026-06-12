// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserDetailNotifier)
final userDetailProvider = UserDetailNotifierFamily._();

final class UserDetailNotifierProvider
    extends $AsyncNotifierProvider<UserDetailNotifier, PublicUser> {
  UserDetailNotifierProvider._({
    required UserDetailNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userDetailNotifierHash();

  @override
  String toString() {
    return r'userDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  UserDetailNotifier create() => UserDetailNotifier();

  @override
  bool operator ==(Object other) {
    return other is UserDetailNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userDetailNotifierHash() =>
    r'd1d51101057f81e4688fd2aa015dbd0e2c00c0fb';

final class UserDetailNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          UserDetailNotifier,
          AsyncValue<PublicUser>,
          PublicUser,
          FutureOr<PublicUser>,
          String
        > {
  UserDetailNotifierFamily._()
    : super(
        retry: null,
        name: r'userDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserDetailNotifierProvider call(String username) =>
      UserDetailNotifierProvider._(argument: username, from: this);

  @override
  String toString() => r'userDetailProvider';
}

abstract class _$UserDetailNotifier extends $AsyncNotifier<PublicUser> {
  late final _$args = ref.$arg as String;
  String get username => _$args;

  FutureOr<PublicUser> build(String username);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PublicUser>, PublicUser>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PublicUser>, PublicUser>,
              AsyncValue<PublicUser>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(UserActivityNotifier)
final userActivityProvider = UserActivityNotifierFamily._();

final class UserActivityNotifierProvider
    extends $AsyncNotifierProvider<UserActivityNotifier, UserActivityState> {
  UserActivityNotifierProvider._({
    required UserActivityNotifierFamily super.from,
    required (String, UserActivityFilter) super.argument,
  }) : super(
         retry: null,
         name: r'userActivityProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userActivityNotifierHash();

  @override
  String toString() {
    return r'userActivityProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  UserActivityNotifier create() => UserActivityNotifier();

  @override
  bool operator ==(Object other) {
    return other is UserActivityNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userActivityNotifierHash() =>
    r'960b5434900bbf21e1184abeabbce7ec2fd071eb';

final class UserActivityNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          UserActivityNotifier,
          AsyncValue<UserActivityState>,
          UserActivityState,
          FutureOr<UserActivityState>,
          (String, UserActivityFilter)
        > {
  UserActivityNotifierFamily._()
    : super(
        retry: null,
        name: r'userActivityProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserActivityNotifierProvider call(
    String username,
    UserActivityFilter filter,
  ) => UserActivityNotifierProvider._(argument: (username, filter), from: this);

  @override
  String toString() => r'userActivityProvider';
}

abstract class _$UserActivityNotifier
    extends $AsyncNotifier<UserActivityState> {
  late final _$args = ref.$arg as (String, UserActivityFilter);
  String get username => _$args.$1;
  UserActivityFilter get filter => _$args.$2;

  FutureOr<UserActivityState> build(String username, UserActivityFilter filter);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<UserActivityState>, UserActivityState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserActivityState>, UserActivityState>,
              AsyncValue<UserActivityState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
