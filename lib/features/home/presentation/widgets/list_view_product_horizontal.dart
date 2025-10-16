import 'package:flutter/material.dart';
import '../../domain/entities/product_entity.dart';
import 'product_item.dart';

class ListViewProductHorizontal extends StatelessWidget {
  const ListViewProductHorizontal({super.key, required this.products});
  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 190,
            child: ProductItem(product: products[index]),
          );
        },
      ),
    );
  }
}
