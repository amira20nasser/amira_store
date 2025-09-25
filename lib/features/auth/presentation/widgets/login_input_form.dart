import 'package:amira_store/features/auth/domain/usecases/email_validator_usecase.dart';
import 'package:amira_store/features/auth/presentation/widgets/google_facebook_in_row.dart';
import 'package:amira_store/features/auth/presentation/widgets/row_or_divider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_sizes.dart';
import 'text_form_field_text_title.dart';

class LogInInputForm extends StatefulWidget {
  const LogInInputForm({super.key});

  @override
  State<LogInInputForm> createState() => _LogInInputFormState();
}

class _LogInInputFormState extends State<LogInInputForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final EmailValidatorUsecase _emailValidator = EmailValidatorUsecase();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _submit() {
    // TODO: LOGIN PRESSING BUTTON
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Logged in Successfully ✅")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormFieldWithTextTitle(
            textTitle: "Email or Phone Number",
            controller: _emailController,
            hintText: "Enter your email or phone number",
            icon: FontAwesomeIcons.envelope,
            keyBoardType: TextInputType.emailAddress,
            validator: _emailValidator.call,
          ),
          SizedBox(height: AppSizes.defaultPadding),
          TextFormFieldWithTextTitle(
            textTitle: "Password",
            controller: _passwordController,
            hintText: "Create your Password",
            icon: FontAwesomeIcons.lock,
            isPassword: true,
            keyBoardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
          ),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // TODO: Navigate to ForgotPassword
              },
              child: const Text("Forgot Password?", textAlign: TextAlign.right),
            ),
          ),
          SizedBox(height: AppSizes.defaultPadding),
          ElevatedButton(onPressed: _submit, child: Text("Log In")),
          SizedBox(height: AppSizes.defaultPadding),

          RowOrDivider(),
          SizedBox(height: AppSizes.defaultPadding),

          GoogleFacebookInRow(),
          SizedBox(height: AppSizes.defaultPadding),
        ],
      ),
    );
  }
}
