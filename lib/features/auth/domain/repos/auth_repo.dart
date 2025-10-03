import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signIn(String email, String password);
  Future<Either<Failure, UserEntity>> signUp(
    String username,
    String email,
    String password,
  );
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, UserEntity>> signInWithFacebook();
  Future<Either<Failure, void>> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(String verificationId, int? resendToken) onCodeSent,
  });

  Future<Either<Failure, void>> verifyAndLinkSmsCode({
    required String verificationId,
    required String smsCode,
  });

  Future<Either<Failure, void>> signInWithPhoneCredential({
    required String verificationId,
    required String smsCode,
  });
  Future<Either<Failure, void>> sendEmailVerification();

  Future<Either<Failure, void>> signOut();
  Stream<Either<Failure, UserEntity?>> get userStream;
}
