import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';

/// DE strings for the fluent widgets.
///
/// Taken from DefaultFluentLocalizations
class FluentLocalizationsDE implements FluentLocalizations {
  const FluentLocalizationsDE();

  @override
  String get backButtonTooltip => 'Back';

  @override
  String get closeButtonLabel => 'Close';

  @override
  String get searchLabel => 'Search';

  @override
  String get closeNavigationTooltip => 'Close Navigation';

  @override
  String get openNavigationTooltip => 'Open Navigation';

  @override
  String get clickToSearch => 'Click to search';

  @override
  String get modalBarrierDismissLabel => 'Dismiss';

  @override
  String get minimizeWindowTooltip => 'Minimze';

  @override
  String get restoreWindowTooltip => 'Restore';

  @override
  String get closeWindowTooltip => 'Close';

  @override
  String get dialogLabel => 'Dialog';

  @override
  String get cutActionLabel => 'Cut';

  @override
  String get copyActionLabel => 'Copy';

  @override
  String get pasteActionLabel => 'Paste';

  @override
  String get selectAllActionLabel => 'Select all';

  @override
  String get newTabLabel => 'Add new tab';

  @override
  String get closeTabLabel => 'Close tab (Ctrl+F4)';

  @override
  String get scrollTabBackwardLabel => 'Scroll tab list backward';

  @override
  String get scrollTabForwardLabel => 'Scroll tab list forward';

  @override
  String get noResultsFoundLabel => 'No results found';

  String get _ctrlCmd {
    if (defaultTargetPlatform == TargetPlatform.macOS) {
      return 'Cmd';
    }
    return 'Ctrl';
  }

  @override
  String get cutShortcut => '$_ctrlCmd+X';

  @override
  String get copyShortcut => '$_ctrlCmd+C';

  @override
  String get pasteShortcut => '$_ctrlCmd+V';

  @override
  String get selectAllShortcut => '$_ctrlCmd+A';

  @override
  String get copyActionTooltip => 'Copy the selected content to the clipboard';

  @override
  String get cutActionTooltip => 'Remove the selected content and put it in the clipboard';

  @override
  String get pasteActionTooltip => 'Inserts the contents of the clipboard at the current location';

  @override
  String get selectAllActionTooltip => 'Select all content';

  /// Creates an object that provides US English resource values for the fluent
  /// library widgets.
  ///
  /// The [locale] parameter is ignored.
  ///
  /// This method is typically used to create a [LocalizationsDelegate].
  /// The [FluentApp] does so by default.
  static Future<FluentLocalizations> load(Locale locale) {
    return SynchronousFuture<FluentLocalizations>(const DefaultFluentLocalizations());
  }

  static const LocalizationsDelegate<FluentLocalizations> delegate = _FluentLocalizationsDelegate();
}

class _FluentLocalizationsDelegate extends LocalizationsDelegate<FluentLocalizations> {
  const _FluentLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'de';

  @override
  Future<FluentLocalizations> load(Locale locale) => DefaultFluentLocalizations.load(locale);

  @override
  bool shouldReload(_FluentLocalizationsDelegate old) => false;

  @override
  String toString() => 'DefaultFluentLocalizations.delegate(en_US)';
}
