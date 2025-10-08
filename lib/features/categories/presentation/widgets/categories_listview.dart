import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/category_entity.dart';
import 'category_Row_item.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key, required this.categories});
  final List<CategoryEntity> categories;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        endIndent: 10,
        indent: 10,
        color: AppColors.primaryMaterialColor.shade200,
      ),
      physics: BouncingScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (context, index) =>
          CategoryRowItem(category: categories[index]),
    );
  }
}
