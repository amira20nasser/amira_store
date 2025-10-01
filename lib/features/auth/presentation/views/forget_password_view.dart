import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/services/firebase_service.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
        title: Text(
          "Forget Password ?",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "log in with your email and we will send you a link to reset your password",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  await ServiceLocator.get<FirebaseAuthService>()
                      .sendPasswordResetEmail("amira20nasser@gmail.com");
                  log("Password reset email sent");
                  log(
                    'User ID: ${FirebaseAuth.instance.currentUser?.uid ?? 'Unknown'}',
                  );
                  log(
                    'email: ${FirebaseAuth.instance.currentUser?.email ?? 'Unknown'}  ',
                  );
                },
                child: Text("Reset Password"),
              ),
              TextButton(
                onPressed: () {
                  ServiceLocator.get<FirebaseAuthService>().verifyPhoneNumber(
                    phoneNumber: '+201026054787',
                    codeSent: (String verificationId, int? resendToken) async {
                      log("Code sent to phone number");
                      log("Verification ID: $verificationId");
                      log("Resend Token: $resendToken");
                      final credential = PhoneAuthProvider.credential(
                        verificationId: verificationId,
                        smsCode: '123456',
                      );
                      await FirebaseAuth.instance.signInWithCredential(
                        credential,
                      );
                      log('User signed in successfully after code sent');
                      log(
                        "User ID: ${FirebaseAuth.instance.currentUser?.uid ?? 'Unknown'}",
                      );
                      log(
                        "email: ${FirebaseAuth.instance.currentUser?.email ?? 'Unknown'}  ",
                      );
                      log(
                        "Phone: ${FirebaseAuth.instance.currentUser?.phoneNumber ?? 'Unknown'}",
                      );
                    },
                    verificationFailed: (FirebaseAuthException e) {
                      log("Phone number verification failed: ${e.message}");
                    },
                    verificationCompleted: (PhoneAuthCredential credential) async {
                      log("User signed in successfully");
                      log(
                        "User ID: ${FirebaseAuth.instance.currentUser?.uid ?? 'Unknown'}",
                      );
                      log(
                        "Phone: ${FirebaseAuth.instance.currentUser?.phoneNumber ?? 'Unknown'}",
                      );
                    },
                    codeAutoRetrievalTimeout: (String verificationId) async {
                      log("Code auto-retrieval timeout: $verificationId");
                      final credential = PhoneAuthProvider.credential(
                        verificationId: verificationId,
                        smsCode: '123456',
                      );
                      await FirebaseAuth.instance.signInWithCredential(
                        credential,
                      );
                      log('User signed in successfully after timeout');
                      log(
                        "User ID: ${FirebaseAuth.instance.currentUser?.uid ?? 'Unknown'}",
                      );
                      log(
                        "Phone: ${FirebaseAuth.instance.currentUser?.phoneNumber ?? 'Unknown'}",
                      );
                    },
                  );
                },
                child: Text("Sign In using phone number"),
              ),
              ElevatedButton(
                onPressed: () async {
                  // await ServiceLocator.get<FirebaseAuthService>().signOut();
                  log(
                    "User ID: ${FirebaseAuth.instance.currentUser?.uid ?? 'Unknown'}",
                  );
                  log(
                    "email: ${FirebaseAuth.instance.currentUser?.email ?? 'Unknown'}  ",
                  );
                  log(
                    "Phone: ${FirebaseAuth.instance.currentUser?.phoneNumber ?? 'Unknown'}",
                  );
                },
                child: Text("log data in console"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
