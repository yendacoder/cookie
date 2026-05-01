import 'package:flutter/material.dart';

import '../../../core/extensions/build_context_ext.dart';
import '../../auth/widgets/auth_gate.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.subscriptionsScreenTitle),
      ),
      body: const AuthGate(
        child: Center(
          child: Text('Subscriptions feed — coming soon'),
        ),
      ),
    );
  }
}
