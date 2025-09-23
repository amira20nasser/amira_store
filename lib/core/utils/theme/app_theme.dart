import 'package:amira_store/core/utils/app_widgets_theme.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class AppTheme {
  static const _kFontFamily = "Plus Jakarta";
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: _kFontFamily,
      primarySwatch: AppColors.primaryMaterialColor,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: AppColors.blackColor),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: AppColors.blackColor40),
      ),
      elevatedButtonTheme: AppWidgetTheme.elevatedButtonThemeData,
      textButtonTheme: AppWidgetTheme.textButtonThemeData,
      outlinedButtonTheme: AppWidgetTheme.outlinedButtonTheme(),
      inputDecorationTheme: AppWidgetTheme.lightInputDecorationTheme,
      checkboxTheme: AppWidgetTheme.checkboxThemeData.copyWith(
        side: const BorderSide(color: AppColors.blackColor40),
      ),
      appBarTheme: AppWidgetTheme.appBarDarkTheme,
      scrollbarTheme: AppWidgetTheme.scrollbarThemeData,
      dataTableTheme: AppWidgetTheme.dataTableLightThemeData,
    );
  }
}
