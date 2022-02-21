import 'package:hive/hive.dart';

part 'photo_album.g.dart';

@HiveType(typeId: PhotoAlbum.typeId)
class PhotoAlbum extends HiveObject {
  static const typeId = 1;

  PhotoAlbum({
    required this.id,
    required this.name,
    List<String> photoPaths = const [],
  }) : _photoPaths = photoPaths;

  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  final List<String> _photoPaths;
  List<String> get photoPaths => _photoPaths;

  void addPhoto(String photoPath) {
    if (_photoPaths.contains(photoPath)) {
      throw ArgumentError('$PhotoAlbum already contains $photoPath');
    }

    _photoPaths.add(photoPath);
    save();
  }

  void removePhoto(String photoPath) {
    if (!_photoPaths.contains(photoPath)) {
      throw ArgumentError('$PhotoAlbum does not contain $photoPath');
    }

    _photoPaths.remove(photoPath);
    save();
  }
}
