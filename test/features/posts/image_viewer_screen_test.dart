import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:cookie/features/posts/screens/image_viewer_screen.dart';
import 'package:cookie/l10n/app_localizations.dart';
import 'package:cookie/models/discuit_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _image = DiscuitImage(
  id: 'img1',
  format: 'jpeg',
  mimetype: 'image/jpeg',
  width: 100,
  height: 100,
  size: 1000,
  url: '/images/img1.jpeg',
);

Widget _wrap(Widget child) => ProviderScope(
  overrides: [platformStyleProvider.overrideWithValue(PlatformStyle.android)],
  child: MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: child,
  ),
);

double _scale(WidgetTester tester) => tester
    .widget<InteractiveViewer>(find.byType(InteractiveViewer))
    .transformationController!
    .value
    .getMaxScaleOnAxis();

Future<void> _doubleTap(WidgetTester tester) async {
  final center = tester.getCenter(find.byType(InteractiveViewer));
  await tester.tapAt(center);
  await tester.pump(const Duration(milliseconds: 50));
  await tester.tapAt(center);
  // Start the zoom animation, then let it finish. The loading spinner never
  // settles, so pump a fixed duration instead of settling.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  testWidgets('double tap toggles zoom in and back out', (tester) async {
    await tester.pumpWidget(
      _wrap(const ImageViewerScreen(images: [_image], initialIndex: 0)),
    );

    expect(_scale(tester), 1.0);

    await _doubleTap(tester);
    expect(_scale(tester), closeTo(3.0, 0.01));

    await _doubleTap(tester);
    expect(_scale(tester), closeTo(1.0, 0.01));

    // A third double tap zooms in again.
    await _doubleTap(tester);
    expect(_scale(tester), closeTo(3.0, 0.01));
  });
}
