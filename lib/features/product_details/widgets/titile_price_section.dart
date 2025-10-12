import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/formatter.dart';
import '../../home/domain/entities/product_entity.dart';

class TitleAndPriceSection extends StatelessWidget {
  const TitleAndPriceSection({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final priceStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.name, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              "\$${formatMoney(product.cost * (1 - product.reductionPercentage / 100))}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: priceStyle,
            ),
            const SizedBox(width: 10),
            Text(
              formatMoney(product.cost),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.blackColor80,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '-${product.reductionPercentage.toStringAsFixed(1)}%',
              style: TextStyle(
                color: AppColors.errorColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 20),
            const SizedBox(width: 4),
            Text(product.stars.toStringAsFixed(1)),
          ],
        ),
      ],
    );
  }
}
