import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/app_colors.dart';

abstract class SnackBarTypes {
  static SnackBar successSnackBar({required String message}) {
    return SnackBar(
      content: Row(
        children: [
          Icon(FontAwesomeIcons.check, color: Colors.white),
          SizedBox(width: 10),
          Expanded(
            child: Text(message, style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      backgroundColor: AppColors.primaryColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 3),
      dismissDirection: DismissDirection.horizontal,
    );
  }

  static SnackBar warningSnackBar({message = ''}) {
    return SnackBar(
      content: Row(
        children: [
          Icon(FontAwesomeIcons.triangleExclamation, color: Colors.white),
          SizedBox(width: 10),
          Expanded(
            child: Text(message, style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      backgroundColor: Colors.black54,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(20),
      duration: const Duration(seconds: 3),
      dismissDirection: DismissDirection.horizontal,
    );
  }

  static SnackBar errorSnackBar({message = ''}) {
    return SnackBar(
      content: Row(
        children: [
          Icon(FontAwesomeIcons.bug, color: Colors.white),
          SizedBox(width: 10),
          Expanded(
            child: Text(message, style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      backgroundColor: AppColors.errorColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(20),
      duration: const Duration(seconds: 3),
      dismissDirection: DismissDirection.horizontal,
    );
  }
}
