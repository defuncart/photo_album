import 'package:flutter/material.dart';
import 'package:photo_album/design_system/models/sidebar_item_model.dart';
import 'package:photo_album/design_system/widgets/adaptive_page.dart';
import 'package:photo_album/design_system/widgets/adaptive_window.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveWindow(
      sidebarItems: const [
        SidebarItemModel(
          icon: Icons.abc,
          label: 'abc',
        ),
      ],
      settingsItem: const SidebarItemModel(
        icon: Icons.abc,
        label: 'abc',
      ),
      sidebarItemBuilder: (index) => const AdaptivePage(
        title: 'Sidebar',
        child: Text('info'),
      ),
      settingsBuilder: (context) => const AdaptivePage(
        title: 'Settings',
        child: Text('info'),
      ),
    );
  }
}
