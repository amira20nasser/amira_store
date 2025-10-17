import 'package:amira_store/features/home/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class AllProductsRepo {
  Future<Either<Failure, List<ProductEntity>>> getAllProducts({
    int pageNumber = 0,
    String sortBy = '',
    String order = '',
  });
}
