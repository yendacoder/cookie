import 'package:flutter/material.dart';

import 'package:cookie/core/errors/app_exception.dart';
import 'package:cookie/core/extensions/build_context_ext.dart';

/// A full-area error display that classifies the error and shows an appropriate
/// title, description, and optional field path for parse failures.
class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final appError = AppException.from(error);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _icon(appError),
              size: 56,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              _title(context, appError),
              style: textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              _body(context, appError),
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (appError case ParseException(
              :final String offendingField?,
            )) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  context.l10n.errorParseField(offendingField),
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(context.l10n.retryButton),
            ),
          ],
        ),
      ),
    );
  }

  IconData _icon(AppException error) => switch (error) {
    NetworkException() => Icons.wifi_off_rounded,
    ParseException() => Icons.sync_problem_rounded,
    UnknownException() => Icons.error_outline_rounded,
  };

  String _title(BuildContext context, AppException error) => switch (error) {
    NetworkException() => context.l10n.errorNetworkTitle,
    ParseException() => context.l10n.errorParseTitle,
    UnknownException() => context.l10n.errorUnknownTitle,
  };

  String _body(BuildContext context, AppException error) => switch (error) {
    NetworkException() => context.l10n.errorNetworkBody,
    ParseException() => context.l10n.errorParseBody,
    UnknownException() => context.l10n.errorUnknownBody,
  };
}
