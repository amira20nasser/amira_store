import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/utils/logging/logger_helper.dart';
import '../../../../../core/widgets/custom_error_dialog.dart';
import '../../manager/verifying_with_phone/verifying_phone_cubit.dart';
import 'account_verification_body.dart';

class AccountVerificationBlocConsumer extends StatelessWidget {
  const AccountVerificationBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<
      VerifyingWithPhoneCubit,
      AccountVerificationWithPhoneState
    >(
      listener: (context, state) {
        if (state is VerifyPhoneLoading) {
          LoggerHelper.debug('Loading state...');
          // showDialog(
          //   context: context,
          //   barrierDismissible: false,
          //   builder: (_) => const Center(child: CircularProgressIndicator()),
          // );
        }
        if (state is VerifyPhoneCodeSent) {
          LoggerHelper.debug('Code sent state...');
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Code sent!')));
        }
        if (state is SmsCodeSuccess) {
          LoggerHelper.debug('Success state...');

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Verification successful!')),
          );
          // Navigate to next screen if needed
          GoRouter.of(context).pushReplacement(ConstantRoutes.homeViewRoute);
        }
        if (state is VerifyPhoneFailure) {
          LoggerHelper.debug('Failure state... ${state.message}');
          showDialog(
            context: context,
            builder: (_) => CustomErrorDialog(
              title: "Verification Failed, try again or choose another phone",
              message: state.message,
            ),
          );
          GoRouter.of(
            context,
          ).pushReplacement(ConstantRoutes.verifyYourAccountViewRoute);
        }
      },
      child: AccountVerificationBody(),
    );
  }
}
