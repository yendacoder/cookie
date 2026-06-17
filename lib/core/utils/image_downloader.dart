import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_saver/file_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ImageDownloader {
  final _dio = Dio();

  Future<void> downloadWithSaveDialog(String url) async {
    // Extract filename from URL, e.g. "photo.jpg"
    final uri = Uri.parse(url);
    final fileName = uri.pathSegments.last;
    final ext = fileName.contains('.')
        ? fileName.split('.').last.toLowerCase()
        : '';
    // Fetch bytes with Dio
    final response = await _dio.get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes),
    );

    await FileSaver.instance.saveAs(
      name: fileName.contains('.')
          ? fileName.substring(0, fileName.lastIndexOf('.'))
          : fileName,
      bytes: Uint8List.fromList(response.data!),
      fileExtension: ext,
      mimeType: _mimeTypeFromExtension(ext),
    );
  }

  /// Downloads image bytes to a temp file and returns the path.
  Future<String> _downloadToTemp(String url) async {
    final dir = await getTemporaryDirectory();
    final fileName = url.split('/').last.split('?').first; // strip query params
    final filePath = '${dir.path}/$fileName';

    await _dio.download(
      url,
      filePath,
      options: Options(responseType: ResponseType.bytes),
    );
    return filePath;
  }

  /// Opens the native OS share sheet — user picks where to save.
  Future<void> share(String url, {String? subject}) async {
    final filePath = await _downloadToTemp(url);
    await SharePlus.instance.share(
      ShareParams(files: [XFile(filePath)], subject: subject ?? 'Image'),
    );
  }

  /// Guesses mime type from extension. A little overkill since
  /// for time being Discuit saves everything in jpeg, but we
  /// want to be future-proof.
  MimeType _mimeTypeFromExtension(String ext) {
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return MimeType.jpeg;
      case 'png':
        return MimeType.png;
      case 'gif':
        return MimeType.gif;
      case 'webp':
        return MimeType.webp;
      case 'bmp':
        return MimeType.bmp;
      case 'svg':
        return MimeType.svg;
      default:
        return MimeType.other;
    }
  }
}
