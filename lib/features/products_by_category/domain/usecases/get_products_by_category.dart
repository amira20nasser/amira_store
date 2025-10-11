import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../home/domain/entities/product_entity.dart';
import '../repos/products_by_categort_repo.dart';

class GetProductsByCategory {
  final ProductsByCategoryRepository repository;

  GetProductsByCategory(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call(String categorySlug) async {
    return await repository.getProductsByCategory(categorySlug);
  }
}
