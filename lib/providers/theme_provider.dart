import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkThemeEnabled = false;
  setThemeMode(ThemeMode themeMode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (themeMode == ThemeMode.dark) {
      isDarkThemeEnabled = true;
    } else {
      isDarkThemeEnabled = false;
    }
    sharedPreferences.setBool("theme_mode", isDarkThemeEnabled);
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
  static Color surfaceVariant2 = Colors.grey.shade200;

  static Color title = Colors.blueGrey.shade600;
  static Color titleVariant = Colors.blueGrey.shade900;
  static Color shadow = Colors.grey.shade700;
  static Color light1 = Colors.red.shade300;
  static Color light2 = Colors.blue.shade300;
  static Color light3 = Colors.green.shade300;
  static Color light4 = Colors.orange.shade300;

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
    colorScheme.surfaceVariant2: Colors.grey.shade200,
    colorScheme.title: Colors.blueGrey.shade600,
    colorScheme.titleVariant: Colors.blueGrey.shade900,
    colorScheme.shadow: Colors.grey.shade300,
    colorScheme.light1: Colors.blue.shade50,
    colorScheme.light2: Colors.red.shade50,
    colorScheme.light3: Colors.green.shade50,
    colorScheme.light4: Colors.orange.shade50,
  };
  Map<colorScheme, Color> darkColorScheme = {
    colorScheme.background: Colors.grey.shade800,
    colorScheme.onBackground: Colors.white,
    colorScheme.primary: Colors.grey.shade100,
    colorScheme.secondary: Colors.grey.shade300,
    colorScheme.tertiary: Colors.blue.shade400,
    colorScheme.secondaryVariant: Colors.grey.shade300,
    colorScheme.surface: Colors.grey.shade600,
    colorScheme.onSurface: Colors.grey.shade100,
    colorScheme.tertiaryVariant: Colors.blue.shade300,
    colorScheme.surfaceVariant: Colors.grey.shade700,
    colorScheme.primaryVariant: Colors.indigo.shade400,
    colorScheme.surfaceVariant2: Colors.grey.shade600,
    colorScheme.title: Colors.blueGrey.shade100,
    colorScheme.titleVariant: Colors.blueGrey.shade50,
    colorScheme.shadow: Colors.grey.shade700,
    colorScheme.light1: Colors.grey.shade700,
    colorScheme.light2: Colors.grey.shade700,
    colorScheme.light3: Colors.grey.shade700,
    colorScheme.light4: Colors.grey.shade700,
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

      surfaceVariant2 = (themeMode
          ? darkColorScheme[colorScheme.surfaceVariant2]
          : lightColorScheme[colorScheme.surfaceVariant2])!;
      primaryVariant = (themeMode
          ? darkColorScheme[colorScheme.primaryVariant]
          : lightColorScheme[colorScheme.primaryVariant])!;

      title = (themeMode
          ? darkColorScheme[colorScheme.title]
          : lightColorScheme[colorScheme.title])!;
      titleVariant = (themeMode
          ? darkColorScheme[colorScheme.titleVariant]
          : lightColorScheme[colorScheme.titleVariant])!;
      shadow = (themeMode
          ? darkColorScheme[colorScheme.shadow]
          : lightColorScheme[colorScheme.shadow])!;
      light1 = (themeMode
          ? darkColorScheme[colorScheme.light1]
          : lightColorScheme[colorScheme.light1])!;
      light2 = (themeMode
          ? darkColorScheme[colorScheme.light2]
          : lightColorScheme[colorScheme.light2])!;
      light3 = (themeMode
          ? darkColorScheme[colorScheme.light3]
          : lightColorScheme[colorScheme.light3])!;
      light4 = (themeMode
          ? darkColorScheme[colorScheme.light4]
          : lightColorScheme[colorScheme.light4])!;
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
  surfaceVariant2,
  title,
  titleVariant,
  shadow,
  light1,
  light2,
  light3,
  light4,
}
