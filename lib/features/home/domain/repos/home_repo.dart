import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, Map<String, List<ProductEntity>>>>
  fetchProductsByCategory();
}
