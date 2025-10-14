import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: AppColors.whiteColor,
      style: IconButton.styleFrom(
        backgroundColor: AppColors.primaryMaterialColor.shade500,
      ),
      onPressed: () {},
      icon: Icon(Icons.add_shopping_cart_rounded),
    );
  }
}
