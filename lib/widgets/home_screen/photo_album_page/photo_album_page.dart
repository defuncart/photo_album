import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:photo_album/design_system/widgets/adaptive_page.dart';
import 'package:photo_album/services/albums_database/models/photo_album.dart';
import 'package:photo_album/widgets/home_screen/photo_album_page/image_drop_target.dart';

class PhotoAlbumPage extends StatelessWidget {
  const PhotoAlbumPage({
    required this.photoAlbum,
    Key? key,
  }) : super(key: key);

  final PhotoAlbum photoAlbum;

  @override
  Widget build(BuildContext context) {
    return AdaptivePage(
      title: photoAlbum.name,
      child: ImageDropTarget(
        onImagesDragged: (paths) => log(paths.toString()),
        child: const SizedBox.expand(),
      ),
    );
  }
}
