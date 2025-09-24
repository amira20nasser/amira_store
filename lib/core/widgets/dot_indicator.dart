import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
    this.inActiveColor,
    this.activeColor = AppColors.primaryColor,
  });

  final bool isActive;

  final Color? inActiveColor, activeColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppSizes.defaultDuration,
      height: isActive ? 12 : 4,
      width: 5,
      decoration: BoxDecoration(
        color: isActive
            ? activeColor
            : inActiveColor ?? AppColors.primaryMaterialColor.shade100,
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSizes.defaultBorderRadius),
        ),
      ),
    );
  }
}
