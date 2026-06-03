import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:cookie/core/api/api_client.dart';
import 'package:cookie/models/user_list.dart';
import 'package:cookie/features/auth/providers/auth_provider.dart';

part 'user_lists_provider.g.dart';

@riverpod
class UserListsNotifier extends _$UserListsNotifier {
  @override
  Future<List<UserList>> build() async {
    final user = ref.watch(authProvider).value;
    if (user == null) return [];
    final response = await ref
        .read(apiClientProvider)
        .get('users/${user.username}/lists');
    return (response.data as List)
        .cast<Map<String, dynamic>>()
        .map(UserList.fromJson)
        .toList();
  }

  Future<void> create({
    required String name,
    required String displayName,
    String? description,
    required bool public,
  }) async {
    final user = ref.read(authProvider).value!;
    final response = await ref
        .read(apiClientProvider)
        .post(
          'users/${user.username}/lists',
          data: {
            'name': name,
            'displayName': displayName,
            if (description != null && description.isNotEmpty)
              'description': description,
            'public': public,
          },
        );
    // Server returns the full updated list array.
    final lists = (response.data as List)
        .cast<Map<String, dynamic>>()
        .map(UserList.fromJson)
        .toList();
    state = AsyncData(lists);
  }

  void updateList(UserList updated) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData([
      for (final l in current)
        if (l.id == updated.id) updated else l,
    ]);
  }

  Future<void> delete(int listId) async {
    final current = state.value ?? [];
    state = AsyncData(current.where((l) => l.id != listId).toList());
    try {
      await ref.read(apiClientProvider).delete('lists/$listId');
    } catch (_) {
      state = AsyncData(current);
      rethrow;
    }
  }
}
