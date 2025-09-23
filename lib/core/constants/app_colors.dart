import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const Color primaryColor = Color(0xFFD16FFF); // Vibrant pink-magenta
  static const MaterialColor primaryMaterialColor = MaterialColor(
    0xFFD16FFF,
    <int, Color>{
      50: Color(0xFFF4E6FF), // very light lavender
      100: Color(0xFFE6CCFF), // soft pastel purple
      200: Color(0xFFD9B3FF), // light orchid
      300: Color(0xFFCC99FF), // medium lavender
      400: Color(0xFFBF80FF), // vibrant lilac
      500: Color(0xFFD16FFF), // primary pinkish-purple
      600: Color(0xFFB85FE6), // slightly deeper tone
      700: Color(0xFF9E4FCC), // rich purple
      800: Color(0xFF843FB3), // deep violet
      900: Color(0xFF6A2F99), // bold plum
    },
  );

  static const Color blackColor = Color(0xFF16161E);
  static const Color blackColor80 = Color(0xFF45454B);
  static const Color blackColor60 = Color(0xFF737378);
  static const Color blackColor40 = Color(0xFFA2A2A5);
  static const Color blackColor20 = Color(0xFFD0D0D2);
  static const Color blackColor10 = Color(0xFFE8E8E9);
  static const Color blackColor5 = Color(0xFFF3F3F4);

  static const Color whiteColor = Colors.white;
  static const Color whileColor80 = Color(0xFFCCCCCC);
  static const Color whileColor60 = Color(0xFF999999);
  static const Color whileColor40 = Color(0xFF666666);
  static const Color whileColor20 = Color(0xFF333333);
  static const Color whileColor10 = Color(0xFF191919);
  static const Color whileColor5 = Color(0xFF0D0D0D);

  static const Color greyColor = Color(0xFFB8B5C3);
  static const Color lightGreyColor = Color(0xFFF8F8F9);
  static const Color darkGreyColor = Color(0xFF1C1C25);

  static const Color pinkMegentaColor = Color(0xFFD16FFF);
  static const Color successColor = Color(0xFF2ED573);
  static const Color warningColor = Color(0xFFFFBE21);
  static const Color errorColor = Color(0xFFEA5B5B);
}
