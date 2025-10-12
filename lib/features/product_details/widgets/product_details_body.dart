import 'package:flutter/material.dart';
import 'auto_scroll_carousel.dart';
import '../../../features/home/domain/entities/product_entity.dart';
import 'description_section.dart';
import 'expandable_section.dart';
import 'info_in_row.dart';
import 'reviews_section.dart';
import 'titile_price_section.dart';

class ProductDetailsBody extends StatelessWidget {
  const ProductDetailsBody({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Hero(
            tag: 'product-${product.productId}',
            child: AutoScrollCarousel(imageUrls: product.imageUrls),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TitleAndPriceSection(product: product),
          ),
        ),
        if (product.overview.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: DescriptionSection(description: product.overview),
            ),
          ),

        SliverToBoxAdapter(
          child: ExpandableSection(
            title: 'Product Specifications',
            children: [
              InfoInRow('Brand', product.brandName),
              InfoInRow('Category', product.cat),
              InfoInRow('SKU', product.skuProduct),
              InfoInRow('Weight', '${product.weightProduct} kg'),
              InfoInRow('Dimensions', product.dimensionsProduct),
              InfoInRow('Minimum Order Quantity', product.minOrderQuantity),
              InfoInRow('Warranty', product.warrantyInfo),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: ExpandableSection(
            title: 'Shipping & Return',
            children: [
              InfoInRow('Shipping', product.shippingInfo),
              InfoInRow('Return Policy', product.policy),
              InfoInRow('Availability', product.availableStatus),
            ],
          ),
        ),

        // --- Reviews Section ---
        SliverToBoxAdapter(
          child: ReviewsSection(reviews: product.customersReviews),
        ),
      ],
    );
  }
}
