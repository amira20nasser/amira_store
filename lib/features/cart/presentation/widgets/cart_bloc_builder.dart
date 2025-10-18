import 'package:amira_store/features/cart/presentation/manager/cart_items_cubit/cart_items_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/image_assets.dart';
import '../../../../core/widgets/empty_body.dart';
import '../../../../core/widgets/error_view.dart';
import '../../domain/entities/cart_item_entity.dart';
import 'cart_list_view.dart';

class CartBlocBuilder extends StatelessWidget {
  const CartBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartItemsCubit, CartItemsState>(
      builder: (context, state) {
        if (state is CartItemsInitial) {
          return Center(
            child: EmptyView(
              msg: 'Go to home and search for products',
              imagePath: Assets.assetsImagesEmptyCart,
            ),
          );
        }
        // if (state is CartItemsLoading) {
        //   return Center(child: CircularProgressIndicator());
        // }
        if (state is CartItemsFailure) {
          return ErrorBody(message: state.msg);
        }
        List<CartItemEntity> cartItems = BlocProvider.of<CartItemsCubit>(
          context,
        ).items;

        if (cartItems.isEmpty) {
          return EmptyView(
            msg: 'Go to home and search for products',
            imagePath: Assets.assetsImagesEmptyCart,
          );
        }
        return CartListView(cartItems: cartItems);
      },
    );
  }
}
