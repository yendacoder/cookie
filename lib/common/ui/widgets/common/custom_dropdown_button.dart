import 'package:cookie/common/ui/widgets/common/platform_custom_popup_menu.dart';
import 'package:cookie/common/ui/widgets/common/tappable_item.dart';
import 'package:cookie/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class CustomDropdownButton<T> extends StatefulWidget {
  const CustomDropdownButton({
    super.key,
    required this.builder,
    required this.labels,
    required this.values,
    required this.onSelected,
    this.dropdownWidth = 200,
    this.isSelectable = false,
    this.selectedValue,
  });

  final Widget Function(BuildContext, dynamic) builder;
  final List<String> labels;
  final List<T> values;
  final T? selectedValue;
  final double dropdownWidth;
  final bool isSelectable;
  final void Function(T?) onSelected;

  @override
  State<StatefulWidget> createState() {
    return _PlatformDropdownButtonState<T>();
  }
}

class _PlatformDropdownButtonState<S> extends State<CustomDropdownButton<S>> {
  S? _selectedValue;
  final _menuKey = GlobalKey<PlatformCustomPopupMenuState>();

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  Widget _buildCategoryItem(
      BuildContext context, String title, bool isSelected) {
    return Row(
      children: [
        if (widget.isSelectable)
          SizedBox(
            width: 24,
            height: 24,
            child: isSelected
                ? Icon(
              Icons.check,
              color: Theme.of(context).primaryColor,
            )
                : null,
          ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMaterial(BuildContext context) {
    return TappableItem(
      onTap: () => _menuKey.currentState?.showButtonMenu(),
      child: PlatformCustomPopupMenu(
        key: _menuKey,
        material: (_, __) => MaterialPopupMenuData(
          position: PopupMenuPosition.over,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDefaultCornerRadius)),
        ),
        options: [
          for (int i = 0; i < widget.labels.length; i++)
            PopupMenuOption(
                material: (_, __) => MaterialPopupMenuOptionData(
                  child: _buildCategoryItem(context, widget.labels[i], widget.selectedValue == widget.values[i]),
                ),
                label: widget.labels[i],
                onTap: (_) {
                  widget.onSelected(widget.values[i]);
                }),
        ],
        child: widget.builder(context, _selectedValue),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildMaterial(context);
  }
}
