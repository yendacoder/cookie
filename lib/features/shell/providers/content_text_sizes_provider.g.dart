// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_text_sizes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ContentTextSizesNotifier)
final contentTextSizesProvider = ContentTextSizesNotifierProvider._();

final class ContentTextSizesNotifierProvider
    extends $NotifierProvider<ContentTextSizesNotifier, ContentTextSizes> {
  ContentTextSizesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentTextSizesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contentTextSizesNotifierHash();

  @$internal
  @override
  ContentTextSizesNotifier create() => ContentTextSizesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContentTextSizes value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContentTextSizes>(value),
    );
  }
}

String _$contentTextSizesNotifierHash() =>
    r'dfc7bf3cfbc76e4f273101b292d230dbf1b04878';

abstract class _$ContentTextSizesNotifier extends $Notifier<ContentTextSizes> {
  ContentTextSizes build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ContentTextSizes, ContentTextSizes>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ContentTextSizes, ContentTextSizes>,
              ContentTextSizes,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
