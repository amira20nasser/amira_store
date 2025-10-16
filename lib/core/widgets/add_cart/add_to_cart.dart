import 'package:flutter/material.dart';

import '../../../features/home/domain/entities/product_entity.dart';
import 'add_to_cart_bloc_builder.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return AddToCartBlocBuilder(product: product);
  }
}
