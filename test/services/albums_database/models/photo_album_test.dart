import 'package:flutter_test/flutter_test.dart';
import 'package:photo_album/services/albums_database/models/photo_album.dart';

void main() {
  group('$PhotoAlbum', () {
    late PhotoAlbum photoAlbum;

    const id = 'id';
    const name = 'name';

    group('addPhoto', () {
      late String photoPath;

      setUp(() {
        photoAlbum = PhotoAlbum(id: id, name: name, photoPaths: ['bla']);
      });

      group('when photoAlbum already contains photoPath ', () {
        setUp(() {
          photoPath = 'bla';
        });

        test('expect error', () {
          expect(() => photoAlbum.addPhoto(photoPath), throwsArgumentError);
        });
      });

      group('when photoAlbum does not contain photoPath', () {
        setUp(() {
          photoPath = 'bla2';
          photoAlbum.addPhoto(photoPath);
        });

        test('expect photoPath is added', () {
          expect(photoAlbum.photoPaths, const ['bla', 'bla2']);
        }, skip: true);
      });
    });

    group('removePhoto', () {
      late String photoPath;

      setUp(() {
        photoAlbum = PhotoAlbum(id: id, name: name, photoPaths: ['bla']);
      });

      group('when photoAlbum does not contain photoPath', () {
        setUp(() {
          photoPath = 'bla2';
        });

        test('expect error', () {
          expect(() => photoAlbum.removePhoto(photoPath), throwsArgumentError);
        });
      });

      group('when photoAlbum contains photoPath ', () {
        setUp(() {
          photoPath = 'bla';
          photoAlbum.removePhoto(photoPath);
        });

        test('expect photoPath is removed', () {
          expect(photoAlbum.photoPaths, const []);
        }, skip: true);
      });
    });
  });
}
