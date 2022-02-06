import 'package:flutter/material.dart' show ThemeMode;
import 'package:hive/hive.dart';
import 'package:photo_album/services/settings_database/i_settings_database.dart';

class SettingsDatabase implements ISettingsDatabase {
  SettingsDatabase({
    HiveInterface? hive,
  }) : _hive = hive ?? Hive;

  final HiveInterface _hive;

  /// A box to store objects
  late Box<dynamic> _box;

  /// A name for the box
  static const _boxName = 'settings';

  @override
  ThemeMode get themeMode => _box.get(_Keys.themeMode, defaultValue: _Defaults.themeMode);

  @override
  set themeMode(ThemeMode value) => _box.put(_Keys.themeMode, value);

  @override
  String? get language => _box.get(_Keys.language, defaultValue: _Defaults.language);

  @override
  set language(String? value) => _box.put(_Keys.language, value);

  @override
  Future<void> initialize() => _hive.openBox<dynamic>(_boxName);

  @override
  Future<void> reset() => _box.deleteAll(_box.keys);
}

/// A class of keys used to store values
class _Keys {
  static const themeMode = 'themeMode';
  static const language = 'language';
}

/// A class of defaults for each key
class _Defaults {
  static const themeMode = ThemeMode.system;
  static const language = null;
}
