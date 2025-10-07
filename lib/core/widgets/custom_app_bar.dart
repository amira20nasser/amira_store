import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.child,
    required this.appBarHeight,
  });
  final Widget child;
  final double appBarHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: appBarHeight,
      padding: EdgeInsets.only(top: MediaQuery.viewPaddingOf(context).top),
      decoration: BoxDecoration(
        color: AppColors.primaryMaterialColor.shade300,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: child,
    );
  }
}
