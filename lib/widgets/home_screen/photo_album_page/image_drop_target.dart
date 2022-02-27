import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_album/state/state.dart';

class ImageDropTarget extends ConsumerWidget {
  const ImageDropTarget({
    required this.onImagesDragged,
    required this.child,
    Key? key,
  }) : super(key: key);

  final void Function(List<String>) onImagesDragged;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropTarget(
      onDragDone: (detail) async {
        final paths = await ref.read(dropFileServiceProvider).filterImages(detail.files);
        onImagesDragged(paths);
      },
      onDragUpdated: (details) {},
      onDragEntered: (detail) {},
      onDragExited: (detail) {},
      child: child,
    );
  }
}
