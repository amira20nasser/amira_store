import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../categories/domain/entities/category_entity.dart';
import '../../../categories/presentation/manager/category_cubit.dart';
import 'category_grid_view.dart';
import '../../../../core/widgets/empty_body.dart';
import '../../../../core/widgets/error_view.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return SliverToBoxAdapter(
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is CategoryFailure) {
          return SliverToBoxAdapter(child: ErrorBody(message: state.msg));
        }

        List<CategoryEntity> categories = [];
        if (state is CategorySuccess) categories = state.categories;
        if (categories.isEmpty) {
          return SliverToBoxAdapter(
            child: const EmptyView(msg: 'No categories available.'),
          );
        }

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          sliver: CategoryGridView(categories: categories),
        );
      },
    );
  }
}
