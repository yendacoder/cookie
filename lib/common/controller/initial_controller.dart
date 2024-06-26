import 'dart:io';

import 'package:cookie/api/auth_record.dart';
import 'package:cookie/api/model/community.dart';
import 'package:cookie/api/model/community_mute.dart';
import 'package:cookie/api/model/initial.dart';
import 'package:cookie/api/model/post.dart';
import 'package:cookie/api/model/user.dart';
import 'package:cookie/api/model/user_mute.dart';
import 'package:cookie/common/repository/initial_repository.dart';
import 'package:cookie/common/repository/settings_repository.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthRecordProvider {
  Future<AuthRecord?> getAuthRecord();
}

class InitialController with ChangeNotifier implements AuthRecordProvider {
  InitialController(this.initialRepository, this.settingsRepository);

  final InitialRepository initialRepository;
  final SettingsRepository settingsRepository;
  bool _isInitialized = false;
  AuthRecord _authRecord = AuthRecord.empty();
  Initial? initial;

  // we will make a settings objects later, right now we only a few settings
  FeedViewType _feedViewType = FeedViewType.regular;

  FeedViewType get feedViewType => _feedViewType;

  set feedViewType(FeedViewType value) {
    _feedViewType = value;
    settingsRepository.persistFeedViewType(value);
    notifyListeners();
  }

  bool _disableImageCache = false;

  bool get disableImageCache => _disableImageCache;

  set disableImageCache(bool value) {
    _disableImageCache = value;
    settingsRepository.persistDisableImageCache(value);
    notifyListeners();
  }

  bool _inlineFullImages = true;

  bool get inlineFullImages => _inlineFullImages;

  set inlineFullImages(bool value) {
    _inlineFullImages = value;
    settingsRepository.persistInlineFullImages(value);
    notifyListeners();
  }

  bool get isLoggedIn => initial?.user != null;

  Future<void> _initialize() async {
    _feedViewType = await settingsRepository.getSavedFeedViewType();
    _disableImageCache = await settingsRepository.getDisableImageCache();
    _inlineFullImages = await settingsRepository.getInlineFullImages();

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

  Future<void> deletePost(Post post) async {
    final authRecord = await getAuthRecord();
    await initialRepository.deletePost(authRecord, post.publicId);
    notifyListeners();
  }

  void notifyNewPost() {
    notifyListeners();
  }

  bool isUserMuted(String userId) {
    return initial?.mutes.userMutes.any((mute) => mute.mutedUserId == userId) ??
        false;
  }

  Future<bool> toggleUserMute(User user) async {
    bool isMuted = isUserMuted(user.id);
    if (isMuted) {
      await initialRepository.unmuteUser(_authRecord, user.id);
      initial?.mutes.userMutes.removeWhere((mute) => mute.mutedUserId == user.id);
    } else {
      await initialRepository.muteUser(_authRecord, user.id);
      initial?.mutes.userMutes
          .add(UserMute('', 'user', user.id, DateTime.now(), user));
    }
    notifyListeners();
    return !isMuted;
  }

  bool isCommunityMuted(String communityId) {
    return initial?.mutes.communityMutes.any((mute) => mute.mutedCommunityId == communityId) ??
        false;
  }

  Future<bool> toggleCommunityMute(Community community) async {
    bool isMuted = isCommunityMuted(community.id);
    if (isMuted) {
      await initialRepository.unmuteCommunity(_authRecord, community.id);
      initial?.mutes.communityMutes.removeWhere((mute) => mute.mutedCommunityId == community.id);
    } else {
      await initialRepository.muteCommunity(_authRecord, community.id);
      initial?.mutes.communityMutes
          .add(CommunityMute('', community.id, DateTime.now(), community));
    }
    notifyListeners();
    return !isMuted;
  }
}
