import 'package:flutter/material.dart';
import 'package:photo_album/design_system/models/sidebar_item_model.dart';
import 'package:photo_album/design_system/widgets/adaptive_page.dart';
import 'package:photo_album/design_system/widgets/adaptive_window.dart';
import 'package:photo_album/widgets/home_screen/settings_page/settings_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const sidebarItems = [
      SidebarItemModel(
        label: 'abc',
      ),
      SidebarItemModel(
        label: 'xyz',
      ),
    ];

    return AdaptiveWindow(
      sidebarItems: sidebarItems,
      sidebarItemBuilder: (index) => AdaptivePage(
        title: sidebarItems[index].label,
        child: const Text('info'),
      ),
      settingsBuilder: (context) => const SettingsPage(),
    );
  }
}
