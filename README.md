# photo_album

A desktop application to organize your photos.

## Getting Started

To build the app locally, the following tools are required:

- Flutter stable >= 2.10
- Dart >= 2.16
- macOS:
    - Xcode >= 13.0
    - CocoaPods >= 1.11.0
- Linux:
    - clang
    - ninja-build
    - libgtk-3-dev
    - libblkid-dev
- Windows:
    - Developer Mode enabled

## UI

The application's UI is adaptive across all three Desktop platforms.

## Code Generation

### Localizations

To add new localizations, update `assets_dev/loca/loca.csv` and run

```sh
sh bin/loca_generate.sh
```

## Tests

Golden tests are used to verify that widgets appear as they should. These goldens are generated on macOS, however the CI pipeline runs on Linux which can result in discrepancies. As stated in [#56383](https://github.com/flutter/flutter/issues/56383), one solution is to disable font smoothing on macOS:

```
defaults -currentHost write -g AppleFontSmoothing -int 0
```

## Credits

This application is developed for personal use, and is inspired by Letterbox, iMDb and Filmweb. This product uses the TMDB API but is not endorsed or certified by TMDB.

## Raising Issues and Contributing

Please report bugs and issues, and raise feature requests [here](https://github.com/defuncart/film_freund/issues).

To contribute, submit a PR with a detailed description and tests, if applicable.
