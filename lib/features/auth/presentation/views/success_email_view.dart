import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/widgets/success_body.dart';

class SuccessEmailView extends StatelessWidget {
  const SuccessEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SuccessBody(
            onPressed: () {
              context.pushReplacement(ConstantRoutes.profileView);
            },
            imageLottie:
                "assets/images/emailVerification/72462-check-register.json",
            title: "Your account successfully created!",
            subTitle:
                "Welcome to Your Application: Your Account is Created, Unleash the Joy of Seamless Online Experience!",
          ),
        ),
      ),
    );
  }
}
