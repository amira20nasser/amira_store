import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repos/auth_repo.dart';

class SignInUsecase {
  final AuthRepository repository;
  SignInUsecase(this.repository);

  Future<Either<Failure, UserEntity>> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
