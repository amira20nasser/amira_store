import 'package:amira_store/core/utils/logging/logger_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/domain/entities/product_entity.dart';
import '../../../home/presentation/widgets/empty_view.dart';
import '../../../home/presentation/widgets/error_view.dart';
import '../../../products_by_category/presentation/widgets/products_grid_view.dart';
import '../manager/search_products_cubit.dart';

class SearchProductsBlocBuilder extends StatelessWidget {
  const SearchProductsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchProductsCubit, SearchProductsState>(
      builder: (context, state) {
        if (state is SearchProductsInitial) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsetsGeometry.all(16),
              child: Text('Start searching for products'),
            ),
          );
        }
        if (state is SearchProductsLoading) {
          return SliverToBoxAdapter(
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is SearchProductsError) {
          return SliverToBoxAdapter(child: ErrorView(message: state.message));
        }

        List<ProductEntity> products = [];
        if (state is SearchProductsLoaded) {
          products = state.products;
          LoggerHelper.debug('Loaded products count: ${products.length}');
        }
        if (products.isEmpty) {
          return SliverToBoxAdapter(
            child: EmptyView(msg: 'No Products Available'),
          );
        }
        return ProductsGridView(products: products);
      },
    );
  }
}
