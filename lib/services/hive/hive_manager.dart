import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

/// A manager for Hive database
class HiveManager {
  HiveManager({
    HiveInterface? hive,
  }) : _hive = hive ?? Hive;

  final HiveInterface _hive;

  /// Initializes Hive. This must be called before any database is initialized.
  Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    _hive.init(dir.path);
  }
}
