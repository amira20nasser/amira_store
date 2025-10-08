import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/formatter.dart';
import '../../domain/entities/product_entity.dart';

class InfoProductItem extends StatelessWidget {
  const InfoProductItem({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final discountedPrice =
        product.cost * (1 - product.reductionPercentage / 100);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Product Image
        SizedBox(
          height: 30,
          child: Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // const SizedBox(height: 4),
        Row(
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Icon(
                FontAwesomeIcons.solidStar,
                color: AppColors.warningColor,
                size: 18,
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "  ${product.stars.toStringAsFixed(1)}",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.warningColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        // const SizedBox(height: 4),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            children: [
              Text(
                "\$${formatMoney(discountedPrice)}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (product.reductionPercentage > 0) ...[
                const SizedBox(width: 6),
                Text(
                  "\$${formatMoney(product.cost)}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.blackColor80,
                    decoration: TextDecoration.lineThrough,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
