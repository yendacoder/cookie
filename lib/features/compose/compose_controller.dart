import 'package:cookie/api/model/community.dart';
import 'package:cookie/api/model/post.dart';
import 'package:cookie/api/model/uploaded_image.dart';
import 'package:cookie/features/compose/compose_repository.dart';
import 'package:cookie/settings/consts.dart';
import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart';

class ComposeController with ChangeNotifier {
  ComposeController(this._composeRepository, this.community);

  final ComposeRepository _composeRepository;
  Community? community;
  UploadedImage? _uploadedImage;

  UploadedImage? get uploadedImage => _uploadedImage;

  Future<Post?> addPost(String title, String body) async {
    final post = await _composeRepository.addPost(
        community?.name ?? kDefaultCommunityName,
        title,
        body,
        _uploadedImage?.id);
    notifyListeners();
    return post;
  }

  Future<UploadedImage?> uploadImage(CroppedFile file, String filename) async {
    final body = await file.readAsBytes();
    _uploadedImage = await _composeRepository.uploadImage(body, filename);
    return _uploadedImage;
  }

  void removeImage() {
    _uploadedImage = null;
    notifyListeners();
  }
}
