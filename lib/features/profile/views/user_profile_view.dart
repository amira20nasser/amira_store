import 'package:amira_store/core/constants/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_routes.dart'; // only if you use GoRouter

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
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = snapshot.data;
          if (user == null) {
            return const Center(
              child: Text(
                "No user logged in",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      // Profile Picture
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: user.photoURL != null
                              ? NetworkImage(user.photoURL!)
                              : null,
                          child: user.photoURL == null
                              ? const Icon(Icons.person, size: 50)
                              : null,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Name
                      Center(
                        child: Text(
                          user.displayName ?? "No Name",
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Email
                      Center(
                        child: Text(
                          user.email ?? "No Email",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Email verification status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Chip(
                            label: Text(
                              user.emailVerified
                                  ? "Email Verified"
                                  : "Not Verified",
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: user.emailVerified
                                ? AppColors.successColor
                                : AppColors.warningColor,
                          ),
                          if (!user.emailVerified)
                            TextButton(
                              onPressed: () async {
                                try {
                                  context.pushReplacement(
                                    ConstantRoutes.mailVerificationViewRoute,
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Error: $e")),
                                  );
                                }
                              },
                              child: const Text("Email is not verified"),
                            ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Phone Number (or Add button)
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: user.phoneNumber != null
                            ? Text(user.phoneNumber!)
                            : TextButton(
                                onPressed: () {
                                  // Navigate to add phone number flow
                                  GoRouter.of(context).pushReplacement(
                                    ConstantRoutes.verifyYourAccountViewRoute,
                                  );
                                },
                                child: const Text("Add your phone number"),
                              ),
                      ),

                      const Divider(),

                      // UID
                      ListTile(
                        leading: const Icon(
                          Icons.badge,
                          color: AppColors.primaryColor,
                        ),
                        title: const Text("User ID"),
                        subtitle: Text(user.uid),
                      ),
                    ],
                  ),
                ),

                // Logout Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final router = GoRouter.of(context);
                      await FirebaseAuth.instance.signOut();

                      router.pushReplacement(ConstantRoutes.logInViewRoute);
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text("Logout"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.pinkMegentaColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
