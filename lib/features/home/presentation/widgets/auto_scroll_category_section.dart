import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/widgets/auto_scroll_carousel_view.dart';
import '../../../categories/domain/entities/category_entity.dart';
import '../../../categories/presentation/manager/category_cubit.dart';
import '../../../../core/widgets/empty_body.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../categories/presentation/widgets/category_modern_item.dart';

class AutoScrollCategorySection extends StatelessWidget {
  const AutoScrollCategorySection({super.key});

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

        return SliverToBoxAdapter(
          child: AutoScrollCarouselView(
            maxHeight: MediaQuery.sizeOf(context).height * 0.3,
            onTapChild: (value) {
              context.push(
                ConstantRoutes.categoryList + ConstantRoutes.productsByCategory,
                extra: categories[value].name,
              );
            },
            items: List.generate(
              categories.length,
              (index) => CategoryModernItem(category: categories[index]),
            ),
          ),
        );
      },
    );
  }
}
