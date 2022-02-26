import 'dart:io';

import 'package:flutter/widgets.dart';

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({
    required this.path,
    required this.width,
    required this.height,
    Key? key,
  }) : super(key: key);

  final String path;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File.fromUri(Uri.file(path)),
      width: width,
      height: height,
    );
  }
}
