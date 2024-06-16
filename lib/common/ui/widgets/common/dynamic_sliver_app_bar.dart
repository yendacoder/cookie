import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Sliver app bar that measures its height based on the content
/// by https://medium.com/@eichmueller.christian
/// https://medium.com/@eichmueller.christian/dynamic-height-sliver-app-bar-flutter-b46fbfff91f4
class DynamicSliverAppBar extends StatefulWidget {
  const DynamicSliverAppBar({
    this.flexibleSpace,
    super.key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.bottom,
    this.elevation,
    this.scrolledUnderElevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.forceElevated = false,
    this.backgroundColor,
    this.backgroundGradient,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.centerTitle,
    this.excludeHeaderSemantics = false,
    this.titleSpacing,
    this.collapsedHeight,
    this.expandedHeight,
    this.floating = false,
    this.pinned = false,
    this.snap = false,
    this.stretch = false,
    this.stretchTriggerOffset = 100.0,
    this.onStretchTrigger,
    this.shape,
    this.toolbarHeight = kToolbarHeight + 20,
    this.leadingWidth,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.systemOverlayStyle,
    this.forceMaterialTransparency = false,
    this.clipBehavior,
    this.appBarClipper,
  });

  final Widget? flexibleSpace;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final double? elevation;
  final double? scrolledUnderElevation;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final bool forceElevated;
  final Color? backgroundColor;

  /// If backgroundGradient is non null, backgroundColor will be ignored
  final LinearGradient? backgroundGradient;
  final Color? foregroundColor;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final bool primary;
  final bool? centerTitle;
  final bool excludeHeaderSemantics;
  final double? titleSpacing;
  final double? expandedHeight;
  final double? collapsedHeight;
  final bool floating;
  final bool pinned;
  final ShapeBorder? shape;
  final double toolbarHeight;
  final double? leadingWidth;
  final TextStyle? toolbarTextStyle;
  final TextStyle? titleTextStyle;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final bool forceMaterialTransparency;
  final Clip? clipBehavior;
  final bool snap;
  final bool stretch;
  final double stretchTriggerOffset;
  final AsyncCallback? onStretchTrigger;
  final CustomClipper<Path>? appBarClipper;

  @override
  State createState() => _DynamicSliverAppBarState();
}

class _DynamicSliverAppBarState extends State<DynamicSliverAppBar> {
  final GlobalKey _childKey = GlobalKey();

  // As long as the height is 0 instead of the sliver app bar a sliver to box adapter will be used
  // to calculate dynamically the size for the sliver app bar
  double _height = 0;

  @override
  void initState() {
    super.initState();
    _updateHeight();
  }

  @override
  void didUpdateWidget(covariant DynamicSliverAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateHeight();
  }

  void _updateHeight() {
    // Gets the new height and updates the sliver app bar. Needs to be called after the last frame has been rebuild
    // otherwise this will throw an error
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_childKey.currentContext == null ||
          !(_childKey.currentContext!.findRenderObject()! as RenderBox).hasSize)
        return;
      setState(() {
        _height = (_childKey.currentContext!.findRenderObject()! as RenderBox)
            .size
            .height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //Needed to lay out the flexibleSpace the first time, so we can calculate its intrinsic height
    if (_height == 0) {
      return SliverToBoxAdapter(
        child: Stack(
          children: [
            Padding(
              // Padding which centers the flexible space within the app bar
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.paddingOf(context).top / 2),
              child: Container(
                  key: _childKey,
                  child: widget.flexibleSpace ??
                      const SizedBox(height: kToolbarHeight)),
            ),
            Positioned.fill(
              // 10 is the magic number which the app bar is pushed down within the sliver app bar. Couldnt find exactly where this number
              // comes from and found it through trial and error.
              top: 10,
              child: Align(
                alignment: Alignment.topCenter,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: widget.leading,
                  actions: widget.actions,
                ),
              ),
            )
          ],
        ),
      );
    }

    return SliverAppBar(
      leading: widget.leading,
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
      title: widget.title,
      actions: widget.actions,
      bottom: widget.bottom,
      elevation: widget.elevation,
      scrolledUnderElevation: widget.scrolledUnderElevation,
      shadowColor: widget.shadowColor,
      surfaceTintColor: widget.surfaceTintColor,
      forceElevated: widget.forceElevated,
      backgroundColor: widget.backgroundColor,
      foregroundColor: widget.foregroundColor,
      iconTheme: widget.iconTheme,
      actionsIconTheme: widget.actionsIconTheme,
      primary: widget.primary,
      centerTitle: widget.centerTitle,
      excludeHeaderSemantics: widget.excludeHeaderSemantics,
      titleSpacing: widget.titleSpacing,
      collapsedHeight: widget.collapsedHeight,
      floating: widget.floating,
      pinned: widget.pinned,
      snap: widget.snap,
      stretch: widget.stretch,
      stretchTriggerOffset: widget.stretchTriggerOffset,
      onStretchTrigger: widget.onStretchTrigger,
      shape: widget.shape,
      toolbarHeight: widget.toolbarHeight,
      expandedHeight: _height,
      leadingWidth: widget.leadingWidth,
      toolbarTextStyle: widget.toolbarTextStyle,
      titleTextStyle: widget.titleTextStyle,
      systemOverlayStyle: widget.systemOverlayStyle,
      forceMaterialTransparency: widget.forceMaterialTransparency,
      clipBehavior: widget.clipBehavior,
      flexibleSpace: FlexibleSpaceBar(background: widget.flexibleSpace),
    );
  }
}
