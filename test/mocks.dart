import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:photo_album/services/hive/hive_manager.dart';
import 'package:photo_album/services/settings_database/i_settings_database.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

export 'mocks.mocks.dart';

@GenerateMocks([
  HiveInterface,
  Box,
  HiveManager,
  ISettingsDatabase,
])
void main() {}

class MethodChannelMocks {
  static void setupPathProvider(PathProviderPlatform instance) {
    TestWidgetsFlutterBinding.ensureInitialized();
    PathProviderPlatform.instance = instance;
  }
}

// Manually created as without `MockPlatformInterfaceMixin` PathProviderPlatform.instance will fail
class MockPathProviderPlatform extends Mock with MockPlatformInterfaceMixin implements PathProviderPlatform {
  @override
  Future<String> getTemporaryPath() async => 'TemporaryPath';

  @override
  Future<String> getApplicationSupportPath() async => 'ApplicationSupportPath';

  @override
  Future<String> getLibraryPath() async => 'LibraryPath';

  @override
  Future<String> getApplicationDocumentsPath() async => 'ApplicationDocumentsPath';

  @override
  Future<String> getExternalStoragePath() async => 'ExternalStoragePath';

  @override
  Future<List<String>> getExternalCachePaths() async => ['ExternalCachePath'];

  @override
  Future<List<String>> getExternalStoragePaths({
    StorageDirectory? type,
  }) async =>
      ['ExternalStoragePath'];

  @override
  Future<String> getDownloadsPath() async => 'DownloadsPath';
}
