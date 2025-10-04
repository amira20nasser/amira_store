import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/widgets/custom_button_with_loader.dart';
import '../widgets/custom_text_field.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  Future<void> _resetPasswordByEmail() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      _showSnack("Please enter your email");
      return;
    }

    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _showSnack("Password reset email sent!");
    } on FirebaseAuthException catch (e) {
      _showSnack(e.message ?? "Something went wrong");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithPhoneIfLinked() async {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      _showSnack("Please enter your phone number");
      return;
    }

    setState(() => _isLoading = true);
    try {
      // You can also check via email if needed using fetchSignInMethodsForEmail
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (cred) async {
          await FirebaseAuth.instance.signInWithCredential(cred);
          _showSnack("Signed in successfully!");
        },
        verificationFailed: (e) {
          _showSnack(
            e.code == "user-not-found"
                ? "No phone number linked with this account"
                : e.message ?? "Verification failed",
          );
        },
        codeSent: (id, token) {
          _showSnack("OTP sent to your phone number");
          // Navigate to OTP screen if you have one
        },
        codeAutoRetrievalTimeout: (_) {},
      );
    } catch (e) {
      _showSnack("Error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Text(
              "Recover Your Account",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Choose how you want to reset your password.",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 40),
            _modernCard(
              context,
              title: "Reset by Email",
              child: Column(
                children: [
                  CustomTextField(
                    controller: _emailController,
                    hintText: "Email Address",
                    icon: FontAwesomeIcons.envelope,
                  ),
                  const SizedBox(height: 16),
                  CustomButtonWithLoader(
                    isLoading: _isLoading,
                    widget: Text("Send Reset Link"),
                    onPressed: _resetPasswordByEmail,
                    widgetLoading: CircularProgressIndicator(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  GoRouter.of(
                    context,
                  ).push(ConstantRoutes.verifyYourAccountViewRoute);
                },
                child: const Text(
                  "Sign in with Phone Number",
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _modernCard(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _modernButton({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton.icon(
        onPressed: _isLoading ? null : onTap,
        icon: _isLoading
            ? const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(icon),
        label: Text(text),
      ),
    );
  }
}
