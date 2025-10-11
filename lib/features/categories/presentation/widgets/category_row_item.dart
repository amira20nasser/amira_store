import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_routes.dart';
import '../../domain/entities/category_entity.dart';

class CategoryRowItem extends StatelessWidget {
  const CategoryRowItem({super.key, required this.category});
  final CategoryEntity category;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(ConstantRoutes.productsByCategory, extra: category.name);
      },
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(category.imageUrl),
                  fit: BoxFit.fill,
                  onError: (exception, stackTrace) =>
                      Icon(Icons.broken_image_outlined),
                ),
              ),
            ),
          ),
          Text(category.name, style: Theme.of(context).textTheme.labelMedium),
          Spacer(),
          Icon(FontAwesomeIcons.chevronRight, size: 20),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}
