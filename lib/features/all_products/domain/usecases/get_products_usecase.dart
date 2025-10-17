import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../home/domain/entities/product_entity.dart';
import '../repos/all_products_repo.dart';

class GetProductsUsecase {
  AllProductsRepo repo;
  GetProductsUsecase(this.repo);
  Future<Either<Failure, List<ProductEntity>>> call({
    int pageNumber = 0,
    String sortBy = '',
    String order = '',
  }) async {
    return await repo.getAllProducts(
      pageNumber: pageNumber,
      order: order,
      sortBy: sortBy,
    );
  }
}
