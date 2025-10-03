import 'dart:developer';

import 'package:amira_store/core/di/service_locator.dart';
import 'package:amira_store/core/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ServiceLocator.get<FirebaseAuthService>().currentUser;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("🎉 Welcome Home!"),
            SizedBox(height: 10),
            Text("You are logged in successfully"),
            SizedBox(height: 20),
            Text("Enjoy shopping with Amira Store 🛍️"),
            SizedBox(height: 10),

            Text("User ID: ${user?.uid ?? 'Unknown'}"),
            SizedBox(height: 10),

            Text("Email: ${user?.email ?? 'Unknown'}"),
            SizedBox(height: 10),

            Text("Phone: ${user?.phoneNumber ?? 'Unknown'}"),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                final router = GoRouter.of(context);
                await ServiceLocator.get<FirebaseAuthService>().signOut();
                log(user?.uid ?? 'no user id');
                log(user?.email ?? 'no email');
                log(user?.phoneNumber ?? 'no phone number');
                router.pushReplacement(ConstantRoutes.logInViewRoute);
              },
              child: Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}
