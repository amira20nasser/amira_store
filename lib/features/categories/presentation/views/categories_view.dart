import 'package:flutter/material.dart';

import '../widgets/categories_bloc_builder.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return CategoriesBlocBuilder();
  }
}
