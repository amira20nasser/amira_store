import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repos/auth_repo.dart';

class SmsCodeUsecaase {
  final AuthRepository repository;
  SmsCodeUsecaase(this.repository);

  Future<Either<Failure, void>> linkAccount({
    required String verificationId,
    required String smsCode,
  }) {
    return repository.verifyAndLinkSmsCode(
      verificationId: verificationId,
      smsCode: smsCode,
    );
  }

  Future<Either<Failure, void>> signIn({
    required String verificationId,
    required String smsCode,
  }) {
    return repository.signInWithPhoneCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
  }
}
