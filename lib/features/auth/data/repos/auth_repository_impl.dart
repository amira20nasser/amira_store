import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repos/auth_repo.dart';
import '../data_sources/firebase_auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, UserEntity>> signIn(
    String email,
    String password,
  ) async {
    try {
      final user = await dataSource.signInUser(email, password);
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
    String email,
    String password,
  ) async {
    try {
      final user = await dataSource.signUpUser(email, password);
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
      await dataSource.signOut();
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseAuthFailure.fromCode(e.code));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, UserEntity?>> get userStream async* {
    try {
      await for (final user in dataSource.userStream) {
        yield right(user);
      }
    } on FirebaseAuthException catch (e) {
      yield left(FirebaseAuthFailure.fromCode(e.code));
    } catch (e) {
      yield left(ServerFailure(e.toString()));
    }
  }
}
