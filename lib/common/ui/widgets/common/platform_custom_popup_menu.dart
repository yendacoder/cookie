import 'package:cookie/common/ui/widgets/common/tappable_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class PlatformCustomPopupMenu extends StatefulWidget {
  const PlatformCustomPopupMenu({
    super.key,
    required this.options,
    required this.child,
    this.cupertino,
    this.material,
    this.manualTrigger = true,
  });

  final List<PopupMenuOption> options;
  final Widget child;
  final bool manualTrigger;
  final PlatformBuilder<CupertinoPopupMenuData>? cupertino;
  final PlatformBuilder<MaterialPopupMenuData>? material;

  @override
  State<StatefulWidget> createState() => PlatformCustomPopupMenuState();
}

class PlatformCustomPopupMenuState extends State<PlatformCustomPopupMenu> {
  @override
  Widget build(BuildContext context) {
    return TappableItem(
      child: widget.child,
      onTap: () => showButtonMenu(),
    );
  }

  Widget _cupertinoSheetContent(BuildContext context) {
    final data = widget.cupertino?.call(context, platform(context));
    final cancelData = data?.cancelButtonData;

    return CupertinoActionSheet(
      key: data?.key ?? widget.key,
      title: data?.title,
      message: data?.message,
      actionScrollController: data?.actionScrollController,
      messageScrollController: data?.messageScrollController,
      actions: data?.actions ??
          widget.options.map(
            (option) {
              final data = option.cupertino?.call(context, platform(context));
              return CupertinoActionSheetAction(
                key: data?.key,
                isDefaultAction: data?.isDefaultAction ?? false,
                isDestructiveAction: data?.isDestructiveAction ?? false,
                onPressed: data?.onPressed ??
                    () {
                      Navigator.pop(context);
                      option.onTap?.call(option);
                    },
                child: data?.child ?? Text(option.label ?? ''),
              );
            },
          ).toList(),
      cancelButton: cancelData == null
          ? null
          : CupertinoActionSheetAction(
              key: cancelData.key,
              isDefaultAction: cancelData.isDefaultAction ?? false,
              isDestructiveAction: cancelData.isDestructiveAction ?? false,
              onPressed: cancelData.onPressed ?? () => Navigator.pop(context),
              child: cancelData.child,
            ),
    );
  }

  /// A method to show a popup menu with the items supplied to
  /// [PopupMenuButton.itemBuilder] at the position of your [PopupMenuButton].
  ///
  /// By default, it is called when the user taps the button and [PopupMenuButton.enabled]
  /// is set to `true`. Moreover, you can open the button by calling the method manually.
  ///
  /// You would access your [PopupMenuButtonState] using a [GlobalKey] and
  /// show the menu of the button with `globalKey.currentState.showButtonMenu`.
  void showButtonMenu() {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      showPlatformModalSheet<void>(
        context: context,
        builder: (context) => _cupertinoSheetContent(context),
      );
      return;
    }
    final data = widget.material?.call(context, platform(context));
    final itemBuilder = data?.itemBuilder ??
        (context) => widget.options.map(
              (option) {
                final data = option.material?.call(context, platform(context));
                return PopupMenuItem(
                  value: option,
                  enabled: data?.enabled ?? true,
                  height: data?.height ?? kMinInteractiveDimension,
                  key: data?.key,
                  mouseCursor: data?.mouseCursor,
                  onTap: data?.onTap,
                  padding: data?.padding,
                  textStyle: data?.textStyle,
                  child: data?.child ?? Text(option.label ?? ''),
                );
              },
            ).toList();

    final PopupMenuThemeData popupMenuTheme = PopupMenuTheme.of(context);
    final RenderBox button = context.findRenderObject()! as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    final Offset offset;
    switch (data?.position ?? PopupMenuPosition.over) {
      case PopupMenuPosition.over:
        offset = data?.offset ?? Offset.zero;
        break;
      case PopupMenuPosition.under:
        offset = Offset(
                0.0, button.size.height - (data?.padding?.vertical ?? 8) / 2) +
            (data?.offset ?? Offset.zero);
        break;
    }
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(offset, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero) + offset,
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    final List<PopupMenuEntry<PopupMenuOption>> items = itemBuilder(context);
    // Only show the menu if there is something to show
    if (items.isNotEmpty) {
      showMenu<PopupMenuOption?>(
        context: context,
        elevation: data?.elevation ?? popupMenuTheme.elevation,
        items: items,
        initialValue: data?.initialValue,
        position: position,
        shape: data?.shape ?? popupMenuTheme.shape,
        color: data?.color ?? popupMenuTheme.color,
        constraints: data?.constraints,
      ).then<void>((PopupMenuOption? newValue) {
        if (!mounted) {
          return null;
        }
        if (newValue == null) {
          data?.onCanceled?.call();
          return null;
        }
        newValue.onTap?.call(newValue);
      });
    }
  }
}
