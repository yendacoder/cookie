import 'package:flutter/material.dart';

import 'adaptive/adaptive_app_bar.dart';
import 'post_button.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AdaptiveAppBar(
      title: Text(title),
      actions: [PostButton()],
      actionsPadding: const EdgeInsets.all(8),
    );
  }
}

class DefaultSliverAppBar extends StatelessWidget {
  const DefaultSliverAppBar({super.key, required this.title, this.pinned = true});

  final String title;
  final bool pinned;

  @override
  Widget build(BuildContext context) {
    return AdaptiveSliverAppBar(
      title: Text(title),
      actions: [PostButton()],
      actionsPadding: const EdgeInsets.all(8),
      pinned: pinned,
    );
  }
}
