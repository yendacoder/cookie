import 'package:auto_route/auto_route.dart';
import 'package:cookie/common/ui/widgets/common/app_bar_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class FlatAppBar extends PlatformAppBar {
  FlatAppBar({
    Key? key,
    Key? widgetKey,
    Color backgroundColor = Colors.transparent,
    Color? foregroundColor,
    Widget? leading,
    List<Widget>? trailingActions,
    bool? automaticallyImplyLeading,
    this.text,
    double? opacity,
    bool withDivider = false,
    bool withBack = true,
  }) : super(
    key: key,
    widgetKey: widgetKey,
    leading: leading,
    trailingActions: trailingActions,
    automaticallyImplyLeading: automaticallyImplyLeading,
    cupertino: (context, __) => CupertinoNavigationBarData(
        backgroundColor:
        _getBackgroundColor(context, backgroundColor, opacity),

        border: _buildBorderDivider(context, withDivider, opacity),
        title: _buildTitle(context, text, foregroundColor, opacity),
        leading: withBack
            ? CupertinoNavigationBarBackButton(
          color: foregroundColor ??
              Theme.of(context).colorScheme.onBackground,
          onPressed: () => context.router.pop(),
        )
            : const SizedBox.shrink()),
    material: (context, __) => MaterialAppBarData(
      backgroundColor:
      _getBackgroundColor(context, backgroundColor, opacity),
      bottom: withDivider ? AppBarDivider(opacity: opacity) : null,
      leading: withBack
          ? BackButton(
        color: foregroundColor ??
            Theme.of(context).colorScheme.onBackground,
        onPressed: () => context.router.pop(),
      )
          : const SizedBox.shrink(),
      title: _buildTitle(context, text, foregroundColor, opacity),
    ),
  );

  final String? text;

  static Color _getBackgroundColor(
      BuildContext context, Color? customColor, double? opacity) {
    final color = customColor ?? Theme.of(context).colorScheme.background;
    if (opacity != null) {
      return color.withOpacity(opacity);
    }
    return color;
  }

  static Widget? _buildTitle(BuildContext context, String? text,
      Color? foregroundColor, double? opacity) {
    if (text == null) {
      return null;
    }
    final titleWidget = Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: foregroundColor ?? Theme.of(context).colorScheme.onBackground),
    );
    return opacity == null
        ? titleWidget
        : Opacity(
      opacity: opacity,
      child: titleWidget,
    );
  }

  static Border? _buildBorderDivider(
      BuildContext context, bool withDivider, double? opacity) {
    if (!withDivider) {
      return null;
    }
    return Border(
        bottom: BorderSide(
            color: Theme.of(context)
                .appBarTheme
                .backgroundColor!
                .withOpacity(opacity ?? 1.0)));
  }
}
