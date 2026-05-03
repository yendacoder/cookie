// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communities_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// All communities — fetched once and kept alive for the session.

@ProviderFor(allCommunities)
final allCommunitiesProvider = AllCommunitiesProvider._();

/// All communities — fetched once and kept alive for the session.

final class AllCommunitiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Community>>,
          List<Community>,
          FutureOr<List<Community>>
        >
    with $FutureModifier<List<Community>>, $FutureProvider<List<Community>> {
  /// All communities — fetched once and kept alive for the session.
  AllCommunitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allCommunitiesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allCommunitiesHash();

  @$internal
  @override
  $FutureProviderElement<List<Community>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Community>> create(Ref ref) {
    return allCommunities(ref);
  }
}

String _$allCommunitiesHash() => r'59f57588b10d3ed07dbdc82231862ec8ea71a119';

/// Communities the authenticated user has joined — refetched on each visit.

@ProviderFor(subscribedCommunities)
final subscribedCommunitiesProvider = SubscribedCommunitiesProvider._();

/// Communities the authenticated user has joined — refetched on each visit.

final class SubscribedCommunitiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Community>>,
          List<Community>,
          FutureOr<List<Community>>
        >
    with $FutureModifier<List<Community>>, $FutureProvider<List<Community>> {
  /// Communities the authenticated user has joined — refetched on each visit.
  SubscribedCommunitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subscribedCommunitiesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subscribedCommunitiesHash();

  @$internal
  @override
  $FutureProviderElement<List<Community>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Community>> create(Ref ref) {
    return subscribedCommunities(ref);
  }
}

String _$subscribedCommunitiesHash() =>
    r'4d2b557854c3cd4cd224aa20073ade3c772a9ddd';
