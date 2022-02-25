import 'dart:io';

class FilesService {
  Future<File> getFile(String path) async {
    final file = File(path);
    if (!await file.exists()) {
      throw ArgumentError('No file found at $path');
    }

    return file;
  }
}
