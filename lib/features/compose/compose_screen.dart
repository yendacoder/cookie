import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cookie/api/model/community.dart';
import 'package:cookie/api/model/post.dart';
import 'package:cookie/common/controller/initial_controller.dart';
import 'package:cookie/common/ui/notifications.dart';
import 'package:cookie/common/ui/widgets/common/flat_appbar.dart';
import 'package:cookie/common/ui/widgets/community_icon.dart';
import 'package:cookie/common/util/context_util.dart';
import 'package:cookie/features/compose/compose_controller.dart';
import 'package:cookie/features/compose/compose_repository.dart';
import 'package:cookie/router/router.gr.dart';
import 'package:cookie/settings/app_config.dart';
import 'package:cookie/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class ComposeScreen extends StatefulWidget {
  const ComposeScreen({super.key, this.community, this.editPost});

  final Community? community;
  final Post? editPost;

  @override
  State<ComposeScreen> createState() => _ComposeScreenState();
}

const _kCroppingImageName = 'cropping_image';

class _ComposeScreenState extends State<ComposeScreen> {
  late final TextEditingController _titleController =
      TextEditingController(text: widget.editPost?.title);
  late final TextEditingController _bodyController =
      TextEditingController(text: widget.editPost?.body);
  final ImagePicker _picker = ImagePicker();
  bool _isSaving = false;
  bool _isUploadingImage = false;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _saveImage(ComposeController controller, CroppedFile croppedFile) async {
    if (!mounted) {
      return;
    }
    try {
      setState(() {
        _isUploadingImage = true;
      });
      final prefs = await SharedPreferences.getInstance();
      await controller.uploadImage(
          croppedFile, prefs.getString(_kCroppingImageName) ?? '');
    } catch (e) {
      showApiErrorMessage(context, e);
    } finally {
      setState(() {
        _isUploadingImage = false;
      });
    }
  }

  void _cropImage(ComposeController controller, XFile image) async {
    // we are saving the image file name in shared prefs because
    // on Android the activity can be killed and the name saved in
    // state won't be preserved
    final theme = Theme.of(context);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_kCroppingImageName, image.name);
    final cropper = ImageCropper();
    final croppedFile =
        await cropper.cropImage(sourcePath: image.path, uiSettings: [
      AndroidUiSettings(
          toolbarColor: theme.colorScheme.surface,
          toolbarWidgetColor: theme.colorScheme.onSurface,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        resetAspectRatioEnabled: true,
      ),
    ]);
    await cropper.recoverImage();
    if (mounted && croppedFile != null) {
      _saveImage(controller, croppedFile);
    }
  }

  void _pickImage(ComposeController controller, ImageSource source) async {
    final image = await _picker.pickImage(source: source);
    if (Platform.isAndroid) {
      // reset lost data, won't need it at this point
      await _picker.retrieveLostData();
    }
    if (image != null && mounted) {
      _cropImage(controller, image);
    }
  }

  void _getLostData(ComposeController controller) async {
    try {
      if (Platform.isAndroid) {
        final LostDataResponse response = await _picker.retrieveLostData();
        if (!response.isEmpty && response.files?.isNotEmpty == true) {
          if (mounted) {
            _cropImage(controller, response.files![0]);
          }
        } else {
          final recoveredCroppedImage = await ImageCropper().recoverImage();
          if (recoveredCroppedImage != null) {
            _saveImage(controller, recoveredCroppedImage);
          }
        }
      }
    } catch (e) {
      // this happens sometimes, library issue
    }
  }

  Future<void> _post(BuildContext context, ComposeController controller) async {
    if (_titleController.text.isEmpty) {
      return;
    }
    try {
      setState(() {
        _isSaving = true;
      });
      final post =
          await controller.save(_titleController.text, _bodyController.text);
      if (mounted && post != null) {
        context.router.replace(PostRoute(postId: post.publicId, post: post));
      }
    } catch (e) {
      showApiErrorMessage(context, e);
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  Widget _buildImage(BuildContext context, ComposeController controller) {
    if (controller.uploadedImageUrl != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: kSecondaryPadding),
        child: AspectRatio(
          aspectRatio: controller.uploadedImageRatio,
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(kDefaultCornerRadius),
                  child: Image.network(AppConfigProvider.of(context)
                      .getFullImageUrl(controller.uploadedImageUrl!))),
              if (!controller.isEditing)
                Padding(
                  padding: const EdgeInsets.all(kSecondaryPadding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => controller.removeImage()),
                      IconButton(
                        icon: const Icon(Icons.replay),
                        onPressed: () =>
                            _pickImage(controller, ImageSource.gallery),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      );
    }
    return AspectRatio(
      aspectRatio: kDefaultImageAspectRatio,
      child: Center(
        child: PlatformCircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider(create: (_) {
      final controller = ComposeController(
          ComposeRepository(Provider.of<InitialController>(context)),
          widget.community,
          widget.editPost);
      _getLostData(controller);
      return controller;
    }, child: Consumer<ComposeController>(builder: (context, controller, _) {
      return PlatformScaffold(
          appBar: FlatAppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(kPrimaryPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      CommunityIcon(image: controller.communityIcon),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                          context.l.composeCommunity(controller.communityName)),
                    ],
                  ),
                  const SizedBox(
                    height: kSecondaryPadding,
                  ),
                  PlatformTextField(
                    hintText: context.l.composeTitleHint,
                    controller: _titleController,
                  ),
                  const SizedBox(
                    height: kSecondaryPadding,
                  ),
                  if (_isUploadingImage || controller.uploadedImageUrl != null)
                    _buildImage(context, controller)
                  else ...[
                    if (controller.nonEditablePostBody != null)
                      Text(controller.nonEditablePostBody!)
                    else
                      PlatformTextField(
                        hintText: context.l.composeBodyHint,
                        controller: _bodyController,
                        minLines: 10,
                        maxLines: 10000,
                      ),
                    const SizedBox(
                      height: kSecondaryPadding,
                    ),
                    if (!controller.isEditing)
                      PlatformElevatedButton(
                        onPressed: () =>
                            _pickImage(controller, ImageSource.gallery),
                        child: Text(context.l.composeSelectImageButton),
                      ),
                  ],
                  if (_isSaving)
                    Center(
                      child: PlatformCircularProgressIndicator(),
                    )
                  else
                    PlatformElevatedButton(
                      onPressed: () => _post(context, controller),
                      child: Text(controller.isEditing
                          ? context.l.composeEditButton
                          : context.l.composePostButton),
                    ),
                  const SizedBox(
                    height: kSecondaryPadding,
                  ),
                  Text(
                    context.l.composeMarkdownCheatsheet,
                    style: theme.textTheme.bodyMedium!.copyWith(height: 2.0),
                  )
                ],
              ),
            ),
          ));
    }));
  }
}
