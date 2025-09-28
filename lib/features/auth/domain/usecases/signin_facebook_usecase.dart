import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repos/auth_repo.dart';

class SignInWithFacebookUsecase {
  final AuthRepository repository;
  SignInWithFacebookUsecase(this.repository);

  Future<Either<Failure, UserEntity>> call() {
    return repository.signInWithFacebook();
  }
}
