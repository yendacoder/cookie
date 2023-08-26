import 'package:cookie/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ListLoadingItem extends StatelessWidget {
  const ListLoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: kDefaultTappableItemHeight,
        alignment: Alignment.center,
        child: PlatformCircularProgressIndicator());
  }
}
