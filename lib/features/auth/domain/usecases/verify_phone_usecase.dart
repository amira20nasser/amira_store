import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repos/auth_repo.dart';

class VerifyPhoneUsecase {
  final AuthRepository repository;
  VerifyPhoneUsecase(this.repository);

  Future<Either<Failure, void>> call({
    required String phoneNumber,
    required void Function(String verificationId, int? resendToken) onCodeSent,
  }) {
    return repository.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      onCodeSent: onCodeSent,
    );
  }
}
