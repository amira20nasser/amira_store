import 'package:flutter/material.dart';

import '../../../categories/domain/entities/category_entity.dart';
import 'category_item.dart';

class CategoryGridView extends StatelessWidget {
  final List<CategoryEntity> categories;

  const CategoryGridView({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 8,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 95,
        childAspectRatio: 79 / 100,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        return CategoryItem(category: categories[index]);
      },
    );
  }
}
