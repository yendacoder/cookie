import 'package:flutter/material.dart';

import '../../../core/extensions/build_context_ext.dart';
import '../../auth/widgets/auth_gate.dart';

class ListsScreen extends StatelessWidget {
  const ListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.listsScreenTitle),
      ),
      body: const AuthGate(
        child: Center(
          child: Text('Lists — coming soon'),
        ),
      ),
    );
  }
}
