import 'package:amira_store/core/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../categories/domain/entities/category_entity.dart';
import 'category_item.dart';

class CategoryGridView extends StatelessWidget {
  final List<CategoryEntity> categories;

  const CategoryGridView({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      // physics: const NeverScrollableScrollPhysics(),
      // shrinkWrap: true,
      // padding: EdgeInsets.zero,
      delegate: SliverChildBuilderDelegate(childCount: 8, (context, index) {
        var category = categories[index];
        return InkWell(
          onTap: () => GoRouter.of(context).push(
            ConstantRoutes.categoryList + ConstantRoutes.productsByCategory,
            extra: category.name,
          ),
          child: CategoryItem(category: category),
        );
      }),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 95,
        childAspectRatio: 79 / 100,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
    );
  }
}
