import 'package:amira_store/features/home/domain/entities/product_entity.dart';
import 'package:amira_store/features/home/presentation/widgets/empty_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/logging/logger_helper.dart';
import '../manager/home_cubit.dart';
import 'category_section.dart';
import 'error_view.dart';
import 'text_and_textbutton_inrow.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: TextAndTextButtonInRow(
            text: "Amira's Top Categories",
            onPressed: () {},
            textButton: "View All",
          ),
        ),

        // Category Section
        CategorySection(),
        // Products Section
        ProductsBlocBuilder(),
      ],
    );
  }
}

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
          LoggerHelper.debug(state.message);
          return SliverToBoxAdapter(child: ErrorView(message: state.message));
        }

        Map<String, List<ProductEntity>> products = {};
        if (state is HomeSuccess) {
          LoggerHelper.debug(
            state.categorizedProducts['skin-care']?[0].thumbnailUrl ?? "",
          );
          products = state.categorizedProducts;
        }
        if (products['skin-care']?.isEmpty ?? true) {
          LoggerHelper.debug("Empty");

          return SliverToBoxAdapter(
            child: EmptyView(msg: 'No Products Available'),
          );
        }
        // return all Product category
        return SliverToBoxAdapter(
          child: ListViewProductHorizontal(
            products: products['skin-care'] ?? [],
          ),
        );
      },
    );
  }
}

class ListViewProductHorizontal extends StatelessWidget {
  const ListViewProductHorizontal({super.key, required this.products});
  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductItem(product: products[index]);
        },
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final discountedPrice =
        product.cost * (1 - product.reductionPercentage / 100);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          // ClipRRect(
          //   borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          //   child: AspectRatio(
          //     aspectRatio: 1,
          //     child: Image.network(
          //       product.thumbnailUrl,
          //       height: 30,
          //       width: 30,
          //       fit: BoxFit.cover,
          //       errorBuilder: (context, error, stackTrace) =>
          //           const Icon(Icons.image_not_supported),
          //     ),
          //   ),
          // ),

          // Product Details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),

                // Price & Discount
                Row(
                  children: [
                    Text(
                      "\$${discountedPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    if (product.reductionPercentage > 0) ...[
                      const SizedBox(width: 6),
                      Text(
                        "\$${product.cost.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "-${product.reductionPercentage.toStringAsFixed(0)}%",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 6),

                // Rating Stars

                // RatingBarIndicator(
                //   rating: product.stars,
                //   itemBuilder: (context, _) =>
                //       const Icon(Icons.star, color: Colors.amber),
                //   itemCount: 5,
                //   itemSize: 18.0,
                //   direction: Axis.horizontal,
                // ),
                // const SizedBox(width: 6),
                Text(
                  product.stars.toStringAsFixed(1),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
