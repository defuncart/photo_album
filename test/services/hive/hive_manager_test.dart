import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:photo_album/services/hive/hive_manager.dart';

import '../../mocks.dart';

void main() {
  group('$HiveManager', () {
    late HiveManager hiveManager;
    late MockHiveInterface mockHiveInterface;
    late PathProviderPlatform mockPathProvider;

    setUp(() {
      mockPathProvider = MockPathProviderPlatform();
      MethodChannelMocks.setupPathProvider(mockPathProvider);

      mockHiveInterface = MockHiveInterface();
      hiveManager = HiveManager(
        hive: mockHiveInterface,
      );
    });

    group('initialize', () {
      test('ensure that hive is initialized', () async {
        final dir = await mockPathProvider.getApplicationDocumentsPath();

        await hiveManager.initialize();

        verify(mockHiveInterface.init(dir));
      });
    });
  });
}
