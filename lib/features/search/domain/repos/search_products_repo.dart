import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../home/domain/entities/product_entity.dart';

abstract class SearchProductsRepo {
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query);
}
