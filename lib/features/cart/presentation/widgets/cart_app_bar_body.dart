import 'package:flutter/material.dart';

class CartAppBarBody extends StatelessWidget {
  const CartAppBarBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('My Cart', style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
