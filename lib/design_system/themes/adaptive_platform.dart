import 'dart:io' as io;

import 'package:flutter/widgets.dart';

enum PlatformType {
  system,
  macos,
  linux,
  windows,
}

enum AdaptivePlatformType {
  macos,
  linux,
  windows,
}

extension AdaptivePlatformTypeExtensions on AdaptivePlatformType {
  bool get isMacOS => this == AdaptivePlatformType.macos;

  bool get isLinux => this == AdaptivePlatformType.linux;

  bool get isWindows => this == AdaptivePlatformType.windows;
}

class AdaptivePlatform extends InheritedWidget {
  const AdaptivePlatform({
    this.platform = PlatformType.system,
    required Widget child,
    Key? key,
  }) : super(
          key: key,
          child: child,
        );

  final PlatformType platform;

  static AdaptivePlatform _of(BuildContext context) {
    final AdaptivePlatform? result = context.dependOnInheritedWidgetOfExactType<AdaptivePlatform>();
    assert(result != null, 'No $AdaptivePlatform found in widget tree!');
    return result!;
  }

  static AdaptivePlatformType of(BuildContext context) {
    switch (_of(context).platform) {
      case PlatformType.macos:
        return AdaptivePlatformType.macos;
      case PlatformType.linux:
        return AdaptivePlatformType.linux;
      case PlatformType.windows:
        return AdaptivePlatformType.windows;
      case PlatformType.system:
        if (io.Platform.isMacOS) {
          return AdaptivePlatformType.macos;
        } else if (io.Platform.isLinux) {
          return AdaptivePlatformType.linux;
        } else if (io.Platform.isWindows) {
          return AdaptivePlatformType.windows;
        } else {
          throw ('Platform not supported!');
        }
    }
  }

  @override
  bool updateShouldNotify(AdaptivePlatform oldWidget) => platform != oldWidget.platform;
}
