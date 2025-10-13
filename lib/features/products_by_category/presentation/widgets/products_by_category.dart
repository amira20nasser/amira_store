import 'package:amira_store/core/widgets/loading_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/domain/entities/product_entity.dart';
import '../../../../core/widgets/empty_body.dart';
import '../../../../core/widgets/error_view.dart';
import '../manager/products_by_category_cubit.dart';
import 'products_grid_view.dart';

class ProductsByCategoryBlocBuilder extends StatelessWidget {
  const ProductsByCategoryBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsByCategoryCubit, ProductsByCategoryState>(
      builder: (context, state) {
        if (state is ProductsByCategoryLoading) {
          return SliverToBoxAdapter(child: LoadingBody(msg: ''));
        }

        if (state is ProductsByCategoryError) {
          return SliverToBoxAdapter(child: ErrorBody(message: state.message));
        }

        List<ProductEntity> products = [];
        if (state is ProductsByCategoryLoaded) {
          products = state.products;
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
