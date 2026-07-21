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
final readNewCommentsProvider = ReadNewCommentsNotifierFamily._();

/// When a post detail screen loads successfully, it might want to
/// update all lists that all new comments have been loaded
final class ReadNewCommentsNotifierProvider
    extends $NotifierProvider<ReadNewCommentsNotifier, Set<String>> {
  /// When a post detail screen loads successfully, it might want to
  /// update all lists that all new comments have been loaded
  ReadNewCommentsNotifierProvider._({
    required ReadNewCommentsNotifierFamily super.from,
    required HeroTagScope super.argument,
  }) : super(
         retry: null,
         name: r'readNewCommentsProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$readNewCommentsNotifierHash();

  @override
  String toString() {
    return r'readNewCommentsProvider'
        ''
        '($argument)';
  }

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

  @override
  bool operator ==(Object other) {
    return other is ReadNewCommentsNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$readNewCommentsNotifierHash() =>
    r'fb8b49e8487f986401d62d9fc9d40fa757303365';

/// When a post detail screen loads successfully, it might want to
/// update all lists that all new comments have been loaded

final class ReadNewCommentsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ReadNewCommentsNotifier,
          Set<String>,
          Set<String>,
          Set<String>,
          HeroTagScope
        > {
  ReadNewCommentsNotifierFamily._()
    : super(
        retry: null,
        name: r'readNewCommentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// When a post detail screen loads successfully, it might want to
  /// update all lists that all new comments have been loaded

  ReadNewCommentsNotifierProvider call(HeroTagScope heroTagScope) =>
      ReadNewCommentsNotifierProvider._(argument: heroTagScope, from: this);

  @override
  String toString() => r'readNewCommentsProvider';
}

/// When a post detail screen loads successfully, it might want to
/// update all lists that all new comments have been loaded

abstract class _$ReadNewCommentsNotifier extends $Notifier<Set<String>> {
  late final _$args = ref.$arg as HeroTagScope;
  HeroTagScope get heroTagScope => _$args;

  Set<String> build(HeroTagScope heroTagScope);
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
    element.handleCreate(ref, () => build(_$args));
  }
}
