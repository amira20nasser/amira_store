import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../domain/usecases/email_validator_usecase.dart';
import '../../domain/usecases/password_validator_usecase.dart';
import 'google_facebook_in_row.dart';
import 'password_checks_widget.dart';
import 'row_or_divider.dart';
import 'text_form_field_text_title.dart';

class SignUpInputForm extends StatefulWidget {
  const SignUpInputForm({super.key});

  @override
  State<SignUpInputForm> createState() => _SignUpInputFormState();
}

class _SignUpInputFormState extends State<SignUpInputForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _validatePassword = PasswordValidatorUsecase();

  late final ValueNotifier<Map<String, bool>> _passwordChecks;
  @override
  void initState() {
    super.initState();
    _passwordChecks = ValueNotifier({});
    _passwordController.addListener(_onPasswordChanged);
  }

  void _onPasswordChanged() {
    _passwordChecks.value = _validatePassword.checkPassword(
      _passwordController.text,
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordChecks.dispose();
    super.dispose();
  }

  void _submitForm() {
    // TODO: Do Successful Sign Up

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account Created Successfully ✅")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormFieldWithTextTitle(
            textTitle: "Username",
            controller: _usernameController,
            hintText: "Create your username",
            icon: FontAwesomeIcons.user,
            keyBoardType: TextInputType.name,
          ),
          SizedBox(height: AppSizes.defaultPadding),

          TextFormFieldWithTextTitle(
            textTitle: "Email",
            controller: _emailController,
            hintText: "Enter your email",
            icon: FontAwesomeIcons.envelope,
            keyBoardType: TextInputType.emailAddress,
            validator: EmailValidatorUsecase().call,
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
            validator: _validatePassword.call,
          ),
          SizedBox(height: 10),

          PasswordChecksWidget(passwordChecks: _passwordChecks),

          SizedBox(height: AppSizes.defaultPadding),
          ElevatedButton(onPressed: _submitForm, child: Text("Create Account")),
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
