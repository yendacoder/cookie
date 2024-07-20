import 'package:cookie/api/model/community.dart';
import 'package:cookie/api/model/image.dart';
import 'package:cookie/api/model/post.dart';
import 'package:cookie/api/model/uploaded_image.dart';
import 'package:cookie/features/compose/compose_repository.dart';
import 'package:cookie/settings/consts.dart';
import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart';

class ComposeController with ChangeNotifier {
  ComposeController(this._composeRepository, Community? community, this._editPost) {
    _communityName = _editPost?.communityName ?? community?.name;
    _communityIcon = _editPost?.communityProPic ?? community?.proPic;
  }

  final ComposeRepository _composeRepository;
  String? _communityName;
  String get communityName => _communityName ?? kDefaultCommunityName;
  Image? _communityIcon;
  Image? get communityIcon => _communityIcon;
  UploadedImage? _uploadedImage;

  String? get uploadedImageUrl => _uploadedImage?.url ??
      (_editPost?.type == 'image' ? _editPost?.images?.last.url : null);
  double get uploadedImageRatio {
    if (_uploadedImage != null) {
      return _uploadedImage!.width.toDouble() /
          _uploadedImage!.height;
    }
    if (_editPost?.type == 'image') {
      return _editPost!.images!.last.width.toDouble() /
          _editPost!.images!.last.height;
    }
    return kDefaultImageAspectRatio;
  }
  final Post? _editPost;

  bool get isEditing => _editPost != null;
  String? get nonEditablePostBody => isEditing && _editPost!.type != 'text' ? (_editPost!.link?.url ?? '') : null;

  Future<Post?> save(String title, String body) async {
    late final Post? post;
    if (isEditing) {
       post = await _composeRepository.editPost(
          _editPost!.publicId,
          title,
          body,
          _uploadedImage?.id);
    } else {
      post = await _composeRepository.addPost(
          communityName,
          title,
          body,
          _uploadedImage?.id);
    }
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
