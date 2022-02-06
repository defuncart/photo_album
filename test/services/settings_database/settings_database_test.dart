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

      test('expect that box is opened', () async {
        await settingsDatabase.initialize();

        verify(mockHiveInterface.openBox('settings'));
      });
    });
  });
}
