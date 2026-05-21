import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Initialized before [runApp] and injected via ProviderScope overrides.
/// See main.dart.
final packageInfoProvider = Provider<PackageInfo>(
  (_) => throw UnimplementedError(
    'packageInfoProvider must be overridden in ProviderScope',
  ),
);
