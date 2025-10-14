import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/cart/domain/entities/cart_item_entity.dart';
import '../../features/cart/presentation/manager/cart_cubit.dart';
import '../../features/home/domain/entities/product_entity.dart';
import '../constants/app_colors.dart';
import 'snack_bar.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return AddToCartBlocConsumer(product: product);
  }
}

class AddToCartBlocConsumer extends StatelessWidget {
  const AddToCartBlocConsumer({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBarTypes.errorSnackBar(message: state.message));
        } else if ((state is AddedToCartSuccess &&
                state.itemId == product.productId.toString() ||
            state is RemovedFromCartSuccess &&
                state.itemId == product.productId.toString())) {
          final message = state is AddedToCartSuccess
              ? 'Added to cart successfully!'
              : 'Removed from cart!';
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBarTypes.successSnackBar(message: message));
        }
      },
      builder: (context, state) {
        // I want these two lines implement only when the application is opened
        bool isInCart = false;
        if (CartCubit.numberOfCallingData == 1) {
          final cartItems = state is CartLoaded ? state.cartItems : [];
          isInCart = cartItems.any((item) => item.id == product.productId);
        }
        //
        if (state is CartActionInProgress &&
            state.productId == product.productId.toString()) {
          return const SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: Colors.grey,
            ),
          );
        }

        if ((state is AddedToCartSuccess &&
                state.itemId == product.productId.toString()) ||
            isInCart) {
          return IconButton(
            style: IconButton.styleFrom(
              backgroundColor: AppColors.primaryMaterialColor.shade300,
            ),
            color: AppColors.whiteColor,
            onPressed: () {
              context.read<CartCubit>().removeItemFromCart(
                product.productId.toString(),
              );
            },
            icon: const Icon(Icons.remove_circle_rounded),
          );
        }

        // 🛒 Default “add to cart” button
        return IconButton(
          style: IconButton.styleFrom(backgroundColor: AppColors.primaryColor),
          color: AppColors.whiteColor,
          onPressed: () {
            final item = CartItemEntity(
              id: product.productId,
              name: product.name,
              price: product.cost * (1 - product.reductionPercentage / 100),
              category: product.cat,
              minOrder: int.parse(product.minOrderQuantity),
              quantity: 1,
              imageUrl: product.thumbnailUrl,
            );
            context.read<CartCubit>().addItemToCart(item);
          },
          icon: const Icon(Icons.add_shopping_cart_rounded),
        );
      },
    );
  }
}
