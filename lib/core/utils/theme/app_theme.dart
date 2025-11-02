import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import 'app_widgets_theme.dart';

class AppTheme {
  static const _kFontFamily = "Plus Jakarta";
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primaryColor,
      ),
      fontFamily: _kFontFamily,
      primarySwatch: AppColors.primaryMaterialColor,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.whiteColor,
      iconTheme: const IconThemeData(color: AppColors.blackColor),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.whiteColor,
        elevation: 10,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),

      // for Dark Theme
      // bottomAppBarTheme: const BottomAppBarThemeData(
      //   color: AppColors.blackColor,
      //   elevation: 8,
      // ),
      // floatingActionButtonTheme: const FloatingActionButtonThemeData(
      //   backgroundColor: AppColors.primaryColor,
      //   foregroundColor: Colors.white,
      // ),
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

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primaryColor,
      ),
      fontFamily: _kFontFamily,
      primarySwatch: AppColors.primaryMaterialColor,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.blackColor,
      iconTheme: const IconThemeData(color: AppColors.whiteColor),
      bottomAppBarTheme: const BottomAppBarThemeData(
        color: AppColors.blackColor,
        elevation: 10,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
      // textTheme: const TextTheme(
      //   bodyMedium: TextStyle(color: AppColors.blackColor60),
      // ),
      elevatedButtonTheme: AppWidgetTheme.elevatedButtonThemeData,
      iconButtonTheme: AppWidgetTheme.iconButtonThemeData,
      textButtonTheme: AppWidgetTheme.textButtonThemeData,
      outlinedButtonTheme: AppWidgetTheme.outlinedButtonTheme(),
      inputDecorationTheme: AppWidgetTheme.darkInputDecorationTheme,
      checkboxTheme: AppWidgetTheme.checkboxThemeData.copyWith(
        side: const BorderSide(color: AppColors.blackColor40),
      ),
      appBarTheme: AppWidgetTheme.appBarDarkTheme,
      scrollbarTheme: AppWidgetTheme.scrollbarThemeData,
      dataTableTheme: AppWidgetTheme.dataTableDarkThemeData,
      dialogTheme: AppWidgetTheme.darkDialogThemeData,
    );
  }
}
