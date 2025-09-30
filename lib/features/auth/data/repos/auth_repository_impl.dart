import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/logging/logger_helper.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repos/auth_repo.dart';
import '../data_sources/firebase_auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource authSource;

  AuthRepositoryImpl(this.authSource);

  @override
  Future<Either<Failure, UserEntity>> signIn(
    String email,
    String password,
  ) async {
    try {
      final user = await authSource.signInUser(email, password);
      if (user == null) {
        return left(const FirebaseAuthFailure("Sign in failed"));
      }

      return right(user);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseAuthFailure.fromCode(e.code));
    } catch (e) {
      return left(ServerFailure("Unexpected error: Please try again later"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(
    String username,
    String email,
    String password,
  ) async {
    try {
      final user = await authSource.signUpUser(
        username: username,
        email: email,
        password: password,
      );
      if (user == null) {
        return left(const FirebaseAuthFailure("Sign up failed"));
      }

      return right(user);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseAuthFailure.fromCode(e.code));
    } catch (e) {
      LoggerHelper.debug(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await authSource.signOut();
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseAuthFailure.fromCode(e.code));
    } catch (e) {
      return left(ServerFailure("Unexpected error: Please try again later"));
    }
  }

  @override
  Stream<Either<Failure, UserEntity?>> get userStream async* {
    try {
      await for (final user in authSource.userStream) {
        yield right(user);
      }
    } on FirebaseAuthException catch (e) {
      yield left(FirebaseAuthFailure.fromCode(e.code));
    } catch (e) {
      yield left(ServerFailure("Unexpected error: Please try again later"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    try {
      final user = await authSource.signInWithFacebookUser();
      if (user == null) {
        return left(const FirebaseAuthFailure("Sign in failed"));
      }

      return right(user);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseAuthFailure.fromCode(e.code));
    } catch (e) {
      LoggerHelper.error(e.toString());
      return left(ServerFailure("Unexpected error: Please try again later"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      final user = await authSource.signInWithGoogleUser();
      if (user == null) {
        return left(const FirebaseAuthFailure("Sign in failed"));
      }
      return right(user);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseAuthFailure.fromCode(e.code));
    } catch (e) {
      LoggerHelper.error(e.toString());
      return left(ServerFailure("Unexpected error: Please try again later"));
    }
  }

  @override
  Future<Either<Failure, void>> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(PhoneAuthCredential) onVerificationCompleted,
    required void Function(FirebaseAuthException) onVerificationFailed,
    required void Function(String verificationId, int? resendToken) onCodeSent,
    required void Function(String verificationId) onCodeAutoRetrievalTimeout,
  }) async {
    try {
      await authSource.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        onVerificationCompleted: onVerificationCompleted,
        onVerificationFailed: onVerificationFailed,
        onCodeSent: onCodeSent,
        onCodeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout,
      );
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseAuthFailure.fromCode(e.code));
    } catch (e) {
      return left(ServerFailure("Unexpected error: Please try again later"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> verifySmsCodeAndLinkWithPhone({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final user = await authSource.verifySmsCodeAndLinkWithPhone(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      if (user == null) {
        return left(const FirebaseAuthFailure("SMS verification failed"));
      }
      // final firebaseUser =
      //     ServiceLocator.get<FirebaseAuthService>().currentUser;
      // if (firebaseUser != null && firebaseUser.phoneNumber != null) {
      //   LoggerHelper.debug(
      //     "Phone number verified: ${firebaseUser.phoneNumber}",
      //   );
      //   await storeSource.createOrUpdateUser(firebaseUser);
      // }
      return right(user);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseAuthFailure.fromCode(e.code));
    } catch (e) {
      return left(ServerFailure("Unexpected error: Please try again later"));
    }
  }
}
