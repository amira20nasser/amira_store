import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/image_assets.dart';
import '../../../../core/widgets/empty_body.dart';
import '../../../../core/widgets/error_view.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../manager/cart_cubit.dart';
import 'cart_list_view.dart';

class CartBlocBuilder extends StatelessWidget {
  const CartBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartInitial) {
          return Center(
            child: EmptyView(
              msg: 'Add New Products..',
              imagePath: Assets.assetsImagesEmptyCart,
            ),
          );
        }
        if (state is CartLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is CartFailure) {
          return ErrorBody(message: state.message);
        }
        List<CartItemEntity> cartItems = [];
        if (state is CartLoaded) {
          cartItems = state.cartItems;
        }
        if (cartItems.isEmpty) {
          return EmptyView(
            msg: 'Add New Products..',
            imagePath: Assets.assetsImagesEmptyCart,
          );
        }
        return CartListView(cartItems: cartItems);
      },
    );
  }
}
