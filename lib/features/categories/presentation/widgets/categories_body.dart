import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/fake_search_bar.dart';
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
          appBarHeight: 150,
          child: Column(
            children: [
              Text(
                "Categories",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: FakeSearchBar(),
              ),
            ],
          ),
        ),
        Expanded(child: CategoriesListView(categories: categories)),
      ],
    );
  }
}
