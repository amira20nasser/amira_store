import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/add_cart/add_to_cart.dart';
import '../../domain/entities/product_entity.dart';

class StackedProductItems extends StatelessWidget {
  const StackedProductItems({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // add Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Align(
            alignment: Alignment.topRight,
            child: AddToCartButton(product: product),
          ),
        ),

        // -
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(left: 8, top: 8),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(12),
            ),
            color: AppColors.errorColor.withValues(alpha: 0.2),
          ),
          child: Text(
            "-${product.reductionPercentage.toStringAsFixed(0)}%",
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.errorColor),
          ),
        ),
        // image
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Image.network(
              product.thumbnailUrl,
              height: 110,
              fit: BoxFit.fitHeight,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.image_not_supported),
            ),
          ),
        ),
      ],
    );
  }
}
