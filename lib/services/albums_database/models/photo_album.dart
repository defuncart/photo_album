import 'package:hive/hive.dart';

part 'photo_album.g.dart';

@HiveType(typeId: PhotoAlbum.typeId)
class PhotoAlbum extends HiveObject {
  static const typeId = 1;

  PhotoAlbum({
    required this.id,
    required this.name,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;
}
