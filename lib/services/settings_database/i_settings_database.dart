import 'package:flutter/material.dart' show ThemeMode;

/// A database of the user's device settings
abstract class ISettingsDatabase {
  /// Returns the selected theme mode
  ThemeMode get themeMode;

  /// Sets the selected theme mode
  set themeMode(ThemeMode value);

  /// Returns the chosen language
  String? get language;

  /// Sets the chosen language
  set language(String? value);

  /// Initializes the database
  Future<void> initialize();

  /// Resets the database
  Future<void> reset();
}
