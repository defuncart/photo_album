import 'package:hive/hive.dart';

part 'photo_album.g.dart';

@HiveType(typeId: PhotoAlbum.typeId)
class PhotoAlbum extends HiveObject {
  static const typeId = 1;

  PhotoAlbum({
    required this.id,
    required this.name,
    this.photoPaths = const [],
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<String> photoPaths;

  void addPhoto(String photoPath) {
    if (photoPaths.contains(photoPath)) {
      throw ArgumentError('$PhotoAlbum already contains $photoPath');
    }

    photoPaths.add(photoPath);
    save();
  }

  void removePhoto(String photoPath) {
    if (!photoPaths.contains(photoPath)) {
      throw ArgumentError('$PhotoAlbum does not contain $photoPath');
    }

    photoPaths.remove(photoPath);
    save();
  }
}
