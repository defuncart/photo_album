import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_ui/flutter_test_ui.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_album/services/hive/hive_manager.dart';
import 'package:photo_album/services/settings_database/i_settings_database.dart';
import 'package:photo_album/state/state.dart';
import 'package:photo_album/widgets/my_app.dart';

import '../mocks.mocks.dart';

void main() {
  group('$MyApp', () {
    late MockHiveManager mockHiveManager;
    late MockISettingsDatabase mockISettingsDatabase;

    setUp(() {
      mockHiveManager = MockHiveManager();
      mockISettingsDatabase = MockISettingsDatabase();
    });

    group('when widget is first pumped', () {
      setUpUI((tester) async {
        final widget = ProviderScope(
          overrides: [
            hiveManagerProvider.overrideWithValue(mockHiveManager),
            settingsDatabaseProvider.overrideWithValue(mockISettingsDatabase),
          ],
          child: const MyApp(),
        );
        await tester.pumpWidget(widget);
      });

      testUI('expect initial state', (tester) async {
        expect(find.byType(MyApp), findsOneWidget);
        expect(find.byType(LoadingWidget), findsOneWidget);
        expect(find.byType(MyAppContent), findsNothing);
      });

      group('and when init is complete', () {
        setUpUI((tester) async {
          when(mockISettingsDatabase.themeMode).thenReturn(ThemeMode.system);
          await tester.pump();
        });

        testUI('expect $HiveManager is initialized', (tester) async {
          verify(mockHiveManager.initialize());
        });

        testUI('expect $ISettingsDatabase is initialized', (tester) async {
          verify(mockISettingsDatabase.initialize());
        });

        testUI('expect initialized state', (tester) async {
          expect(find.byType(MyApp), findsOneWidget);
          expect(find.byType(LoadingWidget), findsNothing);
          expect(find.byType(MyAppContent), findsOneWidget);
        });
      });
    });
  });
}
