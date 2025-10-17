import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/di_imports.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../domain/usecases/get_products_by_category.dart';
import '../manager/products_by_category_cubit.dart';
import '../widgets/products_app_bar_body.dart';
import '../widgets/products_body.dart';

class ProductsByCategoryView extends StatelessWidget {
  const ProductsByCategoryView({super.key, required this.categorySlug});
  final String categorySlug;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            ProductsByCategoryCubit(ServiceLocator.get<GetProductsByCategory>())
              ..fetchProducts(categorySlug),
        child: Column(
          children: [
            CustomAppBar(
              appBarHeight: 120,
              child: ProductsAppBarBody(categoryName: categorySlug),
            ),
            Expanded(child: ProductsBody()),
          ],
        ),
      ),
    );
  }
}
