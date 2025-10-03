import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import 'login_input_form.dart';

class LogInViewBody extends StatelessWidget {
  const LogInViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Log In Account",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          "Please log in with registered account",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        LogInInputForm(),
        Row(
          children: [
            Text(
              "Don't have an account yet?",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextButton(
              onPressed: () {
                GoRouter.of(
                  context,
                ).pushReplacement(ConstantRoutes.signUpViewRoute);
              },
              child: Text(
                "Sign Up",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
