import 'package:auto_route/auto_route.dart';
import 'package:cookie/common/controller/initial_controller.dart';
import 'package:cookie/common/repository/settings_repository.dart';
import 'package:cookie/common/ui/widgets/common/flat_appbar.dart';
import 'package:cookie/common/ui/widgets/common/icon_text.dart';
import 'package:cookie/common/ui/widgets/common/platform_custom_popup_menu.dart';
import 'package:cookie/common/util/context_util.dart';
import 'package:cookie/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: FlatAppBar(
          text: context.l.settingsTitle,
        ),
        body: Consumer<InitialController>(builder: (context, controller, _) {
          late final String selectedType;
          switch (controller.feedViewType) {
            case FeedViewType.full:
              selectedType = context.l.settingsFeedViewTypeFull;
            case FeedViewType.regular:
              selectedType = context.l.settingsFeedViewTypeRegular;
            case FeedViewType.compact:
              selectedType = context.l.settingsFeedViewTypeCompact;
            case FeedViewType.micro:
              selectedType = context.l.settingsFeedViewTypeMicro;
          }
          final theme = Theme.of(context);
          return Padding(
            padding: const EdgeInsets.all(kPrimaryPaddingDouble),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(context.l.settingsFeedViewType,
                    style: theme.textTheme.titleLarge),
                PlatformCustomPopupMenu(
                    options: [
                      PopupMenuOption(
                          label: context.l.settingsFeedViewTypeFull,
                          onTap: (_) =>
                              controller.feedViewType = FeedViewType.full),
                      PopupMenuOption(
                          label: context.l.settingsFeedViewTypeRegular,
                          onTap: (_) =>
                              controller.feedViewType = FeedViewType.regular),
                      PopupMenuOption(
                          label: context.l.settingsFeedViewTypeCompact,
                          onTap: (_) =>
                              controller.feedViewType = FeedViewType.compact),
                      PopupMenuOption(
                          label: context.l.settingsFeedViewTypeMicro,
                          onTap: (_) =>
                              controller.feedViewType = FeedViewType.micro),
                    ],
                    manualTrigger: false,
                    child: Padding(
                      padding: const EdgeInsets.all(kSecondaryPadding),
                      child: IconText(
                        text: selectedType,
                        icon: Icons.arrow_drop_down,
                        isInverted: true,
                        style: theme.textTheme.titleMedium,
                      ),
                    )),
                const SizedBox(height: kPrimaryPaddingDouble,),
                Text(context.l.settingsCompatibility,
                    style: theme.textTheme.titleLarge),
                const SizedBox(height: 6.0,),
                Row(
                  children: [
                    PlatformSwitch(
                        value: controller.disableImageCache,
                        onChanged: (selected) =>
                            controller.disableImageCache = selected),
                    const SizedBox(width: kSecondaryPadding),
                    Text(context.l.settingsDisableImageCache),
                  ],
                ),
                const SizedBox(height: 6.0,),
                Row(
                  children: [
                    PlatformSwitch(
                        value: controller.inlineFullImages,
                        onChanged: (selected) =>
                            controller.inlineFullImages = selected),
                    const SizedBox(width: kSecondaryPadding),
                    Text(context.l.settingsInlineFullImages),
                  ],
                ),
              ],
            ),
          );
        }));
  }
}
