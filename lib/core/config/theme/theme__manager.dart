import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/dimension_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import 'dark_theme.dart';
import 'light_theme.dart';

class AppThemeManager {
  const AppThemeManager._();

  static ValueNotifier<bool> darkModeEnabled = ValueNotifier(false);
  static setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: themeMode == ThemeMode.light
          ? LightThemeColors.scaffoldColor
          : DarkThemeColors.scaffoldColor,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }

// Custom Widgets style

  static ButtonStyle elevatedButtonStyleTheme(
          { // Elevated Button
          required Color buttonColor,
          required Color textColor,
          Color? buttonColorPressed,
          Color? textColorPressed}) =>
      ButtonStyle(
        textStyle: MaterialStateProperty.all(
            TextStylesManager.tajawalSemiBold.copyWith(fontSize: FontSize.s20)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRaduis.r8))),
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(vertical: AppPadding.p14.h)),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return buttonColorPressed ??
                  LightThemeColors.primaryColor.withOpacity(.8);
            }
            return buttonColor;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return textColorPressed ?? textColor;
            }
            return textColor;
          },
        ),
      );
}
