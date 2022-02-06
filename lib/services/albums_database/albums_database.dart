import 'package:hive/hive.dart';
import 'package:photo_album/services/albums_database/i_albums_database.dart';
import 'package:photo_album/services/albums_database/models/photo_album.dart';

class AlbumsDatabase implements IAlbumsDatabase {
  AlbumsDatabase({
    HiveInterface? hive,
  }) : _hive = hive ?? Hive;

  final HiveInterface _hive;

  /// A box to store objects
  late Box<PhotoAlbum> _box;

  /// A name for the box
  static const _boxName = 'albums';

  @override
  PhotoAlbum getAlbum(String id) {
    if (_box.containsKey(id)) {
      throw ArgumentError('No $PhotoAlbum with id $id found');
    }

    return _box.get(id)!;
  }

  @override
  Stream<PhotoAlbum> watchAlbum(String id) {
    if (_box.containsKey(id)) {
      throw ArgumentError('No $PhotoAlbum with id $id found');
    }

    return _box.watch(key: id).map((_) => getAlbum(id));
  }

  @override
  List<PhotoAlbum> getAllAlbums() => _box.values.toList();

  @override
  Stream<List<PhotoAlbum>> watchAllAlbums() => _box.watch().map((_) => getAllAlbums());

  @override
  Future<void> addAlbum({required String name}) async {
    const id = 'id';
    await _box.put(id, PhotoAlbum(id: id, name: name));
  }

  @override
  Future<void> deleteAlbum(String id) async {
    if (_box.containsKey(id)) {
      throw ArgumentError('No $PhotoAlbum with id $id found');
    }

    await _box.delete(id);
  }

  @override
  Future<void> initialize() async {
    if (!_hive.isAdapterRegistered(PhotoAlbum.typeId)) {
      _hive.registerAdapter(PhotoAlbumAdapter());
    }
    _box = await _hive.openBox<PhotoAlbum>(_boxName);
  }

  @override
  Future<void> reset() => _box.deleteAll(_box.keys);
}
