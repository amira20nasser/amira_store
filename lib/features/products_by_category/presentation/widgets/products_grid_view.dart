import 'package:flutter/material.dart';

import '../../../home/domain/entities/product_entity.dart';
import '../../../home/presentation/widgets/product_item.dart';

class ProductsGridView extends StatelessWidget {
  final List<ProductEntity> products;

  const ProductsGridView({
    super.key,
    required this.products,
    this.isPaginating = false,
  });
  final bool isPaginating;
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        childCount: isPaginating ? products.length + 1 : products.length,
        (context, index) => index < products.length
            ? ProductItemWidget(product: products[index])
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
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
