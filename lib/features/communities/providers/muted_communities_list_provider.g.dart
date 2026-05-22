// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'muted_communities_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MutedCommunitiesList)
final mutedCommunitiesListProvider = MutedCommunitiesListProvider._();

final class MutedCommunitiesListProvider
    extends
        $NotifierProvider<MutedCommunitiesList, List<InitialCommunityMute>> {
  MutedCommunitiesListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mutedCommunitiesListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mutedCommunitiesListHash();

  @$internal
  @override
  MutedCommunitiesList create() => MutedCommunitiesList();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<InitialCommunityMute> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<InitialCommunityMute>>(value),
    );
  }
}

String _$mutedCommunitiesListHash() =>
    r'35e47e70d4f795ff765df0538296dc2eed09703e';

abstract class _$MutedCommunitiesList
    extends $Notifier<List<InitialCommunityMute>> {
  List<InitialCommunityMute> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<List<InitialCommunityMute>, List<InitialCommunityMute>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                List<InitialCommunityMute>,
                List<InitialCommunityMute>
              >,
              List<InitialCommunityMute>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
