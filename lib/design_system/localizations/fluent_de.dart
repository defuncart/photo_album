import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';

/// DE strings for the fluent widgets.
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
  String get cutButtonLabel => 'Cut';

  @override
  String get copyButtonLabel => 'Copy';

  @override
  String get pasteButtonLabel => 'Paste';

  @override
  String get selectAllButtonLabel => 'Select all';

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

  /// Creates an object that provides US English resource values for the material
  /// library widgets.
  ///
  /// The [locale] parameter is ignored.
  ///
  /// This method is typically used to create a [LocalizationsDelegate].
  /// The [MaterialApp] does so by default.
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
