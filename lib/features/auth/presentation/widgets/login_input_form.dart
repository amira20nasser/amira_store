import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../domain/usecases/email_validator_usecase.dart';
import '../manager/auth_cubit.dart';
import 'google_facebook_in_row.dart';
import 'row_or_divider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormFieldWithTextTitle(
            textTitle: "Email",
            controller: _emailController,
            hintText: "Enter your email",
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
          Visibility(
            visible: context.watch<AuthCubit>().state is AuthLoading,
            replacement: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  context.read<AuthCubit>().signIn(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );
                }
              },
              child: Text("Log In"),
            ),
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.whiteColor40,
                foregroundColor: Colors.white,
              ),
              child: CircularProgressIndicator(),
            ),
          ),
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
