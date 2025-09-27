import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' show GoRouter;

import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/shared_pref_keys.dart';
import '../../../../core/services/shared_preferences_service.dart';

class TextButtonSkip extends StatelessWidget {
  const TextButtonSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        var router = GoRouter.of(context);
        final prefs = SharedPreferencesService();
        await prefs.setBool(SharedPrefKeys.onboardingSeen, true);

        router.pushReplacement(ConstantRoutes.logInViewRoute);
      },
      child: Text("Skip", style: Theme.of(context).textTheme.bodyLarge),
    );
  }
}
