// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nav_bar_visibility_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NavBarVisibility)
final navBarVisibilityProvider = NavBarVisibilityProvider._();

final class NavBarVisibilityProvider
    extends $NotifierProvider<NavBarVisibility, bool> {
  NavBarVisibilityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'navBarVisibilityProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$navBarVisibilityHash();

  @$internal
  @override
  NavBarVisibility create() => NavBarVisibility();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$navBarVisibilityHash() => r'c12d6db4ce457b20888b1554b5b4dd1f456a8061';

abstract class _$NavBarVisibility extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
