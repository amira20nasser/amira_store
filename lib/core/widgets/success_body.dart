import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../constants/app_routes.dart';

class SuccessBody extends StatelessWidget {
  const SuccessBody({
    super.key,
    required this.imageLottie,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  });

  final String imageLottie;
  final String title;
  final String subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                context.pushReplacement(ConstantRoutes.profile);
              },
              child: const Text("Continue"),
            ),
          ),
        ],
      ),
    );
  }
}
