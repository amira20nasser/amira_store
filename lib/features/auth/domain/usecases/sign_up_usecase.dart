import 'package:dartz/dartz.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/firebase_service.dart';
import '../../../../core/utils/logging/logger_helper.dart';
import '../entities/user_entity.dart';
import '../repos/auth_repo.dart';

class SignUpUsecase {
  final AuthRepository repository;
  SignUpUsecase(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
    required String username,
  }) async {
    final result = await repository.signUp(username, email, password);
    final user = ServiceLocator.get<FirebaseAuthService>().currentUser;
    LoggerHelper.debug(
      "signUp User: ${user?.email} ${user?.uid} ${user?.displayName} ${user?.phoneNumber}",
    );
    return result;
  }
}
