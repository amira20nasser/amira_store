import 'package:amira_store/core/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../manager/cart_cubit.dart';
import '../widgets/cart_app_bar_body.dart';
import '../widgets/cart_bloc_builder.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartCubit, CartState, bool>(
      selector: (state) => state is CartLoaded,
      builder: (context, state) {
        return Column(
          children: [
            CustomAppBar(appBarHeight: 120, child: CartAppBarBody()),

            Expanded(child: CartBlocBuilder()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: context.read<CartCubit>().totalPrice > 0
                    ? () {
                        context.push(ConstantRoutes.checkOut);
                        context.read<CartCubit>().clearCart();
                      }
                    : null,
                child: Text(
                  "Check Out With \$${formatMoney(context.watch<CartCubit>().totalPrice)}",
                ),
              ),
            ),
            SizedBox(height: 45),
          ],
        );
      },
    );
  }
}
