import 'dart:async';

import 'package:amira_store/core/utils/logging/logger_helper.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repos/auth_repo.dart';
import '../data_sources/firebase_auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource authSource;

  AuthRepositoryImpl(this.authSource);
  @override
  Future<Either<Failure, void>> sendEmailVerification() async {
    try {
      await authSource.sendEmailVerification();
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseAuthFailure.fromCode(e.code));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

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
      return left(ServerFailure(e.toString()));
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
      return left(ServerFailure(e.toString()));
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
      LoggerHelper.debug(e.code);
      return left(FirebaseAuthFailure.fromCode(e.code));
    } on GoogleSignInException catch (e) {
      LoggerHelper.debug(e.code.name);
      return left(FirebaseAuthFailure.fromCode(e.code.name));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> verifyPhoneNumber({
    required void Function(String, int?) onCodeSent,
    required String phoneNumber,
  }) async {
    try {
      final completer = Completer<void>();
      await authSource.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        onCodeSent: onCodeSent,
        verificationFailed: (FirebaseAuthException e) {
          completer.completeError(e);
        },
      );
      await completer.future;
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseAuthFailure.fromCode(e.code));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> verifyAndLinkSmsCode({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      await authSource.verifyAndLinkSmsCode(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseAuthFailure.fromCode(e.code));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signInWithPhoneCredential({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      await authSource.signInWithPhoneCredential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseAuthFailure.fromCode(e.code));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
