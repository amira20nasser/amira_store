import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/verifying_with_phone/verifying_phone_cubit.dart';
import 'otp_input_widget.dart';
import 'phone_input_widget.dart';

class BlocBuilderPhoneVerification extends StatelessWidget {
  const BlocBuilderPhoneVerification({super.key});

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
