import 'package:dartz/dartz.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/firebase_service.dart';
import '../../../../core/utils/logging/logger_helper.dart';
import '../entities/user_entity.dart';
import '../repos/auth_repo.dart';

class SignInWithFacebookUsecase {
  final AuthRepository repository;
  SignInWithFacebookUsecase(this.repository);

  Future<Either<Failure, UserEntity>> call() async {
    final result = await repository.signInWithFacebook();
    final user = ServiceLocator.get<FirebaseAuthService>().currentUser;
    LoggerHelper.debug(
      "signIn facebook User: ${user?.email} ${user?.uid} ${user?.displayName} ${user?.phoneNumber}",
    );
    return result;
  }
}
