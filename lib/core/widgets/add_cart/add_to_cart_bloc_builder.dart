import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/cart/domain/entities/cart_item_entity.dart';
import '../../../features/cart/presentation/manager/cart_action_button_cubit.dart/cart_action_button_cubit.dart';
import '../../../features/cart/presentation/manager/cart_items_cubit/cart_items_cubit.dart';
import '../../../features/home/domain/entities/product_entity.dart';
import '../../constants/app_colors.dart';

class AddToCartBlocBuilder extends StatelessWidget {
  const AddToCartBlocBuilder({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartActionButtonCubit, CartActionButtonState>(
      buildWhen: (prev, curr) {
        // rebuild only if this product is affected
        final id = product.productId.toString();
        return (curr is InProgressCartActionButton && curr.productId == id) ||
            (curr is SuccessfulCartActionButton && curr.productId == id) ||
            (curr is FailedCartActionButton && curr.productId == id);
      },
      builder: (context, state) {
        final cartItems = context.select((CartItemsCubit cubit) => cubit.items);
        final isInCart = cartItems.any((item) => item.id == product.productId);
        // LoggerHelper.debug('Current state $state');
        final isLoading =
            state is InProgressCartActionButton &&
            state.productId == product.productId.toString();
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, anim) =>
              ScaleTransition(scale: anim, child: child),
          child: isLoading
              ? const SizedBox(
                  key: ValueKey('loading'),
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.grey,
                  ),
                )
              : IconButton(
                  key: ValueKey(isInCart),
                  style: IconButton.styleFrom(
                    backgroundColor: isInCart
                        ? AppColors.primaryMaterialColor.shade400
                        : AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                  ),
                  color: AppColors.whiteColor,
                  onPressed: isLoading
                      ? null
                      : () {
                          final cubit = context.read<CartActionButtonCubit>();

                          if (isInCart) {
                            cubit.removeIdFromCart(product.productId);
                          } else {
                            final item = CartItemEntity(
                              id: product.productId,
                              name: product.name,
                              price:
                                  product.cost *
                                  (1 - product.reductionPercentage / 100),
                              category: product.cat,
                              minOrder: product.minOrderQuantity,
                              quantity: product.minOrderQuantity,
                              imageUrl: product.thumbnailUrl,
                            );
                            cubit.addItemToCart(item);
                          }
                        },
                  icon: Icon(
                    isInCart
                        ? Icons.remove_circle_rounded
                        : Icons.add_shopping_cart_rounded,
                  ),
                ),
        );
      },
    );
  }
}
