import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../constants/app_routes.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({
    super.key,
    this.imageLottie =
        "assets/images/emailVerification/72462-check-register.json",
    this.title = "Your account successfully created!",
    this.subTitle =
        "Welcome to Your Application: Your Account is Created, Unleash the Joy of Seamless Online Experience!",
    this.onPressed,
  });

  final String imageLottie, title, subTitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 42),

                /// Image
                Lottie.asset(
                  imageLottie,
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
                const SizedBox(height: 16),

                /// Title & SubTitle
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  subTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 42),

                /// Buttons
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.pushReplacement(ConstantRoutes.profileView);
                    },
                    child: const Text("Continue"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
