import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:photo_album/design_system/localizations/fluent_de.dart';
import 'package:photo_album/design_system/themes/adaptive_platform.dart';
import 'package:photo_album/generated/l10n.dart';
import 'package:yaru/yaru.dart';

class AdaptiveApp extends StatelessWidget {
  const AdaptiveApp({
    required this.themeMode,
    required this.home,
    Key? key,
  }) : super(key: key);

  final ThemeMode themeMode;
  final Widget home;

  @override
  Widget build(BuildContext context) {
    final adaptivePlatform = AdaptivePlatform.of(context);
    if (adaptivePlatform.isMacOS) {
      return MacosApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
        themeMode: themeMode,
        home: home,
      );
    } else if (adaptivePlatform.isLinux) {
      return material.MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
        themeMode: themeMode,
        theme: yaruLight,
        darkTheme: yaruDark,
        home: home,
      );
    } else {
      var effectThemeMode = themeMode == ThemeMode.system
          ? (MediaQueryData.fromWindow(WidgetsBinding.instance!.window).platformBrightness == Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light)
          : themeMode;

      // wrap FluentApp in MaterialApp to give access to Overlay
      // this is needed for reorderables
      return material.MaterialApp(
        home: FluentApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            DefaultFluentLocalizations.delegate,
            FluentLocalizationsDE.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.delegate.supportedLocales,
          onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
          themeMode: effectThemeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          builder: (context, __) => home,
        ),
      );
    }
  }
}
