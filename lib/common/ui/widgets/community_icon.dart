import 'package:cookie/api/model/image.dart' as api_img;
import 'package:cookie/settings/app_config.dart';
import 'package:cookie/settings/consts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommunityIcon extends StatelessWidget {
  const CommunityIcon({super.key, required this.image});

  final api_img.Image? image;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: kCommunityIconSize,
        height: kCommunityIconSize,
        child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: AppConfigProvider.of(context).getFullImageUrl(image?.url ?? '/favicon.png')),
      ),
    );
  }
}
