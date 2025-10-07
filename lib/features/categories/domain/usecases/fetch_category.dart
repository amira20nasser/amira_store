// domain/usecases/fetch_categories_usecase.dart
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/category_entity.dart';
import '../repos/category_repo.dart';

class FetchCategoriesUseCase {
  final CategoryRepository repository;

  FetchCategoriesUseCase(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> call() async {
    return await repository.getCategories();
  }
}
