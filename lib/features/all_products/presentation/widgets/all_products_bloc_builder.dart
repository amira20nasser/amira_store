import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/empty_body.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_body.dart';
import '../../../home/domain/entities/product_entity.dart';
import '../../../products_by_category/presentation/widgets/products_grid_view.dart';
import '../manager/all_products_cubit.dart';

class AllProductsBlocBuilder extends StatefulWidget {
  const AllProductsBlocBuilder({super.key});

  @override
  State<AllProductsBlocBuilder> createState() => _AllProductsBlocBuilderState();
}

class _AllProductsBlocBuilderState extends State<AllProductsBlocBuilder> {
  List<ProductEntity> products = [];
  bool isPaginating = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllProductsCubit, AllProductsState>(
      builder: (context, state) {
        isPaginating = false;
        if (state is AllProductsLoading) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 150.0),
              child: LoadingBody(msg: ''),
            ),
          );
        }
        if (state is AllProductsPaginationLoading) {
          isPaginating = true;
        }
        if (state is AllProductsError) {
          return SliverToBoxAdapter(child: ErrorBody(message: state.msg));
        }

        if (state is AllProductsSuccess) {
          products.addAll(state.products);
        }
        if (products.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 200.0),
              child: EmptyView(msg: 'No Products Available'),
            ),
          );
        }
        return ProductsGridView(products: products, isPaginating: isPaginating);
      },
    );
  }
}
