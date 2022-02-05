import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:photo_album/design_system/themes/adaptive_platform.dart';
import 'package:photo_album/generated/l10n.dart';

class AdaptiveWindow extends StatefulWidget {
  const AdaptiveWindow({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  State<AdaptiveWindow> createState() => _AdaptiveWindowState();
}

class _AdaptiveWindowState extends State<AdaptiveWindow> {
  @override
  Widget build(BuildContext context) {
    final adaptivePlatform = AdaptivePlatform.of(context);
    if (adaptivePlatform.isMacOS) {
      return MacosWindow(
        sidebar: Sidebar(
          builder: (context, controller) {
            return SidebarItems(
              currentIndex: 0,
              onChanged: print,
              scrollController: controller,
              selectedColor: MacosTheme.of(context).dividerColor,
              items: [
                SidebarItem(
                  leading: const MacosIcon(CupertinoIcons.heart),
                  label: Text(
                    'My Album',
                    style: TextStyle(
                      color: MacosTheme.of(context).typography.body.color,
                    ),
                  ),
                ),
                SidebarItem(
                  leading: const MacosIcon(CupertinoIcons.compass),
                  label: Text(
                    'Flutter',
                    style: TextStyle(
                      color: MacosTheme.of(context).typography.body.color,
                    ),
                  ),
                ),
              ],
            );
          },
          minWidth: 200,
          bottom: MacosListTile(
            leading: const MacosIcon(CupertinoIcons.settings),
            title: Text(
              'Settings',
              style: TextStyle(
                color: MacosTheme.of(context).typography.body.color,
              ),
            ),
          ),
        ),
        child: MacosScaffold(
          titleBar: const TitleBar(
            title: Text('Title Bar'),
          ),
          children: [
            ContentArea(
              builder: (context, controller) => widget.child,
            ),
          ],
        ),
      );
    } else if (adaptivePlatform.isLinux) {
      return Scaffold(
        body: widget.child,
      );
    } else {
      return NavigationView(
        pane: NavigationPane(
          selected: 0,
          onChanged: print,
          size: const NavigationPaneSize(
            openMinWidth: 200,
            openMaxWidth: 200,
          ),
          header: Container(
            height: kOneLineTileHeight,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              AppLocalizations.of(context).appTitle,
            ),
          ),
          displayMode: PaneDisplayMode.open,
          items: [
            PaneItem(
              icon: const Icon(FluentIcons.photo2),
              title: const Text('My Album'),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.photo),
              title: const Text('Flutter'),
            ),
          ],
          footerItems: [
            PaneItemSeparator(),
            PaneItem(
              icon: const Icon(FluentIcons.settings),
              title: const Text('Settings'),
            ),
          ],
        ),
        content: ScaffoldPage(
          content: widget.child,
        ),
      );
    }
  }
}
