// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_scale_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TextScale)
final textScaleProvider = TextScaleProvider._();

final class TextScaleProvider extends $NotifierProvider<TextScale, double> {
  TextScaleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'textScaleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$textScaleHash();

  @$internal
  @override
  TextScale create() => TextScale();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }
}

String _$textScaleHash() => r'7788e377b8c8ccc24d0d97ab8f5b381a4aa21971';

abstract class _$TextScale extends $Notifier<double> {
  double build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<double, double>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<double, double>,
              double,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
