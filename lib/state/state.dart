import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_album/services/hive/hive_manager.dart';
import 'package:photo_album/services/settings_database/i_settings_database.dart';
import 'package:photo_album/services/settings_database/settings_database.dart';

final settingsDatabaseProvider = Provider<ISettingsDatabase>(
  (_) => SettingsDatabase(),
);

final hiveManagerProvider = Provider(
  (_) => HiveManager(),
);
