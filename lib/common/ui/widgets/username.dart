import 'package:cookie/common/ui/widgets/user_image.dart';
import 'package:flutter/material.dart';

class Username extends StatelessWidget {
  const Username({super.key, required this.username, this.isDeleted = false});

  final String username;
  final bool isDeleted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        UserImage(
          username: username,
          isDeleted: isDeleted,
        ),
        const SizedBox(
          width: 6.0,
        ),
        Flexible(
            child: Text(
          username,
          style: isDeleted
              ? theme.textTheme.bodyMedium!.copyWith(color: theme.hintColor)
              : theme.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.fade,
        )),
      ],
    );
  }
}
