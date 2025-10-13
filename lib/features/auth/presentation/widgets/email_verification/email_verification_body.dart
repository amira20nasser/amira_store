import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/image_assets.dart';
import '../../manager/email_verification/email_verification_cubit.dart';

class EmailVerificationBody extends StatelessWidget {
  const EmailVerificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 250,
            child: Theme.of(context).brightness == Brightness.dark
                ? Image.asset(
                    Assets
                        .assetsImagesEmailVerificationSammyLineManReceivesAMail,
                  )
                : SvgPicture.asset(
                    Assets.assetsImagesEmailVerificationEmailSent,
                  ),
          ),

          const SizedBox(height: AppSizes.defaultPadding),
          Text(
            'Verify Your e-mail address',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: AppSizes.defaultPadding),
          Text(
            "Congratulations! Your Account Awaits: Verify Your Email to Start Shopping and Experience a World of Unrivaled Deals and Personalized Offers.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.defaultPadding),

          ElevatedButton(
            onPressed: () async {
              await context.read<EmailVerificationCubit>().checkVerification();
            },
            child: Text("Continue"),
          ),
          const SizedBox(height: AppSizes.defaultPadding),

          TextButton(
            onPressed: () {
              context.read<EmailVerificationCubit>().verifyEmail();
            },
            child: Text("Resend E-mail Link"),
          ),
        ],
      ),
    );
  }
}
