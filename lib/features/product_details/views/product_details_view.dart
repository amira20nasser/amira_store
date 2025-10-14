import 'package:flutter/material.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../home/domain/entities/product_entity.dart';
import '../widgets/product_details_app_bar.dart';
import '../widgets/product_details_body.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.product});
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          appBarHeight: 120,
          child: ProductDetailsAppBarBody(product: product),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ProductDetailsBody(product: product),
          ),
        ),
      ],
    );
  }
}
