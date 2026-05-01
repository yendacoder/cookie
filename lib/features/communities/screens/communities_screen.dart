import 'package:flutter/material.dart';

import '../../../core/extensions/build_context_ext.dart';

class CommunitiesScreen extends StatelessWidget {
  const CommunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.communitiesScreenTitle),
      ),
      body: const Center(
        child: Text('Communities — coming soon'),
      ),
    );
  }
}
