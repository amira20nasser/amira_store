import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants/app_colors.dart';

class ProductDetailsAppBarBody extends StatelessWidget {
  const ProductDetailsAppBarBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 8),
        IconButton(
          color: AppColors.whiteColor,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        const Spacer(),
        IconButton(
          color: AppColors.whiteColor,
          style: IconButton.styleFrom(backgroundColor: AppColors.primaryColor),
          onPressed: () {
            // TODO add to wishlist functionality
          },
          icon: Icon(FontAwesomeIcons.heart),
        ),
        const SizedBox(width: 10),
        IconButton(
          color: AppColors.whiteColor,
          style: IconButton.styleFrom(backgroundColor: AppColors.primaryColor),
          onPressed: () {
            // TODO add to cart functionality
          },
          icon: Icon(Icons.add_shopping_cart_rounded),
        ),
        SizedBox(width: 8),
      ],
    );
  }
}
