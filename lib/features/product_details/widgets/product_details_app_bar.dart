import 'package:amira_store/features/home/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/add_to_cart.dart';

class ProductDetailsAppBarBody extends StatelessWidget {
  const ProductDetailsAppBarBody({super.key, required this.product});
  final ProductEntity product;
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
        AddToCartButton(product: product),
        SizedBox(width: 8),
      ],
    );
  }
}
