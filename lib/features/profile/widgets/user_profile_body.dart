import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_routes.dart';

class UserProfileBody extends StatelessWidget {
  const UserProfileBody({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
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
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
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
                        user.emailVerified ? "Email Verified" : "Not Verified",
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: user.emailVerified
                          ? AppColors.successColor
                          : AppColors.warningColor,
                    ),
                    if (!user.emailVerified)
                      TextButton(
                        onPressed: () {
                          context.pushReplacement(
                            ConstantRoutes.mailVerificationViewRoute,
                          );
                        },
                        child: const Text("Email is not verified"),
                      ),
                  ],
                ),
                const SizedBox(height: 24),

                ListTile(
                  leading: const Icon(Icons.phone),
                  title: user.phoneNumber != null
                      ? Text(user.phoneNumber!)
                      : TextButton(
                          onPressed: () {
                            GoRouter.of(context).pushReplacement(
                              ConstantRoutes.verifyYourAccountViewRoute,
                            );
                          },
                          child: const Text("Add your phone number"),
                        ),
                ),
                const Divider(),
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
            ),
          ),
        ],
      ),
    );
  }
}
