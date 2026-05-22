// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_items_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ListItemsNotifier)
final listItemsProvider = ListItemsNotifierFamily._();

final class ListItemsNotifierProvider
    extends $AsyncNotifierProvider<ListItemsNotifier, ListItemFeedState> {
  ListItemsNotifierProvider._({
    required ListItemsNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'listItemsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$listItemsNotifierHash();

  @override
  String toString() {
    return r'listItemsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ListItemsNotifier create() => ListItemsNotifier();

  @override
  bool operator ==(Object other) {
    return other is ListItemsNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$listItemsNotifierHash() => r'cc08e791def424b5d93795b5f4fe034589649049';

final class ListItemsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ListItemsNotifier,
          AsyncValue<ListItemFeedState>,
          ListItemFeedState,
          FutureOr<ListItemFeedState>,
          int
        > {
  ListItemsNotifierFamily._()
    : super(
        retry: null,
        name: r'listItemsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ListItemsNotifierProvider call(int listId) =>
      ListItemsNotifierProvider._(argument: listId, from: this);

  @override
  String toString() => r'listItemsProvider';
}

abstract class _$ListItemsNotifier extends $AsyncNotifier<ListItemFeedState> {
  late final _$args = ref.$arg as int;
  int get listId => _$args;

  FutureOr<ListItemFeedState> build(int listId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<ListItemFeedState>, ListItemFeedState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ListItemFeedState>, ListItemFeedState>,
              AsyncValue<ListItemFeedState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
