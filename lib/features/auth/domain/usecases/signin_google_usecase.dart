import 'package:dartz/dartz.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/firebase_service.dart';
import '../../../../core/utils/logging/logger_helper.dart';
import '../entities/user_entity.dart';
import '../repos/auth_repo.dart';

class SignInWithGoogleUsecase {
  final AuthRepository repository;
  SignInWithGoogleUsecase(this.repository);

  Future<Either<Failure, UserEntity>> call() async {
    final result = await repository.signInWithGoogle();
    final user = ServiceLocator.get<FirebaseAuthService>().currentUser;
    LoggerHelper.debug(
      "signIn google User: ${user?.email} ${user?.uid} ${user?.displayName} ${user?.phoneNumber}",
    );
    return result;
  }
}
