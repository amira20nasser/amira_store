import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/product_entity.dart';
import 'add_to_cart_widget.dart';

class StackedProductItems extends StatelessWidget {
  const StackedProductItems({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // add Button
        Align(alignment: Alignment.topRight, child: AddToCartWidget()),

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
        Center(
          child: Image.network(
            product.thumbnailUrl,
            height: 140,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.image_not_supported),
          ),
        ),
      ],
    );
  }
}
