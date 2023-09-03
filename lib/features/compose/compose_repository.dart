import 'dart:convert';
import 'dart:typed_data';

import 'package:cookie/api/model/post.dart';
import 'package:cookie/api/model/uploaded_image.dart';
import 'package:cookie/common/controller/initial_controller.dart';
import 'package:cookie/common/repository/repository.dart';
import 'package:cookie/common/util/string_util.dart';

class ComposeRepository extends Repository {
  ComposeRepository(this._authRecordProvider);

  final AuthRecordProvider _authRecordProvider;

  Future<UploadedImage?> uploadImage(
      Uint8List imageContent, String filename) async {
    final authRecord = await _authRecordProvider.getAuthRecord();
    final uri = client.initRequest('_uploads');
    String twoHyphens = '--';
    String boundary = '*****${DateTime.now().millisecondsSinceEpoch}*****';
    String lineEnd = '\r\n';

    const encoder = Utf8Encoder();
    final body = encoder.convert(twoHyphens + boundary + lineEnd) +
        encoder.convert(
            'Content-Disposition: form-data; name="image"; filename="$filename"$lineEnd') +
        // encoder.convert('Content-Type: image/jpeg$lineEnd') +
        encoder.convert('Content-Transfer-Encoding: binary$lineEnd') +
        encoder.convert(lineEnd) +
        imageContent +
        encoder.convert(lineEnd) +
        encoder.convert(twoHyphens + boundary + twoHyphens + lineEnd);
    return await performRequestObjectResult(
      authRecord,
      () async {
        final request = await client.http.postUrl(uri);
        request.headers
            .add('Content-Type', 'multipart/form-data; boundary=$boundary');
        return request;
      },
      (json, _) => UploadedImage.fromJson(json),
      body: body,
    );
  }

  String _getPostType(String body, String? imageId) {
    //TODO: type detection can be a little more sophisticated
    if (imageId != null) {
      return 'image';
    } else {
      if (body.trim().startsWith('http')) {
        if (isImageUrl(body)) {
          return 'image';
        } else {
          return 'link';
        }
      } else {
        return 'text';
      }
    }
  }

  Future<Post?> editPost(
      String? postId, String title, String body, String? imageId) async {
    final authRecord = await _authRecordProvider.getAuthRecord();
    if (authRecord == null) {
      return null;
    }
    final uri = client.initRequest('posts/$postId');
    final type = _getPostType(body, imageId);
    return await performRequestObjectResult(
      authRecord,
      () => client.http.putUrl(uri),
      (json, _) => Post.fromJson(json),
      body: {
        'type': type,
        'title': title,
        if (type == 'text') 'body': body,
        if (type != 'text') 'url': body,
        if (imageId != null) 'imageId': imageId,
      },
    );
  }

  Future<Post?> addPost(
      String communityName, String title, String body, String? imageId) async {
    final authRecord = await _authRecordProvider.getAuthRecord();
    if (authRecord == null) {
      return null;
    }
    final uri = client.initRequest('posts');
    final type = _getPostType(body, imageId);
    return await performRequestObjectResult(
      authRecord,
      () => client.http.postUrl(uri),
      (json, _) => Post.fromJson(json),
      body: {
        'type': type,
        'title': title,
        'community': communityName,
        if (type == 'text') 'body': body,
        if (type != 'text') 'url': body,
        if (imageId != null) 'imageId': imageId,
      },
    );
  }
}
