import 'package:flutter/material.dart';
import 'package:photo_album/design_system/models/sidebar_item_model.dart';
import 'package:photo_album/design_system/widgets/adaptive_window.dart';
import 'package:photo_album/services/albums_database/models/photo_album.dart';
import 'package:photo_album/widgets/home_screen/photo_album_page/photo_album_page.dart';
import 'package:photo_album/widgets/home_screen/settings_page/settings_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final photoAlbums = [
      PhotoAlbum(
        id: 'id1',
        name: 'abc',
      ),
      PhotoAlbum(
        id: 'id2',
        name: 'xyz',
      ),
    ];
    final sidebarItems = photoAlbums.map((e) => SidebarItemModel(label: e.name)).toList();

    return AdaptiveWindow(
      sidebarItems: sidebarItems,
      sidebarItemBuilder: (index) => PhotoAlbumPage(
        photoAlbum: photoAlbums[index],
      ),
      settingsBuilder: (context) => const SettingsPage(),
    );
  }
}
