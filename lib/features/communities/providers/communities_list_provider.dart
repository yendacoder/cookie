import 'package:cookie/core/api/api_client.dart';
import 'package:cookie/models/community.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'communities_list_provider.g.dart';

/// All communities — fetched once and kept alive for the session.
@Riverpod(keepAlive: true)
Future<List<Community>> allCommunities(Ref ref) async {
  final response = await ref
      .read(apiClientProvider)
      .get('communities', queryParameters: {'set': 'all'});
  return (response.data as List)
      .cast<Map<String, dynamic>>()
      .map(Community.fromJson)
      .toList();
}

/// Communities the authenticated user has joined — refetched on each visit.
@riverpod
Future<List<Community>> subscribedCommunities(Ref ref) async {
  final response = await ref
      .read(apiClientProvider)
      .get('communities', queryParameters: {'set': 'subscribed'});
  return (response.data as List)
      .cast<Map<String, dynamic>>()
      .map(Community.fromJson)
      .toList();
}
