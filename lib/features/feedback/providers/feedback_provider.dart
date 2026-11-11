import 'dart:io' show Platform;

import 'package:cookie/core/providers/app_flavor_provider.dart';
import 'package:cookie/features/shell/providers/package_info_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Build-time feedback configuration, supplied via `--dart-define` (or
/// `--dart-define-from-file`) so forks don't inherit the maintainer's inbox.
/// Without [endpoint] the feedback feature is hidden.
class FeedbackConfig {
  const FeedbackConfig({
    required this.endpoint,
    this.appId = 'cookie',
    this.supportEmail = '',
  });

  /// URL of a feedback API compatible with the k7a.me feedback worker.
  final String endpoint;

  /// App identifier sent to the API, which must be known to the server.
  final String appId;

  /// Optional address shown as an email fallback; empty hides it.
  final String supportEmail;

  static const _endpoint = String.fromEnvironment('FEEDBACK_ENDPOINT');

  static const FeedbackConfig? fromEnvironment = _endpoint == ''
      ? null
      : FeedbackConfig(
          endpoint: _endpoint,
          appId: String.fromEnvironment(
            'FEEDBACK_APP_ID',
            defaultValue: 'cookie',
          ),
          supportEmail: String.fromEnvironment('SUPPORT_EMAIL'),
        );
}

/// `null` when feedback isn't configured for this build.
final feedbackConfigProvider = Provider<FeedbackConfig?>(
  (_) => FeedbackConfig.fromEnvironment,
);

/// Server-side limits, mirrored so the UI can enforce them up front.
const feedbackMessageMaxLength = 5000;
const _metaValueMaxLength = 200;

final _emailRegExp = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

bool isValidFeedbackEmail(String email) =>
    email.length <= 254 && _emailRegExp.hasMatch(email);

/// Values must match the categories accepted by the feedback API.
enum FeedbackCategory { bug, suggestion, content, other }

enum FeedbackFailure { rateLimited, failed }

class FeedbackException implements Exception {
  const FeedbackException(this.failure);

  final FeedbackFailure failure;

  @override
  String toString() => 'FeedbackException($failure)';
}

/// Plain Dio without the Discuit base URL, cookies or CSRF interceptors.
final feedbackClientProvider = Provider<Dio>(
  (_) => Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      contentType: 'application/json',
    ),
  ),
);

/// App and device details optionally attached to feedback.
final feedbackDiagnosticsProvider = Provider<Map<String, String>>((ref) {
  final packageInfo = ref.watch(packageInfoProvider);
  return {
    'version': packageInfo.version,
    'build': packageInfo.buildNumber,
    'flavor': ref.watch(appFlavorProvider).name,
    'os': Platform.operatingSystem,
    'osVersion': Platform.operatingSystemVersion,
  };
});

/// Only read when [feedbackConfigProvider] is non-null (the UI is hidden
/// otherwise).
final feedbackServiceProvider = Provider<FeedbackService>((ref) {
  final config = ref.watch(feedbackConfigProvider);
  if (config == null) {
    throw StateError('Feedback is not configured for this build');
  }
  return FeedbackService(
    ref.watch(feedbackClientProvider),
    config,
    ref.watch(feedbackDiagnosticsProvider),
  );
});

Map<String, dynamic> buildFeedbackPayload({
  required String appId,
  required FeedbackCategory category,
  required String message,
  String? email,
  Map<String, String>? diagnostics,
}) {
  final trimmedEmail = email?.trim() ?? '';
  return {
    'app': appId,
    'category': category.name,
    'message': message.trim(),
    if (trimmedEmail.isNotEmpty) 'email': trimmedEmail,
    if (diagnostics != null && diagnostics.isNotEmpty)
      'meta': {
        for (final MapEntry(:key, :value) in diagnostics.entries)
          key: value.length > _metaValueMaxLength
              ? value.substring(0, _metaValueMaxLength)
              : value,
      },
  };
}

class FeedbackService {
  const FeedbackService(this._dio, this._config, this.diagnostics);

  final Dio _dio;
  final FeedbackConfig _config;
  final Map<String, String> diagnostics;

  /// Throws [FeedbackException] if the feedback could not be delivered.
  Future<void> send({
    required FeedbackCategory category,
    required String message,
    String? email,
    bool includeDiagnostics = true,
  }) async {
    try {
      await _dio.post<dynamic>(
        _config.endpoint,
        data: buildFeedbackPayload(
          appId: _config.appId,
          category: category,
          message: message,
          email: email,
          diagnostics: includeDiagnostics ? diagnostics : null,
        ),
      );
    } on DioException catch (e) {
      throw FeedbackException(
        e.response?.statusCode == 429 ? .rateLimited : .failed,
      );
    }
  }
}
