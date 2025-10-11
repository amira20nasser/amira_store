import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../home/domain/entities/product_entity.dart';

abstract class ProductsByCategoryRepository {
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String categorySlug,
  );
}
