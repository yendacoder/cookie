import 'package:cookie/settings/consts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  const UserImage(
      {super.key,
      required this.username,
      this.size = kUserIconSize,
      this.isDeleted = false});

  final String username;
  final double size;
  final bool isDeleted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    final imageSize = (size * mq.devicePixelRatio).toInt().clamp(16, 256);
    return ClipOval(
      child: SizedBox(
          width: size,
          height: size,
          child: isDeleted
              ? ColoredBox(color: theme.colorScheme.surface)
              : CachedNetworkImage(fit: BoxFit.cover,
                  imageUrl:
                      'https://api.dicebear.com/6.x/initials/png?seed=$username&size=$imageSize')),
    );
  }
}
