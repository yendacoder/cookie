import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ImageDownloader {
  final _dio = Dio();

  /// Downloads image bytes to a temp file and returns the path.
  Future<String> _downloadToTemp(String url) async {
    final dir = await getTemporaryDirectory();
    final fileName = url.split('/').last.split('?').first; // strip query params
    final filePath = '${dir.path}/$fileName';

    await _dio.download(url, filePath,
        options: Options(responseType: ResponseType.bytes));
    return filePath;
  }

  /// Opens the native OS share sheet — user picks where to save.
  Future<void> shareOrSave(String url, {String? subject}) async {
    final filePath = await _downloadToTemp(url);
    await Share.shareXFiles(
      [XFile(filePath)],
      subject: subject ?? 'Image',
    );
  }
}