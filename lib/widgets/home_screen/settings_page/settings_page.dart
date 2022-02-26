import 'package:flutter/foundation.dart' show describeEnum;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:photo_album/design_system/themes/adaptive_platform.dart';
import 'package:photo_album/design_system/widgets/adaptive_page.dart';
import 'package:photo_album/design_system/widgets/adaptive_radio_button_group.dart';
import 'package:photo_album/generated/l10n.dart';
import 'package:photo_album/state/state.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptivePage(
      title: AppLocalizations.of(context).generalSettings,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          PlatformTypeRadioButtonGroup(),
          Gap(8),
          ThemeModeRadioButtonGroup(),
        ],
      ),
    );
  }
}

class PlatformTypeRadioButtonGroup extends ConsumerWidget {
  const PlatformTypeRadioButtonGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final platformType = ref.watch(platformTypeProvider);
    final isLinux = AdaptivePlatform.of(context).isLinux;
    if (isLinux) {
      return YaruToggleButtonsRow(
        actionLabel: AppLocalizations.of(context).settingsPagePlatformTypeLabel,
        labels: PlatformType.values.map((e) => describeEnum(e)).toList(),
        selectedValues: PlatformType.values.map((e) => e == platformType).toList(),
        onPressed: (index) => ref.read(platformTypeProvider.notifier).state = PlatformType.values[index],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context).settingsPagePlatformTypeLabel),
        const Gap(8),
        AdaptiveRadioButtonGroup(
          items: PlatformType.values
              .map((mode) => RadioButtonItem(
                    value: mode,
                    label: describeEnum(mode),
                  ))
              .toList(),
          selectedValue: platformType,
          onChanged: (value) {
            ref.read(platformTypeProvider.notifier).state = value;
          },
        ),
      ],
    );
  }
}

class ThemeModeRadioButtonGroup extends ConsumerWidget {
  const ThemeModeRadioButtonGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isLinux = AdaptivePlatform.of(context).isLinux;
    if (isLinux) {
      return YaruToggleButtonsRow(
        actionLabel: AppLocalizations.of(context).settingsPageThemeModeLabel,
        labels: ThemeMode.values.map((e) => describeEnum(e)).toList(),
        selectedValues: ThemeMode.values.map((e) => e == themeMode).toList(),
        onPressed: (index) {
          final value = ThemeMode.values[index];
          ref.read(settingsDatabaseProvider).themeMode = value;
          ref.read(themeModeProvider.notifier).state = value;
        },
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context).settingsPageThemeModeLabel),
        const Gap(8),
        AdaptiveRadioButtonGroup(
          items: ThemeMode.values
              .map((mode) => RadioButtonItem(
                    value: mode,
                    label: describeEnum(mode),
                  ))
              .toList(),
          selectedValue: themeMode,
          onChanged: (value) {
            ref.read(settingsDatabaseProvider).themeMode = value;
            ref.read(themeModeProvider.notifier).state = value;
          },
        ),
      ],
    );
  }
}
