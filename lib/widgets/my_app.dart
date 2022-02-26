import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_album/design_system/themes/adaptive_platform.dart';
import 'package:photo_album/design_system/widgets/adaptive_app.dart';
import 'package:photo_album/state/state.dart';
import 'package:photo_album/widgets/home_screen/home_screen.dart';

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
class MyAppContent extends ConsumerWidget {
  const MyAppContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final platformType = ref.watch(platformTypeProvider);

    return AdaptivePlatform(
      platform: platformType,
      child: AdaptiveApp(
        themeMode: themeMode,
        home: const HomeScreen(),
      ),
    );
  }
}
