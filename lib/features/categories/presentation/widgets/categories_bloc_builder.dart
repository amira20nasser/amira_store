import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/presentation/widgets/empty_view.dart';
import '../../../home/presentation/widgets/error_view.dart';
import '../../domain/entities/category_entity.dart';
import '../manager/category_cubit.dart';
import 'categories_body.dart';

class CategoriesBlocBuilder extends StatelessWidget {
  const CategoriesBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CategoryFailure) {
          return ErrorView(message: state.msg);
        }

        List<CategoryEntity> categories = [];
        if (state is CategorySuccess) categories = state.categories;
        if (categories.isEmpty) {
          return const EmptyView(msg: 'No categories available.');
        }
        return CategoriesBody(categories: categories);
      },
    );
  }
}
