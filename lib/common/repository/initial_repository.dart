import 'dart:convert';

import 'package:cookie/api/auth_record.dart';
import 'package:cookie/api/model/initial.dart';
import 'package:cookie/api/model/response_with_cookies.dart';
import 'package:cookie/common/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kAuthRecordKey = 'auth_record';

class InitialRepository extends Repository {
  Future<ResponseWithCookies<Initial>> getInitial(AuthRecord authRecord) async {
    final uri = client.initRequest('_initial');
    return performRequestObjectResult(
        authRecord,
        () => client.http.getUrl(uri),
        (json, headers) =>
            ResponseWithCookies(Initial.fromJson(json), headers));
  }

  Future<AuthRecord?> getPersistedAuthRecord() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(_kAuthRecordKey)) {
      final serializedRecord = prefs.getString(_kAuthRecordKey);
      return AuthRecord.fromJson(
          json.decode(serializedRecord!) as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> persistAuthRecord(AuthRecord? authRecord) async {
    final prefs = await SharedPreferences.getInstance();
    if (authRecord == null) {
      await prefs.remove(_kAuthRecordKey);
    } else {
      await prefs.setString(_kAuthRecordKey, json.encode(authRecord.toJson()));
    }
  }

  Future<void> login(AuthRecord authRecord, String username, String password) {
    final uri = client.initRequest('_login');
    return performRequestEmptyResult(authRecord, () => client.http.postUrl(uri),
        body: {
          'username': username,
          'password': password,
        });
  }

  Future<void> joinCommunity(
      AuthRecord authRecord, String communityId, bool join) {
    final uri = client.initRequest('_joinCommunity');
    return performRequestEmptyResult(authRecord, () => client.http.postUrl(uri),
        body: {
          'communityId': communityId,
          'leave': !join,
        });
  }

  Future<void> deletePost(AuthRecord authRecord, String postId) {
    final uri = client.initRequest('posts/$postId', parameters: {
      'deleteAs': 'normal',
    });
    return performRequestEmptyResult(authRecord, () => client.http.deleteUrl(uri));
  }
}
