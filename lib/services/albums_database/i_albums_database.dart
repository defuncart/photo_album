import 'package:photo_album/services/albums_database/models/photo_album.dart';

abstract class IAlbumsDatabase {
  PhotoAlbum getAlbum(String id);

  Stream<PhotoAlbum> watchAlbum(String id);

  List<PhotoAlbum> getAllAlbums();

  Stream<List<PhotoAlbum>> watchAllAlbums();

  Future<void> addAlbum({required String name});

  Future<void> deleteAlbum(String id);

  Future<void> initialize();

  Future<void> reset();
}
