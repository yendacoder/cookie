import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/providers/auth_provider.dart';

class PostButton extends ConsumerWidget {
  const PostButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(authProvider).value != null;
    if (!isAuthenticated) {
      return const SizedBox.shrink();
    }
    return FilledButton(
      onPressed: () => context.push('/compose'),
      style: FilledButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
      child: Row(
        mainAxisSize: .min,
        children: [
          Icon(Icons.edit),
          SizedBox(width: 12),
          Text(context.l10n.navPost),
        ],
      ),
    );
  }
}
