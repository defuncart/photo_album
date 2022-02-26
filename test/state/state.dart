import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:photo_album/design_system/themes/adaptive_platform.dart';
import 'package:photo_album/state/state.dart';

void main() {
  group('platformTypeProvider', () {
    const initialValue = PlatformType.system;

    final container = ProviderContainer();
    final listener = Listener<PlatformType?>();
    container.listen<PlatformType>(
      platformTypeProvider,
      listener,
      fireImmediately: true,
    );

    group('when the provider is created', () {
      test('expect initial value', () {
        verify(listener(null, initialValue)).called(1);
        verifyNoMoreInteractions(listener);
      });

      group('and when value is updated', () {
        const updatedValue = PlatformType.macos;

        test('expect updated value', () {
          container.read(platformTypeProvider.notifier).state = updatedValue;

          verify(listener(initialValue, updatedValue)).called(1);
          verifyNoMoreInteractions(listener);
        });
      });
    });
  });
}

class Listener<T> extends Mock {
  void call(T? previous, T value);
}
