import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_album/design_system/themes/adaptive_platform.dart';
import 'package:photo_album/design_system/widgets/adaptive_app.dart';
import 'package:photo_album/design_system/widgets/adaptive_radio_button_group.dart';
import 'package:photo_album/generated/l10n.dart';
import 'package:photo_album/state/state.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  var _isInitializing = true;

  @override
  void initState() {
    super.initState();

    _initApp();
  }

  Future<void> _initApp() async {
    await ref.read(hiveManagerProvider).initialize();
    await ref.read(settingsDatabaseProvider).initialize();

    setState(() => _isInitializing = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitializing) {
      return const LoadingWidget();
    }

    return const MyAppContent();
  }
}

@visibleForTesting
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

@visibleForTesting
class MyAppContent extends ConsumerStatefulWidget {
  const MyAppContent({Key? key}) : super(key: key);

  @override
  __MyAppState createState() => __MyAppState();
}

class __MyAppState extends ConsumerState<MyAppContent> {
  var _platform = PlatformType.windows;
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();

    _themeMode = ref.read(settingsDatabaseProvider).themeMode;
  }

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
                  onChanged: (value) {
                    ref.read(settingsDatabaseProvider).themeMode = value;
                    setState(() => _themeMode = value);
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
