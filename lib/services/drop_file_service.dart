import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:meta/meta.dart';
import 'package:mime/mime.dart';

class DropFileService {
  /// Returns a list of paths of images from a given list of files and/or folders
  ///
  /// Note that a recursion of depth 2 is supported
  Future<List<String>> filterImages(List<XFile> files) async {
    final validImages = <String>[];
    for (final file in files) {
      if (await Directory(file.path).exists()) {
        validImages.addAll(await imagesInDirectory(file.path));
      } else {
        if (isImage(file.path)) {
          validImages.add(file.path);
        }
      }
    }

    return validImages;
  }

  @visibleForTesting
  bool isImage(String path) => lookupMimeType(path)?.split('/').first == 'image';

  @visibleForTesting
  Future<List<String>> imagesInDirectory(String path, {int recursiveDepth = 0}) async {
    final validPaths = <String>[];
    final contents = await directoryContents(path);
    for (final entity in contents) {
      if (await FileSystemEntity.isDirectory(entity.path)) {
        if (recursiveDepth < 2) {
          validPaths.addAll(await imagesInDirectory(entity.path, recursiveDepth: recursiveDepth + 1));
        }
      }

      if (isImage(entity.path)) {
        validPaths.add(entity.path);
      }
    }
    return validPaths;
  }

  @visibleForTesting
  Future<List<FileSystemEntity>> directoryContents(String path) async {
    final dir = Directory(path);
    return dir.list().toList();
  }
}
