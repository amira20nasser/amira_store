import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/product_entity.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final discountedPrice =
        product.cost * (1 - product.reductionPercentage / 100);

    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.blackColor40),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Product Image
            Center(
              child: Image.network(
                product.thumbnailUrl,
                height: 130,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported),
              ),
            ),
            Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  "\$${discountedPrice.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                if (product.reductionPercentage > 0) ...[
                  const SizedBox(width: 6),
                  Text(
                    "\$${product.cost.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.blackColor80,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ],
            ),
            Row(
              children: [
                Icon(FontAwesomeIcons.solidStar, color: AppColors.warningColor),
                Text(
                  "  ${product.stars.toStringAsFixed(1)} (Reviews)  ",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.warningColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
