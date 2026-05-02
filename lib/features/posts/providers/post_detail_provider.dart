import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';
import '../../../models/post.dart';

part 'post_detail_provider.g.dart';

@riverpod
Future<Post> postDetail(Ref ref, String publicId) async {
  final response = await ref.read(apiClientProvider).get(
    'posts/$publicId',
    queryParameters: {'fetchCommunity': 'true'},
  );
  return Post.fromJson(response.data as Map<String, dynamic>);
}
