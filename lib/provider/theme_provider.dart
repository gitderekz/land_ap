import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';

import '../l10n/l10n.dart';

class ThemeProvider extends ChangeNotifier {
  // LOCALE
  Locale? _locale;
  Locale? get locale => _locale;
  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }
  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
  // END LOCALE

  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

abstract class AppColors {
  static const secondary = Color(0xFF3B76F6);
  static const accent = Color(0xFFD6755B);
  static const textDark = Color(0xFF53585A);
  static const textLigth = Color(0xFFF5F5F5);
  static const textFaded = Color(0xFF9899A5);
  static const iconLight = Color(0xFFB1B4C0);
  static const iconDark = Color(0xFFB1B3C1);
  static const textHighlight = secondary;
  static const cardLight = Color(0xFFF9FAFE);
  static const cardDark = Color(0xFF303334);

}
abstract class _LightColors {
  static Color? background = Colors.grey[300];//Colors.white;
  static const card = AppColors.cardLight;
}

abstract class _DarkColors {
  static const background = Color(0xFF1B1E1F);
  static const card = AppColors.cardDark;
}
class MyThemes {
  static const accentColor = AppColors.accent;
  static final visualDensity = VisualDensity.adaptivePlatformDensity;
  final darkBase = ThemeData.dark();
  final lightBase = ThemeData.light();

  ThemeData get darkTheme => ThemeData(
    // scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.black,
    // colorScheme: ColorScheme.dark(),
    // iconTheme: IconThemeData(color: Colors.purple.shade200, opacity: 0.8),

    //old
    brightness: Brightness.dark,
    colorScheme: darkBase.colorScheme.copyWith(secondary: accentColor),
    visualDensity: visualDensity,
    // textTheme:
    // GoogleFonts.interTextTheme().apply(bodyColor: AppColors.textLigth),
    backgroundColor: _DarkColors.background,
    appBarTheme: darkBase.appBarTheme.copyWith(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    scaffoldBackgroundColor: _DarkColors.background,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(primary: AppColors.secondary),
    ),
    cardColor: _DarkColors.card,
    primaryTextTheme: const TextTheme(
      headline6: TextStyle(color: AppColors.textLigth),
    ),
    iconTheme: const IconThemeData(color: AppColors.iconLight),
  );

  ThemeData get lightTheme => ThemeData(
    // scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    // colorScheme: ColorScheme.light(),
    // iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),

    //old
    brightness: Brightness.light,
    colorScheme: lightBase.colorScheme.copyWith(secondary: accentColor),
    visualDensity: visualDensity,
    // textTheme:
    // GoogleFonts.mulishTextTheme().apply(bodyColor: AppColors.textDark),
    backgroundColor: _LightColors.background,
    appBarTheme: lightBase.appBarTheme.copyWith(
      iconTheme: lightBase.iconTheme,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17,
        color: AppColors.textDark,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    scaffoldBackgroundColor: _LightColors.background,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(primary: AppColors.secondary),
    ),
    cardColor: _LightColors.card,
    primaryTextTheme: const TextTheme(
      headline6: TextStyle(color: AppColors.textDark),
    ),
    iconTheme: const IconThemeData(color: AppColors.iconDark),
  );
}