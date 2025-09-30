import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repos/auth_repo.dart';

class VerifySmscodeUsecaase {
  final AuthRepository repository;
  VerifySmscodeUsecaase(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String verificationId,
    required String smsCode,
  }) {
    return repository.verifySmsCodeAndLinkWithPhone(
      verificationId: verificationId,
      smsCode: smsCode,
    );
  }
}
