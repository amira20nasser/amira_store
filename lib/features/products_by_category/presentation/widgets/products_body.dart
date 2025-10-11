import 'package:flutter/material.dart';

import 'products_by_category.dart';

class ProductsBody extends StatelessWidget {
  const ProductsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          sliver: ProductsByCategoryBlocBuilder(),
        ),
      ],
    );
  }
}
