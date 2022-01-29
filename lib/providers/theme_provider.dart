import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkThemeEnabled = false;
  setThemeMode(ThemeMode themeMode) {
    if (themeMode == ThemeMode.dark) {
      isDarkThemeEnabled = true;
    } else {
      isDarkThemeEnabled = false;
    }
    notifyListeners();

    print("Changding data $isDarkThemeEnabled");
  }
}

class SpotmiesTheme {
  static bool themeMode = false;
  static Color background = Colors.white;
  static Color onBackground = Colors.black;
  static Color primary = Colors.indigo.shade900;
  static Color secondary = Colors.grey.shade700;
  static Color tertiary = Colors.blue.shade800;
  static Color secondaryVariant = Colors.grey.shade900;
  static Color surface = Colors.white;
  static Color onSurface = Colors.grey.shade100;
  static Color tertiaryVariant = Colors.blue.shade900;
  static Color surfaceVariant = Colors.grey.shade50;
  static Color primaryVariant = Colors.indigo.shade50;

  Map<colorScheme, Color> lightColorScheme = {
    colorScheme.background: Colors.white,
    colorScheme.onBackground: Colors.black,
    colorScheme.primary: Colors.indigo.shade900,
    colorScheme.secondary: Colors.grey.shade700,
    colorScheme.tertiary: Colors.blue.shade800,
    colorScheme.secondaryVariant: Colors.grey.shade900,
    colorScheme.surface: Colors.white,
    colorScheme.onSurface: Colors.grey.shade100,
    colorScheme.tertiaryVariant: Colors.blue.shade900,
    colorScheme.surfaceVariant: Colors.grey.shade50,
    colorScheme.primaryVariant: Colors.indigo.shade50,
  };
  Map<colorScheme, Color> darkColorScheme = {
    colorScheme.background: Colors.grey.shade800,
    colorScheme.onBackground: Colors.white,
    colorScheme.primary: Colors.indigo.shade200,
    colorScheme.secondary: Colors.grey.shade300,
    colorScheme.tertiary: Colors.blue.shade400,
    colorScheme.secondaryVariant: Colors.grey.shade300,
    colorScheme.surface: Colors.grey.shade600,
    colorScheme.onSurface: Colors.grey.shade100,
    colorScheme.tertiaryVariant: Colors.blue.shade300,
    colorScheme.surfaceVariant: Colors.grey.shade500,
    colorScheme.primaryVariant: Colors.indigo.shade400
  };
  init(context) {
    Provider.of<ThemeProvider>(context, listen: true).addListener(() {
      themeMode =
          Provider.of<ThemeProvider>(context, listen: false).isDarkThemeEnabled;
      print(themeMode);
      background = (themeMode
          ? darkColorScheme[colorScheme.background]
          : lightColorScheme[colorScheme.background])!;
      onBackground = (themeMode
          ? darkColorScheme[colorScheme.onBackground]
          : lightColorScheme[colorScheme.onBackground])!;

      surface = (themeMode
          ? darkColorScheme[colorScheme.surface]
          : lightColorScheme[colorScheme.surface])!;
      onSurface = (themeMode
          ? darkColorScheme[colorScheme.onSurface]
          : lightColorScheme[colorScheme.onSurface])!;
      primary = (themeMode
          ? darkColorScheme[colorScheme.primary]
          : lightColorScheme[colorScheme.primary])!;
      secondary = (themeMode
          ? darkColorScheme[colorScheme.secondary]
          : lightColorScheme[colorScheme.secondary])!;

      tertiary = (themeMode
          ? darkColorScheme[colorScheme.tertiary]
          : lightColorScheme[colorScheme.tertiary])!;

      tertiaryVariant = (themeMode
          ? darkColorScheme[colorScheme.tertiaryVariant]
          : lightColorScheme[colorScheme.tertiaryVariant])!;
      secondaryVariant = (themeMode
          ? darkColorScheme[colorScheme.secondaryVariant]
          : lightColorScheme[colorScheme.secondaryVariant])!;
      surfaceVariant = (themeMode
          ? darkColorScheme[colorScheme.surfaceVariant]
          : lightColorScheme[colorScheme.surfaceVariant])!;
      primaryVariant = (themeMode
          ? darkColorScheme[colorScheme.primaryVariant]
          : lightColorScheme[colorScheme.primaryVariant])!;
    });
  }
}

enum colorScheme {
  background,
  onBackground,
  primary,
  primaryVariant,
  secondary,
  tertiary,
  tertiaryVariant,
  secondaryVariant,
  surface,
  onSurface,
  surfaceVariant,
}
