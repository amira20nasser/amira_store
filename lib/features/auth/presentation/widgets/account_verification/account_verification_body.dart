import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../manager/verifying_with_phone/verifying_phone_cubit.dart';
import 'otp_input_widget.dart';
import 'phone_input_widget.dart';

class AccountVerificationBody extends StatelessWidget {
  const AccountVerificationBody({super.key});

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
            child: BlocBuilderAccountVerification(),
          ),
        ),
      ),
    );
  }
}

class BlocBuilderAccountVerification extends StatelessWidget {
  const BlocBuilderAccountVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneVerificationCubit, PhoneAccountVerificationState>(
      builder: (context, state) {
        if (state is SmsCodeLoading ||
            state is SmsCodeSuccess ||
            state is VerifyPhoneSuccess ||
            state is VerifyPhoneCodeSent) {
          return OTPInputWidget();
        }
        return PhoneInputWidget();
      },
    );
  }
}
