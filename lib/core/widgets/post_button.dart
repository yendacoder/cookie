import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_button.dart';
import 'package:cookie/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PostButton extends ConsumerWidget {
  const PostButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(authProvider).value != null;
    if (!isAuthenticated) return const SizedBox.shrink();

    Future<Object?> onTap() => context.push('/compose');

    // On iOS the compose action lives in the tab bar extra button — hide here.
    if (context.useIos) return const SizedBox.shrink();

    return AdaptiveFilledButton(
      onPressed: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: .min,
        children: [
          const Icon(Icons.edit),
          const SizedBox(width: 12),
          Text(context.l10n.navPost),
        ],
      ),
    );
  }
}
