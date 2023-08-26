import 'package:cookie/common/ui/notifications.dart';
import 'package:cookie/common/util/context_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ErrorContent extends StatelessWidget {
  const ErrorContent({super.key, required this.error, this.retry});

  final Object error;
  final VoidCallback? retry;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text(context.l.errorContentTitle),
        Text(getApiErrorMessage(context, error)),
        if (retry != null)
          PlatformElevatedButton(
            onPressed: retry,
            child: Text(context.l.errorRetry),
          ),
      ],
    ));
  }
}
