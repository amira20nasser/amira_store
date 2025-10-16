import 'package:flutter/material.dart';

import '../../../../core/utils/logging/logger_helper.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/cart_app_bar_body.dart';
import '../widgets/cart_body.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    LoggerHelper.debug('<---Rebuid all CartView--->');
    return Column(
      children: [
        CustomAppBar(appBarHeight: 120, child: CartAppBarBody()),

        Expanded(child: CartBody()),
        SizedBox(height: 10),
      ],
    );
  }
}
