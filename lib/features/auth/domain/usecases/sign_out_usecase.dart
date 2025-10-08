import 'package:dartz/dartz.dart';

import '../../../../core/di/di_imports.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/firebase_service.dart';
import '../../../../core/utils/logging/logger_helper.dart';
import '../repos/auth_repo.dart';

class SignOutUsecase {
  final AuthRepository repository;
  SignOutUsecase(this.repository);

  Future<Either<Failure, void>> call() async {
    var user = ServiceLocator.get<FirebaseAuthService>().currentUser;

    LoggerHelper.debug(
      "Sign out User...: ${user?.email} ${user?.uid} ${user?.displayName} ${user?.phoneNumber}",
    );
    final result = await repository.signOut();
    user = ServiceLocator.get<FirebaseAuthService>().currentUser;
    LoggerHelper.debug(
      "User must be null..: ${user?.email} ${user?.uid} ${user?.displayName} ${user?.phoneNumber}",
    );
    return result;
  }
}
