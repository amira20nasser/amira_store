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
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.defaultBorderRadius),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultPadding),
          child: Visibility(
            visible:
                context.watch<VerifyingWithPhoneCubit>().state
                    is VerifyPhoneCodeSent,
            replacement: PhoneInputWidget(),
            child: OTPInputWidget(),
          ),
        ),
      ),
    );
  }
}
