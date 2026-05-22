// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserList _$UserListFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_UserList', json, ($checkedConvert) {
      final val = _UserList(
        id: $checkedConvert('id', (v) => (v as num).toInt()),
        userId: $checkedConvert('userId', (v) => v as String),
        username: $checkedConvert('username', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        displayName: $checkedConvert('displayName', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String?),
        public: $checkedConvert('public', (v) => v as bool),
        numItems: $checkedConvert('numItems', (v) => (v as num).toInt()),
        sort: $checkedConvert('sort', (v) => v as String),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
        lastUpdatedAt: $checkedConvert(
          'lastUpdatedAt',
          (v) => DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$UserListToJson(_UserList instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'username': instance.username,
  'name': instance.name,
  'displayName': instance.displayName,
  'description': instance.description,
  'public': instance.public,
  'numItems': instance.numItems,
  'sort': instance.sort,
  'createdAt': instance.createdAt.toIso8601String(),
  'lastUpdatedAt': instance.lastUpdatedAt.toIso8601String(),
};

_ListItem _$ListItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ListItem', json, ($checkedConvert) {
      final val = _ListItem(
        id: $checkedConvert('id', (v) => (v as num).toInt()),
        listId: $checkedConvert('listId', (v) => (v as num).toInt()),
        targetType: $checkedConvert('targetType', (v) => v as String),
        targetId: $checkedConvert('targetId', (v) => v as String),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
        targetItem: $checkedConvert(
          'targetItem',
          (v) => v as Map<String, dynamic>?,
        ),
      );
      return val;
    });

Map<String, dynamic> _$ListItemToJson(_ListItem instance) => <String, dynamic>{
  'id': instance.id,
  'listId': instance.listId,
  'targetType': instance.targetType,
  'targetId': instance.targetId,
  'createdAt': instance.createdAt.toIso8601String(),
  'targetItem': instance.targetItem,
};
