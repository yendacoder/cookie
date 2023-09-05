import 'package:cookie/common/ui/widgets/settings_image.dart';
import 'package:cookie/settings/consts.dart';
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
              : SettingsImage(
                  fit: BoxFit.cover,
                  isRelativeUrl: false,
                  url:
                      'https://api.dicebear.com/6.x/initials/png?seed=$username&size=$imageSize')),
    );
  }
}
