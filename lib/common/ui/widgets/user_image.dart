import 'package:cookie/common/ui/widgets/settings_image.dart';
import 'package:cookie/api/model/image.dart' as api;
import 'package:cookie/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserImage extends StatelessWidget {
  const UserImage(
      {super.key,
      required this.username,
      required this.userImage,
      this.size = kUserIconSize,
      this.isDeleted = false});

  final api.Image? userImage;
  final String username;
  final double size;
  final bool isDeleted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    final imageSize = size * mq.devicePixelRatio;
    return ClipOval(
      child: SizedBox(
          width: size,
          height: size,
          child: isDeleted
              ? ColoredBox(color: theme.colorScheme.surface)
              : (userImage != null
                  ? SettingsImage(
                      fit: BoxFit.cover,
                      url: userImage!.getBestMatchingUrl(
                          targetWidth: imageSize, targetHeight: imageSize))
                  : SvgPicture.network(
                      'https://api.dicebear.com/6.x/initials/svg?radius=50&scale=80&seed=$username'))),
    );
  }
}
