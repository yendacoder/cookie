import 'package:cookie/core/providers/app_flavor_provider.dart';
import 'package:cookie/features/shell/providers/package_info_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateInfo {
  const UpdateInfo({required this.version, required this.downloadUrl});

  final String version;
  final String downloadUrl;
}

final updateCheckProvider = FutureProvider<UpdateInfo?>((ref) async {
  final flavor = ref.watch(appFlavorProvider);
  if (flavor != .github) return null;

  final packageInfo = ref.watch(packageInfoProvider);
  final currentVersion = packageInfo.version.split('+').first;

  try {
    final dio = Dio();
    final response = await dio.get<Map<String, dynamic>>(
      'https://api.github.com/repos/yendacoder/cookie/releases/latest',
      options: Options(
        headers: {'Accept': 'application/vnd.github.v3+json'},
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    final data = response.data;
    if (data == null) return null;

    final tagName = data['tag_name'] as String?;
    if (tagName == null) return null;

    final latestVersion =
        tagName.startsWith('v') ? tagName.substring(1) : tagName;
    if (!_isNewer(latestVersion, currentVersion)) return null;

    final assets =
        (data['assets'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final apkAsset = assets.firstWhere(
      (a) => (a['name'] as String? ?? '').endsWith('.apk'),
      orElse: () => {},
    );

    final downloadUrl = apkAsset['browser_download_url'] as String?;
    if (downloadUrl == null) return null;

    return UpdateInfo(version: latestVersion, downloadUrl: downloadUrl);
  } catch (_) {
    return null;
  }
});

bool _isNewer(String latest, String current) {
  final lParts = latest.split('.').map(int.tryParse).whereType<int>().toList();
  final cParts = current.split('.').map(int.tryParse).whereType<int>().toList();
  for (var i = 0; i < lParts.length; i++) {
    if (i >= cParts.length) return true;
    if (lParts[i] > cParts[i]) return true;
    if (lParts[i] < cParts[i]) return false;
  }
  return false;
}
