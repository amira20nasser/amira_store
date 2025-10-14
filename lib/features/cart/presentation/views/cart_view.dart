import 'package:amira_store/core/di/di_imports.dart';
import 'package:amira_store/core/widgets/empty_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/image_assets.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/error_view.dart';
import '../../domain/repos/cart_repo.dart';
import '../manager/cart_cubit.dart';
import '../widgets/cart_app_bar_body.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CartCubit(ServiceLocator.get<CartRepo>())..getCartItems(),
      child: Column(
        children: [
          CustomAppBar(appBarHeight: 120, child: CartAppBarBody()),

          Expanded(child: CartBlocBuilder()),
        ],
      ),
    );
  }
}

class CartBlocBuilder extends StatelessWidget {
  const CartBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartInitial) {
          return Center(
            child: EmptyView(
              msg: 'Your Haven\'t Added\nAny Products To Cart Yet!',
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
        List cartItems = [];
        if (state is CartLoaded) {
          cartItems = state.cartItems;
        }
        if (cartItems.isEmpty) {
          return EmptyView(
            msg: 'Your Haven\'t Added\nAny Products To Cart Yet!',
            imagePath: Assets.assetsImagesEmptyCart,
          );
        } else {
          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text('Quantity: ${item.quantity}'),
                trailing: Text('\$${item.price * item.quantity}'),
              );
            },
          );
        }
      },
    );
  }
}
