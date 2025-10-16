import 'package:amira_store/core/widgets/add_cart/bloc_selector.dart';
import 'package:flutter/material.dart';

import '../../../features/home/domain/entities/product_entity.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return AddToCartBlocBuilder(product: product);
  }
}
