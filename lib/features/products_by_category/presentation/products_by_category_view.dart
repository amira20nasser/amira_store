import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';
import 'widgets/products_app_bar_body.dart';

class ProductsByCategoryView extends StatelessWidget {
  const ProductsByCategoryView({super.key, required this.categorySlug});
  final String categorySlug;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            appBarHeight: 180,
            child: ProductsAppBarBody(categoryName: categorySlug),
          ),
        ],
      ),
    );
  }
}
