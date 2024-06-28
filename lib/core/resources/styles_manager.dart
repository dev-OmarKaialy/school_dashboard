import 'package:flutter/material.dart';

import '../config/theme/light_theme.dart';
import 'font_manager.dart';

class TextStylesManager {
  const TextStylesManager._();
  static const TextStyle tajawalRegular = TextStyle(
      fontFamily: FontConstants.fontFamily,
      fontWeight: FontWeightManager.regular);
  static const TextStyle tajawalMedium = TextStyle(
      fontFamily: FontConstants.fontFamily,
      fontWeight: FontWeightManager.medium);
  static const TextStyle tajawalSemiBold = TextStyle(
      fontFamily: FontConstants.fontFamily,
      fontWeight: FontWeightManager.semiBold);
  static const TextStyle tajawalBold = TextStyle(
      fontFamily: FontConstants.fontFamily, fontWeight: FontWeightManager.bold);
}

class ShadowStyles {
  const ShadowStyles._();
  static List<BoxShadow> containerReduisTopShadow = [
    const BoxShadow(
        color: LightThemeColors.shadowContainerColor,
        blurRadius: 20,
        offset: Offset(4, 4),
        spreadRadius: 0)
  ];
  static List<BoxShadow> categoryContainerShadow = [
    const BoxShadow(
        color: LightThemeColors.shadowCategoryColor,
        blurRadius: 4,
        offset: Offset(0, 2),
        spreadRadius: 0),
  ];
}
