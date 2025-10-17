import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';
import '../../domain/entities/product_entity.dart';
import 'info_product_item.dart';
import 'stacked_product_items.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          ConstantRoutes.home + ConstantRoutes.productDetails,
          extra: product,
        );
      },
      child: Hero(
        tag: 'product-${product.productId}',
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          margin: EdgeInsets.only(right: 8),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: AppColors.blackColor40),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: StackedProductItems(product: product)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: InfoProductItem(product: product),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
