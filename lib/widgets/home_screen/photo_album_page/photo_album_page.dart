import 'package:flutter/material.dart';
import 'package:photo_album/design_system/widgets/adaptive_page.dart';
import 'package:photo_album/generated/l10n.dart';
import 'package:photo_album/services/albums_database/models/photo_album.dart';
import 'package:photo_album/widgets/home_screen/photo_album_page/image_drop_target.dart';
import 'package:photo_album/widgets/home_screen/photo_album_page/photo_widget.dart';
import 'package:reorderables/reorderables.dart';

class PhotoAlbumPage extends StatefulWidget {
  const PhotoAlbumPage({
    required this.photoAlbum,
    Key? key,
  }) : super(key: key);

  final PhotoAlbum photoAlbum;

  @override
  State<PhotoAlbumPage> createState() => _PhotoAlbumPageState();
}

class _PhotoAlbumPageState extends State<PhotoAlbumPage> {
  final _paths = <String>[];
  int? _draggedIndex;

  @override
  void didUpdateWidget(covariant PhotoAlbumPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.photoAlbum != oldWidget.photoAlbum) {
      _paths.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptivePage(
      title: widget.photoAlbum.name,
      child: ImageDropTarget(
        onImagesDragged: (paths) {
          if (paths.isEmpty) {
            // show popup
          }

          setState(() {
            _paths
              ..addAll(paths)
              ..distinct();
          });
        },
        child: SizedBox.expand(
          child: _paths.isEmpty
              ? Center(
                  child: Text(AppLocalizations.of(context).photoAlbumPageEmptyStateLabel),
                )
              : ReorderableWrap(
                  spacing: 8,
                  runSpacing: 8,
                  padding: const EdgeInsets.all(8),
                  children: [
                    for (var i = 0; i < _paths.length; i++)
                      Opacity(
                        opacity: _draggedIndex != null && _draggedIndex != i ? 0.4 : 1.0,
                        child: PhotoWidget(
                          path: _paths[i],
                          width: 200,
                          height: 125,
                          onDelete: () => setState(() => _paths.removeAt(i)),
                        ),
                      ),
                  ],
                  onReorder: _onReorder,
                  buildDraggableFeedback: (_, __, widget) => MouseRegion(
                    cursor: SystemMouseCursors.help,
                    child: widget,
                  ),
                  onNoReorder: (_) => setState(() => _draggedIndex = null),
                  onReorderStarted: (index) => setState(() => _draggedIndex = index),
                ),
        ),
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (oldIndex != newIndex) {
      // setState(() {
      _paths.insert(newIndex, _paths.removeAt(oldIndex));
      // });
    }
    setState(() => _draggedIndex = null);
  }
}

extension on List<String> {
  List<String> distinct() => {...this}.toList();
}
