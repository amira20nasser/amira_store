import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/utils/logging/logger_helper.dart';
import '../../../../../core/widgets/custom_error_dialog.dart';
import '../../../../../core/widgets/snack_bar.dart';
import '../../manager/verifying_with_phone/verifying_phone_cubit.dart';
import 'phone_verification_body.dart';

class PhoneVerificationBlocListener extends StatelessWidget {
  const PhoneVerificationBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneVerificationCubit, PhoneAccountVerificationState>(
      listener: (context, state) {
        if (state is VerifyPhoneLoading) {
          LoggerHelper.debug('Loading state...');
        }
        if (state is VerifyPhoneCodeSent) {
          LoggerHelper.debug('Code sent state...');
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('SMS Code is sent')));
        }
        if (state is VerifyPhoneFailure) {
          showDialog(
            context: context,
            builder: (_) => CustomErrorDialog(
              title: "Verified Phone Failed",
              message: state.message,
            ),
          );
        }
        if (state is VerifyPhoneSuccess) {
          LoggerHelper.debug('Phone verification success state...');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBarTypes.successSnackBar(message: 'Phone number is verified'),
          );
        }
        if (state is SmsCodeLoading) {
          LoggerHelper.debug('SMS Code Loading state...');
        }
        if (state is SmsCodeSuccess) {
          LoggerHelper.debug('Success state...');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBarTypes.successSnackBar(message: 'Verification successful!'),
          );
          GoRouter.of(context).pushReplacement(ConstantRoutes.homeViewRoute);
        }
        if (state is SmsCodeFailure) {
          LoggerHelper.debug('SMS CODE Failure state... ${state.message}');
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
      child: PhoneVerificationBody(),
    );
  }
}
