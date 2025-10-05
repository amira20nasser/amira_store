import 'package:flutter/material.dart';
import '../../../core/di/service_locator.dart';
import '../../auth/domain/entities/user_entity.dart';
import '../../auth/domain/repos/auth_repo.dart';
import '../widgets/user_profile_body.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = ServiceLocator.get<AuthRepository>();

    return StreamBuilder<UserEntity?>(
      stream: authRepository.userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = snapshot.data;
        if (user == null) {
          return Center(
            child: Text(
              "No user logged in",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }

        return UserProfileBody(user: user);
      },
    );
  }
}
