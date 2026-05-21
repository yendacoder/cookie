import 'package:flutter/material.dart';

import 'post_button.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({super.key, required this.title});

  @override
  get preferredSize => Size.fromHeight(kToolbarHeight);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [PostButton()],
      actionsPadding: const EdgeInsets.all(8),
    );
  }
}

class DefaultSliverAppBar extends StatelessWidget {
  const DefaultSliverAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(title),
      actions: [PostButton()],
      actionsPadding: const EdgeInsets.all(8),
      floating: true,
      snap: true,
    );
  }
}
