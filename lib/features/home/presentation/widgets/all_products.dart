import 'package:flutter/material.dart';

import '../../domain/entities/product_entity.dart';
import 'list_view_product_horizontal.dart';
import 'text_and_textbutton_inrow.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key, required this.products});
  final Map<String, List<ProductEntity>> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: products.entries.map((entry) {
        final categoryName = entry.key
            .split('-')
            .map((word) => word[0].toUpperCase() + word.substring(1))
            .join(' ');
        final categoryProducts = entry.value;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextAndTextButtonInRow(
                text: categoryName,
                onPressed: () {},
                textButton: "Show All",
              ),

              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ListViewProductHorizontal(products: categoryProducts),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
