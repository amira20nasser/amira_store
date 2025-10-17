import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../domain/entities/category_entity.dart';
import 'categories_listview.dart';

class CategoriesBody extends StatelessWidget {
  const CategoriesBody({super.key, required this.categories});
  final List<CategoryEntity> categories;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          appBarHeight: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(Icons.arrow_back_ios_new_rounded),
              ),
              Text(
                "Categories",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
        Expanded(child: CategoriesListView(categories: categories)),
      ],
    );
  }
}
