import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repos/auth_repo.dart';

class SignOutUsecase {
  final AuthRepository repository;
  SignOutUsecase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.signOut();
  }
}
