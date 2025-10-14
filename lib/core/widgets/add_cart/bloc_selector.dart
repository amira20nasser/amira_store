import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/cart/domain/entities/cart_item_entity.dart';
import '../../../features/cart/presentation/manager/cart_cubit.dart';
import '../../../features/home/domain/entities/product_entity.dart';
import '../../constants/app_colors.dart';

class AddToCartBlocSelector extends StatelessWidget {
  const AddToCartBlocSelector({super.key, required this.product});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartCubit, CartState, _CartButtonViewModel>(
      selector: (state) {
        final cubit = BlocProvider.of<CartCubit>(context);

        final isInCart = cubit.cartItems.any(
          (item) => item.id == product.productId,
        );

        final isLoading =
            state is CartActionInProgress &&
            state.productId == product.productId.toString();

        return _CartButtonViewModel(isInCart: isInCart, isLoading: isLoading);
      },
      builder: (context, viewModel) {
        if (viewModel.isLoading) {
          return const SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: Colors.grey,
            ),
          );
        }

        return IconButton(
          style: IconButton.styleFrom(
            backgroundColor: viewModel.isInCart
                ? AppColors.primaryMaterialColor.shade300
                : AppColors.primaryColor,
          ),
          color: AppColors.whiteColor,
          onPressed: () {
            final cubit = context.read<CartCubit>();
            if (viewModel.isInCart) {
              cubit.removeItemFromCart(product.productId.toString());
            } else {
              final item = CartItemEntity(
                id: product.productId,
                name: product.name,
                price: product.cost * (1 - product.reductionPercentage / 100),
                category: product.cat,
                minOrder: int.parse(product.minOrderQuantity),
                quantity: 1,
                imageUrl: product.thumbnailUrl,
              );
              cubit.addItemToCart(item);
            }
          },
          icon: Icon(
            viewModel.isInCart
                ? Icons.remove_circle_rounded
                : Icons.add_shopping_cart_rounded,
          ),
        );
      },
    );
  }
}

class _CartButtonViewModel {
  final bool isInCart;
  final bool isLoading;

  const _CartButtonViewModel({required this.isInCart, required this.isLoading});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _CartButtonViewModel &&
          other.isInCart == isInCart &&
          other.isLoading == isLoading;

  @override
  int get hashCode => Object.hash(isInCart, isLoading);
}
