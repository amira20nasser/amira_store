import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/image_assets.dart';

class ErrorBody extends StatelessWidget {
  final String message;

  const ErrorBody({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Assets.assetsImagesSad),
        Text(
          "Error: $message",
          style: const TextStyle(color: AppColors.errorColor, fontSize: 18),
        ),
      ],
    );
  }
}
