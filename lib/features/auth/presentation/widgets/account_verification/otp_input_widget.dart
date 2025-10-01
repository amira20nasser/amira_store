import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/utils/logging/logger_helper.dart';
import '../../manager/verifying_with_phone/verifying_phone_cubit.dart';

class OTPInputWidget extends StatefulWidget {
  const OTPInputWidget({super.key});

  @override
  State<OTPInputWidget> createState() => _OTPInputWidgetState();
}

class _OTPInputWidgetState extends State<OTPInputWidget> {
  String _otpCode = '';
  void _onVerify() {
    LoggerHelper.debug('Verifying.....');
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Verifying code...')));
    BlocProvider.of<PhoneVerificationCubit>(
      context,
    ).verifySmsCodeLink(_otpCode);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.sms_rounded,
          size: 56,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 20),
        Text(
          'Enter the code sent to your phone.',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        PinCodeTextField(
          appContext: context,
          length: 6,
          onChanged: (value) {
            _otpCode = value;
          },
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Theme.of(context).colorScheme.surface,
            selectedFillColor: Theme.of(context).colorScheme.surface,
            inactiveFillColor: Theme.of(context).colorScheme.surface,
            activeColor: Theme.of(context).primaryColor,
            selectedColor: Theme.of(context).primaryColor,
            inactiveColor: Colors.grey,
          ),
          enableActiveFill: true,
        ),
        const SizedBox(height: 32),
        ElevatedButton(onPressed: _onVerify, child: const Text('Verify')),
      ],
    );
  }
}
