import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_list.freezed.dart';
part 'user_list.g.dart';

@freezed
abstract class UserList with _$UserList {
  const factory UserList({
    required int id,
    required String userId,
    required String username,
    required String name,
    required String displayName,
    String? description,
    required bool public,
    required int numItems,
    required String sort,
    required DateTime createdAt,
    required DateTime lastUpdatedAt,
  }) = _UserList;

  factory UserList.fromJson(Map<String, dynamic> json) =>
      _$UserListFromJson(json);
}

@freezed
abstract class ListItem with _$ListItem {
  const factory ListItem({
    required int id,
    required int listId,
    required String targetType,
    required String targetId,
    required DateTime createdAt,
    // targetItem is Post | Comment — deserialized separately based on targetType
    Map<String, dynamic>? targetItem,
  }) = _ListItem;

  factory ListItem.fromJson(Map<String, dynamic> json) =>
      _$ListItemFromJson(json);
}
