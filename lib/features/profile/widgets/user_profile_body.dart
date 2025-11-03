import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/di/di_imports.dart';
import '../../auth/domain/entities/user_entity.dart';
import '../../auth/domain/repos/auth_repo.dart';
import '../../cart/domain/entities/cart_item_entity.dart';
import '../theme_value_notifier.dart';

class UserProfileBody extends StatelessWidget {
  const UserProfileBody({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final authRepository = ServiceLocator.get<AuthRepository>();
    final isDark = Brightness.dark == Theme.of(context).brightness;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          // Profile Picture
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: user.photoUrl != null
                  ? NetworkImage(user.photoUrl!)
                  : null,
              child: user.photoUrl == null
                  ? const Icon(Icons.person, size: 50)
                  : null,
            ),
          ),
          const SizedBox(height: 16),

          // Name
          Center(
            child: Text(
              user.name,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),

          // Email
          Center(
            child: Text(
              user.email,
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
                    context.pushReplacement(ConstantRoutes.emailVerification);
                  },
                  child: const Text("Email is not verified"),
                ),
            ],
          ),
          const SizedBox(height: 24),

          ListTile(
            leading: const Icon(Icons.phone),
            title: user.phone != null
                ? Text(user.phone!)
                : TextButton(
                    onPressed: () {
                      GoRouter.of(context).push(ConstantRoutes.verifyAccount);
                    },
                    child: const Text("Add your phone number"),
                  ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.badge, color: AppColors.primaryColor),
            title: const Text("User ID"),
            subtitle: Text(user.uid),
          ),
          const Divider(),

          SwitchListTile(
            value: isDark,
            onChanged: (value) {
              ThemeNotifier.toggleTheme();
            },
            title: isDark ? const Text("Dark Mode") : const Text("Light Mode"),
            secondary: isDark
                ? const Icon(Icons.dark_mode)
                : Icon(Icons.light_mode),
          ),
          SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () async {
              final router = GoRouter.of(context);
              await authRepository.signOut();
              var box = Hive.box<CartItemEntity>('cartBox');
              await box.clear();
              router.pushReplacement(ConstantRoutes.login);
            },
            icon: const Icon(FontAwesomeIcons.arrowRightFromBracket),
            label: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
