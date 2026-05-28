// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voting_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PostVotesNotifier)
final postVotesProvider = PostVotesNotifierProvider._();

final class PostVotesNotifierProvider
    extends $NotifierProvider<PostVotesNotifier, Map<String, VoteState>> {
  PostVotesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postVotesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postVotesNotifierHash();

  @$internal
  @override
  PostVotesNotifier create() => PostVotesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, VoteState> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, VoteState>>(value),
    );
  }
}

String _$postVotesNotifierHash() => r'af06a3cfa9e899fac410523267f8fbf9fd308ed8';

abstract class _$PostVotesNotifier extends $Notifier<Map<String, VoteState>> {
  Map<String, VoteState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<Map<String, VoteState>, Map<String, VoteState>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, VoteState>, Map<String, VoteState>>,
              Map<String, VoteState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(CommentVotesNotifier)
final commentVotesProvider = CommentVotesNotifierProvider._();

final class CommentVotesNotifierProvider
    extends $NotifierProvider<CommentVotesNotifier, Map<String, VoteState>> {
  CommentVotesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'commentVotesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$commentVotesNotifierHash();

  @$internal
  @override
  CommentVotesNotifier create() => CommentVotesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, VoteState> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, VoteState>>(value),
    );
  }
}

String _$commentVotesNotifierHash() =>
    r'bb8b8b74ee019dd56d10b8828e4239584e02fddd';

abstract class _$CommentVotesNotifier
    extends $Notifier<Map<String, VoteState>> {
  Map<String, VoteState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<Map<String, VoteState>, Map<String, VoteState>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, VoteState>, Map<String, VoteState>>,
              Map<String, VoteState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
