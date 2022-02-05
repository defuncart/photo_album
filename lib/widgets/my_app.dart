import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/design_system/themes/adaptive_platform.dart';
import 'package:photo_album/design_system/widgets/adaptive_app.dart';
import 'package:photo_album/design_system/widgets/adaptive_radio_button_group.dart';
import 'package:photo_album/generated/l10n.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _platform = PlatformType.windows;
  var _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return AdaptivePlatform(
      platform: _platform,
      child: AdaptiveApp(
        themeMode: _themeMode,
        child: Builder(builder: (context) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppLocalizations.of(context).test),
                const SizedBox(height: 8),
                AdaptiveRadioButtonGroup(
                  items: PlatformType.values.map((e) => RadioButtonItem(value: e, label: describeEnum(e))).toList(),
                  selectedValue: _platform,
                  onChanged: (value) => setState(() => _platform = value),
                ),
                const SizedBox(height: 8),
                AdaptiveRadioButtonGroup(
                  items: ThemeMode.values
                      .map((mode) => RadioButtonItem(
                            value: mode,
                            label: describeEnum(mode),
                          ))
                      .toList(),
                  selectedValue: _themeMode,
                  onChanged: (value) => setState(() => _themeMode = value),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
