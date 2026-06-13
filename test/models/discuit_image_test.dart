import 'package:cookie/models/discuit_image.dart';
import 'package:flutter/material.dart' show Color;
import 'package:flutter_test/flutter_test.dart';

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

DiscuitImage _image({
  String? averageColor,
  String url = '/images/test.jpg',
  List<ImageCopy> copies = const [],
}) => DiscuitImage(
  id: 'img-1',
  format: 'jpeg',
  mimetype: 'image/jpeg',
  width: 800,
  height: 600,
  size: 12345,
  averageColor: averageColor,
  url: url,
  copies: copies,
);

ImageCopy _copy({required int width, String url = '/copy.jpg'}) => ImageCopy(
  width: width,
  height: (width * 0.75).round(),
  boxWidth: width,
  boxHeight: (width * 0.75).round(),
  objectFit: 'cover',
  format: 'jpeg',
  url: url,
);

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  group('DiscuitImageExt.averageColorValue', () {
    test('parses standard rgb() string', () {
      expect(
        _image(averageColor: 'rgb(255, 128, 0)').averageColorValue,
        const Color.fromRGBO(255, 128, 0, 1.0),
      );
    });

    test('parses rgb() string without spaces', () {
      expect(
        _image(averageColor: 'rgb(10,20,30)').averageColorValue,
        const Color.fromRGBO(10, 20, 30, 1.0),
      );
    });

    test('parses rgb() string with extra whitespace', () {
      expect(
        _image(averageColor: 'rgb( 0 , 0 , 0 )').averageColorValue,
        const Color.fromRGBO(0, 0, 0, 1.0),
      );
    });

    test('returns null when averageColor is null', () {
      expect(_image(averageColor: null).averageColorValue, isNull);
    });

    test('returns null for empty string', () {
      expect(_image(averageColor: '').averageColorValue, isNull);
    });

    test('returns null for unparseable format', () {
      expect(_image(averageColor: '#ff8800').averageColorValue, isNull);
      expect(_image(averageColor: 'red').averageColorValue, isNull);
    });
  });

  group('DiscuitImageExt.bestUrl', () {
    test('returns fullUrl when copies is empty', () {
      expect(
        _image(url: '/original.jpg', copies: []).bestUrl(100, 2.0),
        'https://discuit.org/original.jpg',
      );
    });

    test('selects smallest copy that covers the physical target', () {
      // targetWidth=150, dpr=2 → physicalTarget=300
      // Copies: 200, 400, 800 — smallest ≥ 300 is 400
      final img = _image(
        copies: [
          _copy(width: 200, url: '/200.jpg'),
          _copy(width: 400, url: '/400.jpg'),
          _copy(width: 800, url: '/800.jpg'),
        ],
      );
      expect(img.bestUrl(150, 2.0), 'https://discuit.org/400.jpg');
    });

    test('falls back to fullUrl when all copies are too small', () {
      final img = _image(
        url: '/original.jpg',
        copies: [
          _copy(width: 50, url: '/50.jpg'),
          _copy(width: 100, url: '/100.jpg'),
        ],
      );
      // physicalTarget = 200*1.0 = 200; both copies < 200
      expect(img.bestUrl(200, 1.0), 'https://discuit.org/original.jpg');
    });

    test('preserves absolute URLs on main image', () {
      expect(
        _image(url: 'https://cdn.example.com/img.jpg').bestUrl(100, 1.0),
        'https://cdn.example.com/img.jpg',
      );
    });

    test('prepends discuit host to server-relative copy URL', () {
      final img = _image(copies: [_copy(width: 400, url: '/copies/img.jpg')]);
      expect(img.bestUrl(100, 1.0), 'https://discuit.org/copies/img.jpg');
    });

    test('preserves absolute URL on a copy', () {
      final img = _image(
        copies: [_copy(width: 400, url: 'https://cdn.example.com/400.jpg')],
      );
      expect(img.bestUrl(100, 1.0), 'https://cdn.example.com/400.jpg');
    });

    test('handles dpr=1 correctly', () {
      // physicalTarget = 100*1 = 100; smallest copy ≥ 100 is 200
      final img = _image(
        copies: [
          _copy(width: 50, url: '/50.jpg'),
          _copy(width: 200, url: '/200.jpg'),
        ],
      );
      expect(img.bestUrl(100, 1.0), 'https://discuit.org/200.jpg');
    });
  });
}
