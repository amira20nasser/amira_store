import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/add_cart/add_to_cart.dart';
import '../../home/domain/entities/product_entity.dart';

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
        // IconButton(
        //   color: AppColors.whiteColor,
        //   style: IconButton.styleFrom(backgroundColor: AppColors.primaryColor),
        //   onPressed: () {
        //   },
        //   icon: Icon(FontAwesomeIcons.heart),
        // ),
        const SizedBox(width: 10),
        AddToCartButton(product: product),
        SizedBox(width: 8),
      ],
    );
  }
}
