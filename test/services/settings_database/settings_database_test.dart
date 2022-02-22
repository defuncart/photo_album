import 'dart:io';

import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_album/services/settings_database/settings_database.dart';

import '../../mocks.dart';

void main() {
  group('$SettingsDatabase', () {
    late SettingsDatabase settingsDatabase;

    group('initialize', () {
      late HiveInterface mockHiveInterface;

      setUp(() {
        mockHiveInterface = MockHiveInterface();
        settingsDatabase = SettingsDatabase(
          hive: mockHiveInterface,
        );

        when(mockHiveInterface.openBox('settings')).thenAnswer((_) => Future.value(MockBox()));
      });

      test('expect that adapter is registered', () async {
        when(mockHiveInterface.isAdapterRegistered(themeModeAdapterTypeId)).thenReturn(false);

        await settingsDatabase.initialize();

        verify(mockHiveInterface.registerAdapter(ThemeModeAdapter()));
      });

      test('expect that box is opened', () async {
        when(mockHiveInterface.isAdapterRegistered(themeModeAdapterTypeId)).thenReturn(true);

        await settingsDatabase.initialize();

        verify(mockHiveInterface.openBox('settings'));
      });
    });

    group('Ensure hive works as expected', () {
      const path = 'path';

      setUp(() async {
        await Directory(path).create(recursive: true);

        Hive.init('path');

        settingsDatabase = SettingsDatabase();
        await settingsDatabase.initialize();
      });

      tearDown(() async {
        // delete files
        final dir = Directory(path);
        await dir.delete(recursive: true);
      });

      test('themeMode', () async {
        const defaultThemMode = ThemeMode.system;
        expect(settingsDatabase.themeMode, defaultThemMode);

        settingsDatabase.themeMode = ThemeMode.dark;

        expect(settingsDatabase.themeMode, ThemeMode.dark);

        await settingsDatabase.reset();

        expect(settingsDatabase.themeMode, defaultThemMode);
      }, onPlatform: {
        'windows': const Skip('Not supported on windows'),
      });

      test('language', () async {
        const defaultValue = null;

        expect(settingsDatabase.language, defaultValue);

        settingsDatabase.language = 'de';

        expect(settingsDatabase.language, 'de');

        await settingsDatabase.reset();

        expect(settingsDatabase.language, defaultValue);
      }, onPlatform: {
        'windows': const Skip('Not supported on windows'),
      });
    });
  });
}
