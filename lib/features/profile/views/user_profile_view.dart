import 'package:amira_store/core/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/di/service_locator.dart';
import '../widgets/user_profile_body.dart'; // only if you use GoRouter

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        elevation: 0,
      ),
      body: StreamBuilder<User?>(
        stream: ServiceLocator.get<FirebaseAuthService>().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = snapshot.data;
          if (user == null) {
            return Center(
              child: Text(
                "No user logged in",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            );
          }

          return UserProfileBody(user: user);
        },
      ),
    );
  }
}
