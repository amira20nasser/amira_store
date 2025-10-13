import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../home/domain/entities/product_entity.dart';
import '../repos/search_products_repo.dart';

class SearchProductsUsecase {
  final SearchProductsRepo repo;

  SearchProductsUsecase(this.repo);

  Future<Either<Failure, List<ProductEntity>>> call(String query) async {
    return await repo.searchProducts(query);
  }
}
