import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' show GoRouter;

import '../../../../core/constants/app_routes.dart';

class TextButtonSkip extends StatelessWidget {
  const TextButtonSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        GoRouter.of(context).pushNamed(ConstantRoutes.logInViewRoute);
      },
      child: Text("Skip", style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}
