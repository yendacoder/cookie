import 'dart:io';

import 'package:cookie/api/auth_record.dart';
import 'package:cookie/api/model/community.dart';
import 'package:cookie/api/model/initial.dart';
import 'package:cookie/api/model/post.dart';
import 'package:cookie/common/repository/initial_repository.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthRecordProvider {
  Future<AuthRecord?> getAuthRecord();
}

class InitialController with ChangeNotifier implements AuthRecordProvider {
  InitialController(this.initialRepository);

  final InitialRepository initialRepository;
  bool _isInitialized = false;
  AuthRecord _authRecord = AuthRecord.empty();
  Initial? initial;

  bool get isLoggedIn => initial?.user != null;

  Future<void> _initialize() async {
    final persistedAuthRecord =
        await initialRepository.getPersistedAuthRecord();
    if (persistedAuthRecord != null) {
      _authRecord = persistedAuthRecord;
    }
    final responseWithCookies = await initialRepository.getInitial(_authRecord);
    final authRecord = _authRecordFromCookies(responseWithCookies.cookies);
    if (authRecord != null) {
      _authRecord = authRecord;
      initialRepository.persistAuthRecord(authRecord);
    }
    initial = responseWithCookies.response;
    await initialRepository.persistAuthRecord(_authRecord);
    _isInitialized = true;
  }

  AuthRecord? _authRecordFromCookies(List<Cookie> cookies) {
    final record = AuthRecord.fromCookies(cookies);
    if (record.sessionToken != null) {
      return record;
    }
    return null;
  }

  @override
  Future<AuthRecord> getAuthRecord() async {
    if (!_isInitialized) {
      await _initialize();
    }
    return _authRecord;
  }

  Future<void> logout() async {
    // logout API seems confusing and not operational, we will just
    // delete the auth record and start over
    _authRecord = AuthRecord.empty();
    await initialRepository.persistAuthRecord(null);
    await _initialize();
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    final authRecord = await getAuthRecord();
    await initialRepository.login(authRecord, username, password);
    final responseWithCookies = await initialRepository.getInitial(_authRecord);
    initial = responseWithCookies.response;
    notifyListeners();
  }

  Future<void> toggleJoinCommunity(Community community) async {
    if (!isLoggedIn || initial == null) {
      return;
    }
    final authRecord = await getAuthRecord();
    if (community.userJoined == true) {
      await initialRepository.joinCommunity(authRecord, community.id, false);
      community.userJoined = false;
      initial!.communities.remove(community);
    } else {
      await initialRepository.joinCommunity(authRecord, community.id, true);
      community.userJoined = true;
      initial!.communities.insert(0, community);
    }
    notifyListeners();
  }

  Future<Post?> addPost(String communityName, String title, String body) async {
    if (!isLoggedIn || initial == null) {
      return null;
    }
    final authRecord = await getAuthRecord();
    final post =
        await initialRepository.addPost(authRecord, communityName, title, body);
    return post;
  }
}
