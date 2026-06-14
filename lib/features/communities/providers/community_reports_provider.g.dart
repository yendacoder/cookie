// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_reports_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CommunityReports)
final communityReportsProvider = CommunityReportsFamily._();

final class CommunityReportsProvider
    extends $AsyncNotifierProvider<CommunityReports, CommunityReportsState> {
  CommunityReportsProvider._({
    required CommunityReportsFamily super.from,
    required (String, ReportFilter) super.argument,
  }) : super(
         retry: null,
         name: r'communityReportsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$communityReportsHash();

  @override
  String toString() {
    return r'communityReportsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  CommunityReports create() => CommunityReports();

  @override
  bool operator ==(Object other) {
    return other is CommunityReportsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$communityReportsHash() => r'7c9bbf91701ba8d3602a136119b2072ed65ea037';

final class CommunityReportsFamily extends $Family
    with
        $ClassFamilyOverride<
          CommunityReports,
          AsyncValue<CommunityReportsState>,
          CommunityReportsState,
          FutureOr<CommunityReportsState>,
          (String, ReportFilter)
        > {
  CommunityReportsFamily._()
    : super(
        retry: null,
        name: r'communityReportsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CommunityReportsProvider call(String communityId, ReportFilter filter) =>
      CommunityReportsProvider._(argument: (communityId, filter), from: this);

  @override
  String toString() => r'communityReportsProvider';
}

abstract class _$CommunityReports
    extends $AsyncNotifier<CommunityReportsState> {
  late final _$args = ref.$arg as (String, ReportFilter);
  String get communityId => _$args.$1;
  ReportFilter get filter => _$args.$2;

  FutureOr<CommunityReportsState> build(
    String communityId,
    ReportFilter filter,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<CommunityReportsState>, CommunityReportsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<CommunityReportsState>,
                CommunityReportsState
              >,
              AsyncValue<CommunityReportsState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
