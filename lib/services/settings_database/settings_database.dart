import 'package:flutter/material.dart' show ThemeMode;
import 'package:hive/hive.dart';
import 'package:meta/meta.dart' show visibleForTesting;
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
  Future<void> initialize() async {
    if (!_hive.isAdapterRegistered(themeModeAdapterTypeId)) {
      _hive.registerAdapter(ThemeModeAdapter());
    }
    _box = await _hive.openBox<dynamic>(_boxName);
  }

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

@visibleForTesting
const themeModeAdapterTypeId = 0;

@visibleForTesting
class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  final int typeId = themeModeAdapterTypeId;

  @override
  ThemeMode read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ThemeMode.dark;
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }

  @override
  void write(BinaryWriter writer, ThemeMode obj) {
    switch (obj) {
      case ThemeMode.dark:
        writer.writeByte(0);
        break;
      case ThemeMode.light:
        writer.writeByte(1);
        break;
      case ThemeMode.system:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ThemeModeAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
