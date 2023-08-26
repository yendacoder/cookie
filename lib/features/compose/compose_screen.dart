import 'package:auto_route/auto_route.dart';
import 'package:cookie/common/ui/widgets/common/flat_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

@RoutePage()
class ComposeScreen extends StatefulWidget {
  const ComposeScreen({super.key});

  @override
  State<ComposeScreen> createState() => _ComposeScreenState();
}

class _ComposeScreenState extends State<ComposeScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: FlatAppBar(),
      body: const Center(
        child: Text('Make a new post'),
      )
    );
  }
}
