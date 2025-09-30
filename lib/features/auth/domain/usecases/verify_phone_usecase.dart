import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failure.dart';
import '../repos/auth_repo.dart';

class VerifyPhoneUsecase {
  final AuthRepository repository;
  VerifyPhoneUsecase(this.repository);

  Future<Either<Failure, void>> call({
    required String phoneNumber,
    required void Function(PhoneAuthCredential) onVerificationCompleted,
    required void Function(FirebaseAuthException) onVerificationFailed,
    required void Function(String verificationId, int? resendToken) onCodeSent,
    required void Function(String verificationId) onCodeAutoRetrievalTimeout,
  }) {
    return repository.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      onVerificationCompleted: onVerificationCompleted,
      onVerificationFailed: onVerificationFailed,
      onCodeSent: onCodeSent,
      onCodeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout,
    );
  }
}
