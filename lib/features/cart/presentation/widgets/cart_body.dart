import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/formatter.dart';
import '../manager/cart_action_button_cubit.dart/cart_action_button_cubit.dart';
import '../manager/cart_items_cubit/cart_items_cubit.dart';
import 'cart_bloc_builder.dart';

class CartBody extends StatelessWidget {
  const CartBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: CartBlocBuilder()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ElevatedButton(
            onPressed: context.read<CartItemsCubit>().totalPrice > 0
                ? () {
                    context.push(ConstantRoutes.checkOut);
                    context.read<CartActionButtonCubit>().clearCart();
                  }
                : null,
            child: Text(
              "Check Out With \$${formatMoney(context.watch<CartItemsCubit>().totalPrice)}",
            ),
          ),
        ),
      ],
    );
  }
}
