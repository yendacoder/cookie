import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_button.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_progress_indicator.dart';
import 'package:cookie/core/widgets/error_view.dart';
import 'package:cookie/features/auth/providers/auth_provider.dart';

/// Wraps [child] and shows a sign-in prompt when the user is not authenticated.
/// Shows a typed [ErrorView] with a retry option for genuine errors.
/// Uses context.push('/login') so the back button returns to this screen.
class AuthGate extends ConsumerWidget {
  const AuthGate({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    return auth.when(
      loading: () => const Center(child: AdaptiveProgressIndicator()),
      error: (error, _) =>
          ErrorView(error: error, onRetry: () => ref.invalidate(authProvider)),
      data: (user) {
        if (user == null) return const _SignInPrompt();
        return child;
      },
    );
  }
}

class _SignInPrompt extends StatelessWidget {
  const _SignInPrompt();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lock_outline_rounded,
              size: 56,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 20),
            Text(
              context.l10n.errorAuthRequired,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.errorAuthRequiredBody,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            AdaptiveFilledButton(
              onPressed: () => context.push('/login'),
              icon: const Icon(Icons.login),
              child: Text(context.l10n.signInButton),
            ),
          ],
        ),
      ),
    );
  }
}
