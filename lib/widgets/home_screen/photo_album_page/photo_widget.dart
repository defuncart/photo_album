import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:native_context_menu/native_context_menu.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({
    required this.path,
    required this.width,
    required this.height,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  final String path;
  final double width;
  final double height;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ContextMenuRegion(
      onItemSelected: (_) => onDelete(),
      menuItems: [
        MenuItem(
          title: 'Delete',
        ),
      ],
      child: Image.file(
        File.fromUri(Uri.file(path)),
        width: width,
        height: height,
      ),
    );
  }
}
