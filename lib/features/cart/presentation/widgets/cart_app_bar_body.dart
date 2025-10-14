import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/cart_cubit.dart';

class CartAppBarBody extends StatelessWidget {
  const CartAppBarBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => context.read<CartCubit>().getCartItems(),
          icon: Icon(Icons.refresh),
        ),
        Text('My Cart', style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
