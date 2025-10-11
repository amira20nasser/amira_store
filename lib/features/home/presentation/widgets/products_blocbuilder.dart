import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product_entity.dart';
import '../manager/home_cubit.dart';
import 'all_products.dart';
import 'empty_view.dart';
import 'error_view.dart';

class ProductsBlocBuilder extends StatelessWidget {
  const ProductsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return SliverToBoxAdapter(
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is HomeError) {
          return SliverToBoxAdapter(child: ErrorView(message: state.message));
        }

        Map<String, List<ProductEntity>> products = {};
        if (state is HomeSuccess) {
          products = state.categorizedProducts;
        }
        if (products.isEmpty) {
          return SliverToBoxAdapter(
            child: EmptyView(msg: 'No Products Available'),
          );
        }
        // return all Product category
        return SliverToBoxAdapter(child: AllProducts(products: products));
      },
    );
  }
}
