import 'package:flutter/material.dart';

import '../../../home/domain/entities/product_entity.dart';
import '../../../home/presentation/widgets/product_item.dart';

class ProductsGridView extends StatelessWidget {
  final List<ProductEntity> products;

  const ProductsGridView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        childCount: products.length,
        (context, index) => ProductItemWidget(product: products[index]),
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        // You can adjust the maxCrossAxisExtent to control the number of columns
        // You can change these Values
        maxCrossAxisExtent: 190,
        childAspectRatio: 0.82,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
    );
  }
}
