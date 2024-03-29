import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:photo_album/design_system/models/sidebar_item_model.dart';
import 'package:photo_album/design_system/themes/adaptive_platform.dart';
import 'package:photo_album/generated/l10n.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class AdaptiveWindow extends StatefulWidget {
  const AdaptiveWindow({
    required this.sidebarItems,
    required this.sidebarItemBuilder,
    required this.settingsBuilder,
    Key? key,
  }) : super(key: key);

  final List<SidebarItemModel> sidebarItems;
  final Widget Function(int) sidebarItemBuilder;
  final WidgetBuilder settingsBuilder;

  @override
  State<AdaptiveWindow> createState() => _AdaptiveWindowState();
}

class _AdaptiveWindowState extends State<AdaptiveWindow> {
  static const _transparent = Color(0x00000000);

  var _currentIndex = 0;
  var _isSettingsActive = false;

  @override
  Widget build(BuildContext context) {
    final adaptivePlatform = AdaptivePlatform.of(context);
    if (adaptivePlatform.isMacOS) {
      return MacosWindow(
        sidebar: Sidebar(
          builder: (context, controller) {
            return SidebarItems(
              currentIndex: _currentIndex,
              onChanged: (value) => setState(() {
                _currentIndex = value;
                _isSettingsActive = false;
              }),
              scrollController: controller,
              selectedColor: _isSettingsActive ? _transparent : MacosTheme.of(context).dividerColor,
              items: [
                for (final item in widget.sidebarItems)
                  SidebarItem(
                    leading: const MacosIcon(CupertinoIcons.photo),
                    label: Text(
                      item.label,
                      style: TextStyle(
                        color: MacosTheme.of(context).typography.body.color,
                      ),
                    ),
                  ),
              ],
            );
          },
          minWidth: 220,
          bottom: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: _isSettingsActive ? MacosTheme.of(context).dividerColor : _transparent,
              borderRadius: const BorderRadius.all(Radius.circular(7)),
            ),
            child: MacosListTile(
              leading: const MacosIcon(CupertinoIcons.settings),
              title: Text(
                AppLocalizations.of(context).generalSettings,
                style: TextStyle(
                  color: MacosTheme.of(context).typography.body.color,
                ),
              ),
              onClick: () => setState(() => _isSettingsActive = true),
            ),
          ),
        ),
        child: _isSettingsActive ? widget.settingsBuilder(context) : widget.sidebarItemBuilder(_currentIndex),
      );
    } else if (adaptivePlatform.isLinux) {
      return YaruMasterDetailPage(
        leftPaneWidth: 220,
        pageItems: [
          for (final item in widget.sidebarItems)
            YaruPageItem(
              iconData: YaruIcons.camera_photo_filed,
              titleBuilder: (context) => Text(
                item.label,
              ),
              builder: (context) => widget.sidebarItemBuilder(_currentIndex),
            ),
          YaruPageItem(
            iconData: YaruIcons.settings_filled,
            titleBuilder: (context) => Text(
              AppLocalizations.of(context).generalSettings,
            ),
            builder: (context) => widget.settingsBuilder(context),
          ),
        ],
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).appTitle),
        ),
      );
    } else {
      return NavigationView(
        pane: NavigationPane(
          selected: _isSettingsActive ? widget.sidebarItems.length : _currentIndex,
          onChanged: (index) {
            setState(() {
              if (index == widget.sidebarItems.length) {
                _isSettingsActive = true;
              } else {
                _currentIndex = index;
                _isSettingsActive = false;
              }
            });
          },
          size: const NavigationPaneSize(
            openMinWidth: 220,
            openMaxWidth: 220,
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
            for (final item in widget.sidebarItems)
              PaneItem(
                icon: const Icon(FluentIcons.album),
                title: Text(
                  item.label,
                ),
              ),
          ],
          footerItems: [
            PaneItemSeparator(),
            PaneItem(
              icon: const Icon(FluentIcons.settings),
              title: Text(
                AppLocalizations.of(context).generalSettings,
              ),
            ),
          ],
        ),
        content: ScaffoldPage(
          content: SizedBox(
            width: double.infinity,
            child: _isSettingsActive ? widget.settingsBuilder(context) : widget.sidebarItemBuilder(_currentIndex),
          ),
        ),
      );
    }
  }
}
