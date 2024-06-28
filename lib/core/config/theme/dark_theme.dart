import 'package:flutter/material.dart';

import '../../resources/font_manager.dart';
import 'theme__manager.dart';

// Define your dark theme colors
class DarkThemeColors {
  const DarkThemeColors._();
  static Color primaryColor = const Color(0xFF5A248D);

  static Color scaffoldColor = const Color(0xFF1A2127);

  static Color appbarColor = const Color(0xFF1A2127);
}

class DarkTheme {
  static ThemeData getTheme() => ThemeData(
      // Ligth Theme
      brightness: Brightness.dark,
      fontFamily: FontConstants.fontFamily,
      scaffoldBackgroundColor: DarkThemeColors.scaffoldColor,
      //colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: AppThemeManager.elevatedButtonStyleTheme(
              buttonColor: DarkThemeColors.primaryColor, textColor: Colors.white, textColorPressed: Colors.white)),
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: DarkThemeColors.appbarColor,
        centerTitle: true,
        // titleTextStyle:
      ),
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity);
}
