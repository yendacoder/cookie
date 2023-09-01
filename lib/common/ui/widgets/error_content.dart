import 'package:cookie/common/ui/notifications.dart';
import 'package:cookie/common/util/context_util.dart';
import 'package:cookie/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ErrorContent extends StatelessWidget {
  const ErrorContent({super.key, required this.error, this.retry});

  final Object error;
  final VoidCallback? retry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(kPrimaryPaddingDouble),
        child: Column(
          children: [
            Text(
              context.l.errorContentTitle,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(
              height: kPrimaryPadding,
            ),
            Text(
              getApiErrorMessage(context, error),
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(
              height: kPrimaryPadding,
            ),
            if (retry != null)
              SizedBox(
                width: double.infinity,
                child: PlatformElevatedButton(
                  onPressed: retry,
                  child: Text(context.l.errorRetry),
                ),
              ),
          ],
        ));
  }
}
