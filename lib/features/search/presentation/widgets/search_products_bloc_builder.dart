import 'package:amira_store/core/utils/logging/logger_helper.dart';
import 'package:amira_store/core/widgets/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/domain/entities/product_entity.dart';
import '../../../../core/widgets/empty_body.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../products_by_category/presentation/widgets/products_grid_view.dart';
import '../manager/search_products_cubit.dart';
import 'start_searching_body.dart';

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
              child: StartSearchingBody(),
            ),
          );
        }
        if (state is SearchProductsLoading) {
          return SliverToBoxAdapter(child: LoadingBody(msg: ''));
        }

        if (state is SearchProductsError) {
          return SliverToBoxAdapter(child: ErrorBody(message: state.message));
        }

        List<ProductEntity> products = [];
        if (state is SearchProductsLoaded) {
          products = state.products;
          LoggerHelper.debug('Loaded products count: ${products.length}');
        }
        if (products.isEmpty) {
          return SliverToBoxAdapter(
            child: EmptyView(
              msg: 'No Products Available! try search another term',
            ),
          );
        }
        return ProductsGridView(products: products);
      },
    );
  }
}
