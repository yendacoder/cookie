import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_glass_widgets/widgets/shared/glass_page.dart';

import '../../providers/platform_style_provider.dart';

class AdaptiveScaffold extends ConsumerWidget {
  const AdaptiveScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.extendBody = false,
    this.extendBodyBehindAppBar,
    this.resizeToAvoidBottomInset,
  });

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool extendBody;

  // When null, defaults to true on iOS whenever an appBar is present.
  // Pass true explicitly to force the behaviour on all platforms.
  final bool? extendBodyBehindAppBar;
  final bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffold = Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar ?? false,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
    if (context.useIos) {
      return GlassPage(child: scaffold);
    }
    return scaffold;
  }
}
