import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/dimension_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import 'theme__manager.dart';

// Define your light theme colors
class LightThemeColors {
  const LightThemeColors._();
  static const Color primaryColor = Color(0xf03A405A);
  static const Color primaryColorLight1 = Color(0xf03A405A);
  static const Color primaryColorLight2 = Color(0xf03A405A);

// Body Color
  static const Color scaffoldColor = Color(0xffF2EEEB);

  static const Color appbarColor = Color(0xFFFBF9FC);
  static const Color appbarTextColor = Color(0xFF292D32);

  static const Color colorWhite = Colors.white;

  // Colors
  static const Color redLightColor = Color(0xFFFF0D0D);

  static const Color indicatorHintColor = Color(0xFFEBEBEB);
  static const Color iconColor = Color(0xFF292D32);
  static const Color linearThirdColor = Color(0xffAEC5EB);
  static const Color linearSecondColor = Color(0xffF7E1D7);

  static const Color containerColor = Color(0xf03A405A);
  static const Color dividerColor = Color(0xf03A405A);

  // Text Color
  static const Color textColorTitle = Color(0xFF1D1F1F);
  static const Color textColorSub = Color(0xFF1D1F1F);
  static const Color loginTitle = Color(0xFF1D1F1F);
  static const Color centerText = Color(0xFFA5A5A5);
  static const Color linearFirstColor = Color(0xffEDAFB8);
  static const Color takeWayColor = Color(0xFF233044);

  static const Color hintColor = Color(0xFF969AA0);
  static const Color hintColor2 = Color(0xFFB2B2B2);

  static const Color blackColor = Colors.black;

// Text Feiled
  static const Color fillTextFieldColor = Color(0xFF1D1F1F);
  static const Color iconTextFieldColor = Color(0xFF8A96BE);

  // shadow
  static const Color shadowContainerColor = Color(0x14000000);

  static const Color shadowCategoryColor = Color(0x19000000);

  //BUTTON
  //static const Color buttonColor = primaryColor;
  static const Color buttonTextColor = Colors.white;
  static const Color buttonDisabledColor = Colors.grey;
}

class LightTheme {
  static ThemeData getTheme() => ThemeData(
      // Ligth Theme
      brightness: Brightness.light,
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: FontConstants.fontFamily,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: LightThemeColors.primaryColor,
      cardColor: LightThemeColors.containerColor,
      hintColor: LightThemeColors.hintColor,
      colorScheme: ColorScheme.fromSeed(
          seedColor: LightThemeColors.primaryColor,
          onBackground: Colors.white,
          surfaceTint: Colors.transparent,
          background: Colors.white,
          brightness: Brightness.light,
          error: LightThemeColors.redLightColor,
          primaryContainer: Colors.white),

      //* App Bar Theme
      appBarTheme: AppBarTheme(
          elevation: AppSize.s0,
          color: Colors.white,
          iconTheme: const IconThemeData(color: LightThemeColors.iconColor),
          centerTitle: true,
          scrolledUnderElevation: 0,
          titleTextStyle: TextStylesManager.tajawalSemiBold.copyWith(
              color: LightThemeColors.appbarTextColor, fontSize: FontSize.s24)),
      //* Text Theme
      textTheme: TextTheme(
        //
        headlineLarge: TextStylesManager.tajawalBold.copyWith(
            color: LightThemeColors.textColorTitle, fontSize: FontSize.s16),
        headlineMedium: TextStylesManager.tajawalSemiBold.copyWith(
            color: LightThemeColors.blackColor, fontSize: FontSize.s16),

        //
        titleLarge: TextStylesManager.tajawalMedium.copyWith(
            color: LightThemeColors.loginTitle, fontSize: FontSize.s16),
        titleMedium: TextStylesManager.tajawalRegular.copyWith(
            color: LightThemeColors.loginTitle, fontSize: FontSize.s16),
        titleSmall: TextStylesManager.tajawalRegular.copyWith(
            color: LightThemeColors.takeWayColor, fontSize: FontSize.s16),
        //
        labelLarge: TextStylesManager.tajawalMedium.copyWith(
            color: LightThemeColors.primaryColorLight1, fontSize: FontSize.s16),
        labelMedium: TextStylesManager.tajawalRegular.copyWith(
            color: LightThemeColors.primaryColor, fontSize: FontSize.s16),
        labelSmall: TextStylesManager.tajawalRegular.copyWith(
            color: LightThemeColors.centerText, fontSize: FontSize.s12),

        // displayLarge: TextStylesManager.poppinsRegular.copyWith(color: LightThemeColors.loginTitle, fontSize: FontSize.s16),
        displayLarge: TextStylesManager.tajawalSemiBold.copyWith(
            color: LightThemeColors.hintColor, fontSize: FontSize.s18),
        displayMedium: TextStylesManager.tajawalRegular.copyWith(
            color: LightThemeColors.linearFirstColor, fontSize: FontSize.s14),
        displaySmall: TextStylesManager.tajawalMedium.copyWith(
            color: LightThemeColors.hintColor2, fontSize: FontSize.s12),
      ),
      // Colors Theme
      dividerColor: LightThemeColors.dividerColor,
      splashColor: Colors.white,

      //  bottomNavigationBarTheme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          selectedLabelStyle: TextStylesManager.tajawalRegular.copyWith(
              color: LightThemeColors.primaryColor,
              fontSize: FontSize.s10,
              height: 1.29),
          unselectedLabelStyle: TextStylesManager.tajawalRegular.copyWith(
              color: LightThemeColors.hintColor,
              fontSize: FontSize.s10,
              height: 1.29)),
      //*ElevatedButtonThemeData
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: AppThemeManager.elevatedButtonStyleTheme(
              buttonColor: LightThemeColors.primaryColor,
              textColor: Colors.white)),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
          // content padding

          filled: true,
          fillColor: LightThemeColors.colorWhite,
          contentPadding: EdgeInsets.symmetric(
              horizontal: AppPadding.p10.w, vertical: AppPadding.p18.h),
          iconColor: LightThemeColors.iconTextFieldColor,
          prefixIconColor: LightThemeColors.iconTextFieldColor,
          isDense: true,
          //isCollapsed: true,
          // hint style
          hintStyle: TextStylesManager.tajawalRegular.copyWith(
              color: LightThemeColors.hintColor, fontSize: FontSize.s20),
          labelStyle: TextStylesManager.tajawalRegular.copyWith(
              color: LightThemeColors.hintColor, fontSize: FontSize.s20),
          errorStyle: TextStylesManager.tajawalSemiBold.copyWith(
              color: LightThemeColors.redLightColor, fontSize: FontSize.s12),

          /// floatingLabelStyle: StyleFonts.cairoRegular.copyWith(color: ColorManager.dark85, fontSize: FontSize.s17),
          // enabled border style

          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: AppSize.s1, color: LightThemeColors.hintColor),
              borderRadius: BorderRadius.all(Radius.circular(AppRaduis.r8))),
          //  disabled border style
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: AppSize.s1, color: LightThemeColors.hintColor),
              borderRadius: BorderRadius.all(Radius.circular(AppRaduis.r8))),
          // focused border style
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: AppSize.s1, color: LightThemeColors.primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(AppRaduis.r8))),

          // error border style
          errorBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: AppSize.s1, color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(AppRaduis.r8))),
          // focused border style
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: AppSize.s1, color: LightThemeColors.primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(AppRaduis.r8)))));
}
