import 'package:flutter/material.dart';

class AppBarDivider extends StatelessWidget implements PreferredSizeWidget {
  const AppBarDivider({Key? key, this.opacity}) : super(key: key);

  final double? opacity;

  @override
  Widget build(BuildContext context) {
    return Divider(
        height: 1.0,
        thickness: 1.0,
        color: Theme.of(context)
            .appBarTheme
            .backgroundColor
            ?.withOpacity(opacity ?? 1.0));
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 1.0);
}
