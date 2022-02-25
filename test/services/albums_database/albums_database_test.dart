import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_album/services/albums_database/albums_database.dart';
import 'package:photo_album/services/albums_database/models/photo_album.dart';

import '../../mocks.dart';

void main() {
  group('$AlbumsDatabase', () {
    late AlbumsDatabase albumsDatabase;

    group('initialize', () {
      late HiveInterface mockHiveInterface;

      setUp(() {
        mockHiveInterface = MockHiveInterface();
        albumsDatabase = AlbumsDatabase(
          hive: mockHiveInterface,
        );

        when(mockHiveInterface.openBox('albums')).thenAnswer((_) => Future.value(MockBox<PhotoAlbum>()));
      });

      test('expect that adapter is registered', () async {
        when(mockHiveInterface.isAdapterRegistered(PhotoAlbum.typeId)).thenReturn(false);

        await albumsDatabase.initialize();

        verify(mockHiveInterface.registerAdapter(PhotoAlbumAdapter()));
      }, skip: true);

      test('expect that box is opened', () async {
        when(mockHiveInterface.isAdapterRegistered(PhotoAlbum.typeId)).thenReturn(true);

        await albumsDatabase.initialize();

        verify(mockHiveInterface.openBox('albums'));
      }, skip: true);
    });
  });
}
