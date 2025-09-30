import 'package:flutter/material.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/utils/logging/logger_helper.dart';
import 'otp_input_widget.dart';
import 'phone_input_widget.dart';

class AccountVerificationBody extends StatelessWidget {
  const AccountVerificationBody({super.key, required this.isSentPhone});

  final ValueNotifier<bool> isSentPhone;

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
          child: ValueListenableBuilder<bool>(
            valueListenable: isSentPhone,
            builder: (context, value, child) {
              LoggerHelper.debug("The value of sending $value");
              if (value) {
                return OTPInputWidget(isSendPhone: isSentPhone);
              }
              return PhoneInputWidget(isSendPhone: isSentPhone);
            },
          ),
        ),
      ),
    );
  }
}
