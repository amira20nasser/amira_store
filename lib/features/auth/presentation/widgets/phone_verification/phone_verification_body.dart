import 'package:flutter/material.dart';
import '../../../../../core/constants/app_sizes.dart';
import 'blocbuilder_phone_verification.dart';

class PhoneVerificationBody extends StatelessWidget {
  const PhoneVerificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.defaultBorderRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilderPhoneVerification(),
          ),
        ),
      ),
    );
  }
}
