import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';

export 'mocks.mocks.dart';

@GenerateMocks([
  HiveInterface,
  Box,
])
void main() {}
