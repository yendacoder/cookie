import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/providers/platform_style_provider.dart';
import 'package:cookie/core/utils/image_downloader.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_app_bar.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_dialog.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_progress_indicator.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_scaffold.dart';
import 'package:cookie/models/discuit_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

/// Navigation argument bag — passed as `extra` to the `/image-viewer` route.
class ImageViewerArgs {
  const ImageViewerArgs({required this.images, required this.initialIndex});

  final List<DiscuitImage> images;
  final int initialIndex;
}

class ImageViewerScreen extends StatefulWidget {
  const ImageViewerScreen({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  final List<DiscuitImage> images;
  final int initialIndex;

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  late final PageController _pageController;
  late int _currentPage;

  // When any page is zoomed in, disable PageView swiping so pan and swipe
  // gestures don't conflict.
  bool _isAnyPageZoomed = false;
  bool _isSaving = false;
  bool _isSharing = false;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialIndex;
    final count = widget.images.length;
    _pageController = PageController(
      initialPage: count > 1 ? count * 100 + widget.initialIndex : 0,
    );
  }

  void _save(String url) async {
    setState(() {
      _isSaving = true;
    });
    await ImageDownloader().downloadWithSaveDialog(url);
    if (mounted) {
      setState(() {
        _isSaving = false;
      });
    }
  }

  void _share(String url) async {
    setState(() {
      _isSharing = true;
    });
    await ImageDownloader().share(url);
    if (mounted) {
      setState(() {
        _isSharing = false;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.images.length;
    final hasAltText = widget.images[_currentPage].altText?.isNotEmpty == true;
    return AdaptiveScaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AdaptiveAppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        actions: [
          IconButton(
            icon: Icon(
              Icons.text_snippet_rounded,
              color: hasAltText ? null : Colors.white.withValues(alpha: 0.5),
            ),
            tooltip: context.l10n.imageViewerAltText,
            onPressed: hasAltText
                ? () {
                    showPlatformDialog<void>(
                      context: context,
                      builder: (ctx) => AdaptiveAlertDialog(
                        title: Text(context.l10n.imageViewerAltText),
                        content: Text(
                          widget.images[_currentPage].altText ?? '',
                        ),
                        actions: [
                          AdaptiveDialogAction(
                            isDefault: true,
                            onPressed: () => ctx.pop(false),
                            child: Text(context.l10n.okayButton),
                          ),
                        ],
                      ),
                    );
                  }
                : null,
          ),
          IconButton(
            icon: _isSharing
                ? SizedBox.square(
              dimension: 16,
              child: AdaptiveProgressIndicator(strokeWidth: 1.5),
            )
                : Icon(context.shareIcon),
            tooltip: context.l10n.imageViewerShare,
            onPressed: _isSharing
                ? null
                : () => _share(widget.images[_currentPage].fullUrl),
          ),
          IconButton(
            icon: _isSaving
                ? SizedBox.square(
                    dimension: 16,
                    child: AdaptiveProgressIndicator(strokeWidth: 1.5),
                  )
                : const Icon(Icons.save),
            tooltip: context.l10n.imageViewerSave,
            onPressed: _isSaving
                ? null
                : () => _save(widget.images[_currentPage].fullUrl),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            physics: _isAnyPageZoomed
                ? const NeverScrollableScrollPhysics()
                : const BouncingScrollPhysics(),
            itemCount: count > 1 ? count * 200 : 1,
            onPageChanged: (i) => setState(() {
              _currentPage = i % count;
              // Reset zoom flag when the user swipes to a new page.
              _isAnyPageZoomed = false;
            }),
            itemBuilder: (_, i) => _ZoomablePage(
              image: widget.images[i % count],
              onZoomChanged: (zoomed) {
                if (zoomed != _isAnyPageZoomed) {
                  setState(() => _isAnyPageZoomed = zoomed);
                }
              },
            ),
          ),
          // Caption and/or page indicator at the bottom.
          Builder(
            builder: (context) {
              if (count < 2) return const SizedBox.shrink();
              return Positioned(
                bottom: MediaQuery.paddingOf(context).bottom + 16,
                left: 24,
                right: 24,
                child: _PageIndicator(current: _currentPage, count: count),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ── Zoomable page ─────────────────────────────────────────────────────────────

class _ZoomablePage extends StatefulWidget {
  const _ZoomablePage({required this.image, required this.onZoomChanged});

  final DiscuitImage image;
  final ValueChanged<bool> onZoomChanged;

  @override
  State<_ZoomablePage> createState() => _ZoomablePageState();
}

class _ZoomablePageState extends State<_ZoomablePage>
    with SingleTickerProviderStateMixin {
  final _transformCtrl = TransformationController();
  late final AnimationController _animCtrl;
  Animation<Matrix4>? _animation;
  Offset? _doubleTapPosition;

  static const _zoomScale = 3.0;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    _transformCtrl.dispose();
    super.dispose();
  }

  bool get _isZoomed => _transformCtrl.value.getMaxScaleOnAxis() > 1.1;

  void _notifyZoom() => widget.onZoomChanged(_isZoomed);

  void _handleDoubleTap() {
    _animCtrl.reset();

    final target = _isZoomed
        ? Matrix4.identity()
        : _zoomedAt(_doubleTapPosition!);

    _animation =
        Matrix4Tween(begin: _transformCtrl.value, end: target).animate(
          CurvedAnimation(parent: _animCtrl, curve: Curves.easeInOut),
        )..addListener(() {
          _transformCtrl.value = _animation!.value;
          _notifyZoom();
          setState(() {}); // keep panEnabled in sync
        });

    _animCtrl.forward();
  }

  /// Returns a matrix that zooms _zoomScale× centred on [pos].
  ///
  /// Derivation: zoom around focal point (px, py) =
  ///   translate(px, py) · scale(s) · translate(-px, -py)
  /// which simplifies to a matrix with scale s on the diagonal and
  /// translation (px·(1-s), py·(1-s)).
  Matrix4 _zoomedAt(Offset pos) {
    const s = _zoomScale;
    return Matrix4.identity()
      ..setEntry(0, 0, s) // scale x
      ..setEntry(1, 1, s) // scale y
      ..setEntry(0, 3, pos.dx * (1 - s)) // translate x
      ..setEntry(1, 3, pos.dy * (1 - s)); // translate y
  }

  void _onInteractionUpdate(ScaleUpdateDetails _) {
    _notifyZoom();
    setState(() {});
  }

  void _onInteractionEnd(ScaleEndDetails _) {
    _notifyZoom();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: (d) => _doubleTapPosition = d.localPosition,
      onDoubleTap: _handleDoubleTap,
      child: InteractiveViewer(
        transformationController: _transformCtrl,
        // Disable pan at scale 1 so horizontal drags reach the PageView.
        // Enable it when zoomed so the user can explore the image.
        panEnabled: _isZoomed,
        minScale: 0.9,
        maxScale: 6.0,
        onInteractionUpdate: _onInteractionUpdate,
        onInteractionEnd: _onInteractionEnd,
        child: Center(
          child: CachedNetworkImage(
            imageUrl: widget.image.fullUrl,
            fit: BoxFit.contain,
            placeholder: (_, _) => const Center(
              child: AdaptiveProgressIndicator(color: Colors.white54),
            ),
            errorWidget: (_, _, _) => const Center(
              child: Icon(
                Icons.broken_image_outlined,
                color: Colors.white54,
                size: 56,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Page indicator ────────────────────────────────────────────────────────────

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({required this.current, required this.count});

  final int current;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: i == current ? 16 : 6,
            height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: i == current
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
      ],
    );
  }
}
