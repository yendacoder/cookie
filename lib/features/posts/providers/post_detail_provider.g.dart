// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PostDetailNotifier)
final postDetailProvider = PostDetailNotifierFamily._();

final class PostDetailNotifierProvider
    extends $AsyncNotifierProvider<PostDetailNotifier, Post> {
  PostDetailNotifierProvider._({
    required PostDetailNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'postDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$postDetailNotifierHash();

  @override
  String toString() {
    return r'postDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PostDetailNotifier create() => PostDetailNotifier();

  @override
  bool operator ==(Object other) {
    return other is PostDetailNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$postDetailNotifierHash() =>
    r'5b05613b748031466b476e1bc7a8fce9feeb2ed4';

final class PostDetailNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          PostDetailNotifier,
          AsyncValue<Post>,
          Post,
          FutureOr<Post>,
          String
        > {
  PostDetailNotifierFamily._()
    : super(
        retry: null,
        name: r'postDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PostDetailNotifierProvider call(String publicId) =>
      PostDetailNotifierProvider._(argument: publicId, from: this);

  @override
  String toString() => r'postDetailProvider';
}

abstract class _$PostDetailNotifier extends $AsyncNotifier<Post> {
  late final _$args = ref.$arg as String;
  String get publicId => _$args;

  FutureOr<Post> build(String publicId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Post>, Post>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Post>, Post>,
              AsyncValue<Post>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
