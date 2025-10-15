import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../manager/cart_cubit.dart';
import 'cart_item.dart';

class CartListView extends StatelessWidget {
  const CartListView({super.key, required this.cartItems});
  final List<CartItemEntity> cartItems;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];

        return Dismissible(
          key: ValueKey(item.id),
          background: Container(
            color: AppColors.errorColor,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (_) {
            context.read<CartCubit>().removeItemFromCart(item.id.toString());
          },
          child: CartItem(item: item),
        );
      },
    );
  }
}
