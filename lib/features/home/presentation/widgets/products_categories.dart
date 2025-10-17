import 'package:amira_store/core/utils/logging/logger_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../domain/entities/product_entity.dart';
import 'list_view_product_horizontal.dart';
import 'text_and_textbutton_inrow.dart';

class ProductsCategories extends StatelessWidget {
  const ProductsCategories({super.key, required this.products});
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
                onPressed: () {
                  LoggerHelper.debug('Pressed on $categoryName');
                  context.push(
                    ConstantRoutes.categoryList +
                        ConstantRoutes.productsByCategory,
                    extra: categoryName,
                  );
                },
                textButton: "VIEW ALL",
              ),

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
