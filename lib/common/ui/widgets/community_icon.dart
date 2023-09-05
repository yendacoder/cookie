import 'package:cookie/api/model/image.dart' as api_img;
import 'package:cookie/common/ui/widgets/settings_image.dart';
import 'package:cookie/settings/consts.dart';
import 'package:flutter/material.dart';

class CommunityIcon extends StatelessWidget {
  const CommunityIcon(
      {super.key, required this.image, this.size = kCommunityIconSize});

  final api_img.Image? image;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: SettingsImage(
            fit: BoxFit.cover,
            url: image?.url ?? '/favicon.png'),
      ),
    );
  }
}
