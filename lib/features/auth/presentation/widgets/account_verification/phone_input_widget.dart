import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/utils/logging/logger_helper.dart';
import '../../manager/verifying_with_phone/verifying_phone_cubit.dart';

class PhoneInputWidget extends StatefulWidget {
  const PhoneInputWidget({super.key, required this.isSendPhone});
  final ValueNotifier<bool> isSendPhone;

  @override
  State<PhoneInputWidget> createState() => _PhoneInputWidgetState();
}

class _PhoneInputWidgetState extends State<PhoneInputWidget> {
  String? _phoneNumber;
  void _onSend() {
    if (_phoneNumber == null || _phoneNumber!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your phone number')),
      );
      return;
    }
    widget.isSendPhone.value = true;
    LoggerHelper.debug(
      'Sending code to $_phoneNumber ${widget.isSendPhone.value}',
    );

    BlocProvider.of<VerifyingWithPhoneCubit>(
      context,
    ).verifyPhoneNumber(_phoneNumber!);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sending your phone $_phoneNumber.....')),
    );
  }

  void _onSkip() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Skipped!')));
    GoRouter.of(context).pushReplacement(ConstantRoutes.homeViewRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.verified_user_rounded,
          size: 56,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 20),
        Text(
          'Verify your account with your phone number.',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        IntlPhoneField(
          decoration: InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
          initialCountryCode: 'EG',
          onChanged: (phone) {
            _phoneNumber = phone.completeNumber;
          },
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            // Expanded(
            //   child: ElevatedButton(
            //     onPressed: _onSend,
            //     style: ElevatedButton.styleFrom(
            //       padding: const EdgeInsets.symmetric(vertical: 16),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //       textStyle: const TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     child: const Text('Send'),
            //   ),
            // ),
            Expanded(
              child: Visibility(
                visible:
                    context.watch<VerifyingWithPhoneCubit>().state
                        is VerifyingWithPhoneLoading,
                replacement: ElevatedButton(
                  onPressed: _onSend,
                  child: const Text('Send'),
                ),
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.whiteColor40,
                  ),
                  child: const Text('Send'),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OutlinedButton(
                onPressed: _onSkip,

                child: const Text('Skip'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
