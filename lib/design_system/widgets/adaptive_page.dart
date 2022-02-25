import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:photo_album/design_system/themes/adaptive_platform.dart';

class AdaptivePage extends StatelessWidget {
  const AdaptivePage({
    required this.title,
    required this.child,
    Key? key,
  }) : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final adaptivePlatform = AdaptivePlatform.of(context);
    if (adaptivePlatform.isMacOS) {
      return MacosScaffold(
        titleBar: TitleBar(
          title: Text(title),
        ),
        children: [
          ContentArea(
            builder: (context, controller) => child,
          ),
        ],
      );
    } else if (adaptivePlatform.isLinux) {
      return Scaffold(
        // YaruMasterDetailPage automatically adds an AppBar
        body: child,
      );
    } else {
      return ScaffoldPage(
        header: Text(title),
        content: child,
      );
    }
  }
}
