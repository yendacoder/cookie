// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_tab_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LastTab)
final lastTabProvider = LastTabProvider._();

final class LastTabProvider extends $NotifierProvider<LastTab, int> {
  LastTabProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lastTabProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lastTabHash();

  @$internal
  @override
  LastTab create() => LastTab();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$lastTabHash() => r'e04b60aa355f11ad94a3abcd7553f845e88d215c';

abstract class _$LastTab extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
