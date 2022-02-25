import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:photo_album/services/files/files_service.dart';

void main() {
  group('$FilesService', () {
    late FilesService filesService;

    setUp(() {
      filesService = FilesService();
    });

    group('getFile', () {
      String path = 'a.jpg';

      group('when file exists for path', () {
        setUp(() async {
          await File(path).create();
        });

        tearDown(() async {
          await File(path).delete();
        });

        test('expect file', () {
          expect(() => filesService.getFile(path), returnsNormally);
        });
      });

      group('when no file exists for path', () {
        test('expect error', () {
          expect(() => filesService.getFile(path), throwsArgumentError);
        }, skip: true);
      });
    });
  });
}
