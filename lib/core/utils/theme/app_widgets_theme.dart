import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

abstract class AppWidgetTheme {
  static const InputDecorationTheme lightInputDecorationTheme =
      InputDecorationTheme(
        errorStyle: TextStyle(color: AppColors.errorColor),
        fillColor: AppColors.lightGreyColor,
        filled: true,
        prefixIconColor: AppColors.greyColor,
        suffixIconColor: AppColors.greyColor,

        hintStyle: TextStyle(color: AppColors.greyColor),
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: focusedOutlineInputBorder,
        errorBorder: errorOutlineInputBorder,
      );

  static const InputDecorationTheme darkInputDecorationTheme =
      InputDecorationTheme(
        fillColor: AppColors.darkGreyColor,
        filled: true,
        hintStyle: TextStyle(color: AppColors.whiteColor40),
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: focusedOutlineInputBorder,
        errorBorder: errorOutlineInputBorder,
      );

  static const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(AppSizes.defaultBorderRadius),
    ),
    borderSide: BorderSide(color: Colors.transparent),
  );

  static const OutlineInputBorder focusedOutlineInputBorder =
      OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppSizes.defaultBorderRadius),
        ),
        borderSide: BorderSide(color: AppColors.primaryColor),
      );

  static const OutlineInputBorder errorOutlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(AppSizes.defaultBorderRadius),
    ),
    borderSide: BorderSide(color: AppColors.errorColor),
  );

  OutlineInputBorder secodaryOutlineInputBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(AppSizes.defaultBorderRadius),
      ),
      borderSide: BorderSide(
        color: Theme.of(
          context,
        ).textTheme.bodyLarge!.color!.withValues(alpha: 0.15),
      ),
    );
  }

  static final CheckboxThemeData checkboxThemeData = CheckboxThemeData(
    checkColor: WidgetStateProperty.all(Colors.white),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(AppSizes.defaultBorderRadius / 2),
      ),
    ),
    side: const BorderSide(color: AppColors.blackColor40),
  );
  static final ElevatedButtonThemeData elevatedButtonThemeData =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(AppSizes.defaultPadding),
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 32),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppSizes.defaultBorderRadius),
            ),
          ),
        ),
      );
  static final IconButtonThemeData iconButtonThemeData = IconButtonThemeData(
    style: IconButton.styleFrom(foregroundColor: AppColors.primaryColor),
  );
  static final textButtonThemeData = TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: AppColors.primaryColor),
  );

  static OutlinedButtonThemeData outlinedButtonTheme({
    Color borderColor = AppColors.blackColor10,
  }) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(AppSizes.defaultPadding),
        minimumSize: const Size(double.infinity, 32),
        side: BorderSide(width: 1.5, color: borderColor),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppSizes.defaultBorderRadius),
          ),
        ),
      ),
    );
  }

  static const AppBarTheme appBarLightTheme = AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColors.blackColor),
    titleTextStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.blackColor,
    ),
  );

  static const AppBarTheme appBarDarkTheme = AppBarTheme(
    backgroundColor: AppColors.blackColor,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );
  static ScrollbarThemeData scrollbarThemeData = ScrollbarThemeData(
    trackColor: WidgetStateProperty.all(AppColors.primaryColor),
  );
  static DataTableThemeData dataTableLightThemeData = DataTableThemeData(
    columnSpacing: 24,
    headingRowColor: WidgetStateProperty.all(Colors.black12),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(AppSizes.defaultBorderRadius),
      ),
      border: Border.all(color: Colors.black12),
    ),
    dataTextStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.blackColor,
    ),
  );

  static DataTableThemeData dataTableDarkThemeData = DataTableThemeData(
    columnSpacing: 24,
    headingRowColor: WidgetStateProperty.all(Colors.white10),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(AppSizes.defaultBorderRadius),
      ),
      border: Border.all(color: Colors.white10),
    ),
    dataTextStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.white,
      fontSize: 12,
    ),
  );

  static DialogThemeData lightDialogThemeData = DialogThemeData(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  );
  static DialogThemeData darkDialogThemeData = DialogThemeData(
    backgroundColor: AppColors.darkGreyColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  );
}
