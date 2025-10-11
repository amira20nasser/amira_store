import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';
import '../../domain/entities/category_entity.dart';
import 'category_modern_item.dart';

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
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          GoRouter.of(context).push(
            ConstantRoutes.productsByCategory,
            extra: categories[index].name,
          );
        },
        child: CategoryModernItem(category: categories[index]),
      ),
    );
  }
}
