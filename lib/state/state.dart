import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_album/design_system/themes/adaptive_platform.dart';
import 'package:photo_album/services/hive/hive_manager.dart';
import 'package:photo_album/services/settings_database/i_settings_database.dart';
import 'package:photo_album/services/settings_database/settings_database.dart';

final settingsDatabaseProvider = Provider<ISettingsDatabase>(
  (_) => SettingsDatabase(),
);

final hiveManagerProvider = Provider(
  (_) => HiveManager(),
);

final themeModeProvider = StateProvider((ref) => ref.watch(settingsDatabaseProvider).themeMode);

final platformTypeProvider = StateProvider((_) => PlatformType.system);
