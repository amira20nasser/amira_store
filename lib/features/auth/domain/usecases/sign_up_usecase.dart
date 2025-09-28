import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';
import '../repos/auth_repo.dart';

class SignUpUsecase {
  final AuthRepository repository;
  SignUpUsecase(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
    required String username,
  }) {
    return repository.signUp(username, email, password);
  }
}
