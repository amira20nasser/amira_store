import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import 'app_widgets_theme.dart';

class AppTheme {
  static const _kFontFamily = "Plus Jakarta";
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primaryColor,
      ),
      brightness: Brightness.light,
      fontFamily: _kFontFamily,
      primarySwatch: AppColors.primaryMaterialColor,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: AppColors.blackColor),

      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: AppColors.blackColor60),
      ),
      elevatedButtonTheme: AppWidgetTheme.elevatedButtonThemeData,
      iconButtonTheme: AppWidgetTheme.iconButtonThemeData,
      textButtonTheme: AppWidgetTheme.textButtonThemeData,
      outlinedButtonTheme: AppWidgetTheme.outlinedButtonTheme(),
      inputDecorationTheme: AppWidgetTheme.lightInputDecorationTheme,
      checkboxTheme: AppWidgetTheme.checkboxThemeData.copyWith(
        side: const BorderSide(color: AppColors.blackColor40),
      ),
      appBarTheme: AppWidgetTheme.appBarLightTheme,
      scrollbarTheme: AppWidgetTheme.scrollbarThemeData,
      dataTableTheme: AppWidgetTheme.dataTableLightThemeData,
      dialogTheme: AppWidgetTheme.lightDialogThemeData,
    );
  }
}
