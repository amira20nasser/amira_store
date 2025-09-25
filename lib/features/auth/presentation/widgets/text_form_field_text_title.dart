import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';
import 'custom_text_field.dart';

class TextFormFieldWithTextTitle extends StatelessWidget {
  const TextFormFieldWithTextTitle({
    super.key,
    required this.controller,
    required this.textTitle,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.keyBoardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validator,
  });
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final String textTitle;
  final TextInputType keyBoardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textTitle,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppSizes.defaultPadding),

        CustomTextField(
          controller: controller,
          isPassword: isPassword,
          hintText: hintText,
          icon: icon,
          keyboardType: keyBoardType,
          textInputAction: textInputAction,
          validator: validator,
        ),
      ],
    );
  }
}
