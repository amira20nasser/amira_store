import 'package:amira_store/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/custom_text_field.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.defaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Log In Account",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please log in with registered account",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),

              InputForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class InputForm extends StatelessWidget {
  const InputForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormFieldWithTextTitle(
            textTitle: "Email or Phone Number",
            controller: TextEditingController(),
            hintText: "Enter your email or phone number",
            icon: Icons.email_outlined,
          ),
          SizedBox(height: AppSizes.defaultPadding),
          TextFormFieldWithTextTitle(
            textTitle: "Password",
            controller: TextEditingController(),
            hintText: "Create your Password",
            icon: Icons.lock_outline_rounded,
            isPassword: true,
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
          ElevatedButton(
            onPressed: () {
              //TODO: SIGN IN
            },
            child: Text("Log In"),
          ),
          SizedBox(height: AppSizes.defaultPadding),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Divider(endIndent: 10, indent: 10)),
              Text("OR"),
              Expanded(child: Divider(indent: 10, endIndent: 10)),
            ],
          ),
          SizedBox(height: AppSizes.defaultPadding),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.google)),
              SizedBox(width: AppSizes.defaultPadding),
              IconButton(
                onPressed: () {},
                icon: Icon(FontAwesomeIcons.facebookF),
              ),
            ],
          ),
          SizedBox(height: AppSizes.defaultPadding),

          Row(
            children: [
              Text(
                "Don't have an account yet?",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              TextButton(
                onPressed: () {
                  // TODO: Navigate to SignUp
                },
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TextFormFieldWithTextTitle extends StatelessWidget {
  const TextFormFieldWithTextTitle({
    super.key,
    required this.controller,
    required this.textTitle,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
  });
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final String textTitle;
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
          onTap: () {},
          isPassword: isPassword,
          hintText: hintText,
          icon: icon,
        ),
      ],
    );
  }
}
