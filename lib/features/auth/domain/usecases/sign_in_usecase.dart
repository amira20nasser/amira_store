import 'package:amira_store/core/utils/logging/logger_helper.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/firebase_service.dart';
import '../entities/user_entity.dart';
import '../repos/auth_repo.dart';

class SignInUsecase {
  final AuthRepository repository;
  SignInUsecase(this.repository);

  Future<Either<Failure, UserEntity>> call(
    String email,
    String password,
  ) async {
    final result = await repository.signIn(email, password);
    final user = ServiceLocator.get<FirebaseAuthService>().currentUser;
    LoggerHelper.debug(
      "signIn User: ${user?.email} ${user?.uid} ${user?.displayName} ${user?.phoneNumber}",
    );
    return result;
  }
}
