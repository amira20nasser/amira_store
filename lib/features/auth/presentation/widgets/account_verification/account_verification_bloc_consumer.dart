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
    return BlocConsumer<VerifyingWithPhoneCubit, VerifyingWithPhoneState>(
      listener: (context, state) {
        if (state is VerifyingWithPhoneLoading) {
          LoggerHelper.debug('Loading state...');
          // showDialog(
          //   context: context,
          //   barrierDismissible: false,
          //   builder: (_) => const Center(child: CircularProgressIndicator()),
          // );
        }
        if (state is VerifyingWithPhoneCodeSent) {
          LoggerHelper.debug('Code sent state...');
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Code sent!')));
        }
        if (state is VerifyingWithPhoneSuccess) {
          LoggerHelper.debug('Success state...');

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Verification successful!')),
          );
          // Navigate to next screen if needed
          GoRouter.of(context).pushReplacement(ConstantRoutes.homeViewRoute);
        }
        if (state is VerifyingWithPhoneFailure) {
          LoggerHelper.debug('Failure state...');
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
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state is VerifyingWithPhoneLoading,
          child: AccountVerificationBody(
            isSentPhone: ValueNotifier<bool>(
              state is VerifyingWithPhoneLoading ||
                      state is VerifyingWithPhoneFailure ||
                      state is VerifyingWithPhoneInit
                  ? false
                  : true,
            ),
          ),
        );
      },
    );
  }
}
