import 'package:cookie/api/api_error.dart';
import 'package:cookie/common/util/context_util.dart';
import 'package:cookie/settings/consts.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

void _showFlash(BuildContext context, String message, bool isError) {
  final isMaterial = Theme.of(context).platform != TargetPlatform.iOS;
  final theme = Theme.of(context);
  showFlash(
    context: context,
    duration: const Duration(seconds: 4),
    builder: (context, controller) {
      return FlashBar(
        position: FlashPosition.bottom,
        dismissDirections: const [
          FlashDismissDirection.endToStart,
          FlashDismissDirection.startToEnd
        ],
        controller: controller,
        behavior: FlashBehavior.fixed,
        backgroundColor: isError
            ? Color.alphaBlend(theme.colorScheme.error.withOpacity(0.2),
                theme.colorScheme.surface)
            : theme.colorScheme.surface,
        margin: isMaterial
            ? const EdgeInsets.all(kPrimaryPadding)
            : EdgeInsets.zero,
        shape: isMaterial
            ? const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(kDefaultCornerRadius)))
            : null,
        content: Text(
          message,
          style: theme.textTheme.bodyLarge,
        ),
      );
    },
  );
}

void showNotification(BuildContext context, String? message) {
  if (message != null) {
    _showFlash(context, message, false);
  }
}

void showErrorMessage(BuildContext context, String message) {
  _showFlash(context, message, true);
}

String getApiErrorMessage(BuildContext context, Object? error) {
  if (error is ApiError) {
    switch (error.errorType) {
      case ApiErrorType.api:
        {
          return context.l.apiError(error.message ?? '');
        }
      case ApiErrorType.parse:
        {
          return context.l.parseError;
        }
      case ApiErrorType.server:
        {
          return context.l.serverError;
        }
      case ApiErrorType.network:
        {
          return context.l.networkError;
        }
      default:
        {
          return context.l.unknownError;
        }
    }
  } else {
    return context.l.unknownError;
  }
}

void showApiErrorMessage(BuildContext context, Object? error) {
  showErrorMessage(context, getApiErrorMessage(context, error));
}
