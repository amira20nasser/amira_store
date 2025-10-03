import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomButtonWithLoader extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final Widget widget;
  final Widget widgetLoading;
  const CustomButtonWithLoader({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.widget,
    this.widgetLoading = const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(strokeWidth: 2),
    ),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: isLoading
          ? ElevatedButton.styleFrom(
              backgroundColor: AppColors.whiteColor40,
              foregroundColor: Colors.white,
            )
          : null,
      child: isLoading ? widgetLoading : widget,
    );
  }
}
