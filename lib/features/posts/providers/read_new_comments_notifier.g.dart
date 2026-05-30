// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_new_comments_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// When a post detail screen loads successfully, it might want to
/// update all lists that all new comments have been loaded

@ProviderFor(ReadNewCommentsNotifier)
final readNewCommentsProvider = ReadNewCommentsNotifierProvider._();

/// When a post detail screen loads successfully, it might want to
/// update all lists that all new comments have been loaded
final class ReadNewCommentsNotifierProvider
    extends $NotifierProvider<ReadNewCommentsNotifier, Set<String>> {
  /// When a post detail screen loads successfully, it might want to
  /// update all lists that all new comments have been loaded
  ReadNewCommentsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'readNewCommentsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$readNewCommentsNotifierHash();

  @$internal
  @override
  ReadNewCommentsNotifier create() => ReadNewCommentsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$readNewCommentsNotifierHash() =>
    r'd4faea4de28c86eb41e02844813fcf42c70d08f1';

/// When a post detail screen loads successfully, it might want to
/// update all lists that all new comments have been loaded

abstract class _$ReadNewCommentsNotifier extends $Notifier<Set<String>> {
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
