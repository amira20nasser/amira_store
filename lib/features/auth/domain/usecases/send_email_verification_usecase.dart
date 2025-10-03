import 'package:dartz/dartz.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/firebase_service.dart';
import '../../../../core/utils/logging/logger_helper.dart';
import '../repos/auth_repo.dart';

class SendEmailVerificationUsecase {
  final AuthRepository repository;
  SendEmailVerificationUsecase(this.repository);

  Future<Either<Failure, void>> call() async {
    final result = await repository.sendEmailVerification();
    final user = ServiceLocator.get<FirebaseAuthService>().currentUser;
    LoggerHelper.debug(
      "Verified Email User: ${user?.email} ${user?.uid} ${user?.displayName} ${user?.phoneNumber} ${user?.emailVerified}",
    );
    return result;
  }
}
