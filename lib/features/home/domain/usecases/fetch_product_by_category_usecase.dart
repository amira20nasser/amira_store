import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product_entity.dart';
import '../repos/home_repo.dart';

class FetchSelectedCategoriesUsecase {
  final HomeRepo repo;

  FetchSelectedCategoriesUsecase(this.repo);
  static const allowedCategories = {
    'skin-care',
    'womens-jewellery',
    'smartphones',
    'sports-accessories',
    'furniture',
  };
  Future<Either<Failure, Map<String, List<ProductEntity>>>> call() async {
    final res = await repo.fetchProductsByCategory();

    return res.map((categorizedProducts) {
      final filtered = {
        for (var entry in categorizedProducts.entries)
          if (allowedCategories.contains(entry.key)) entry.key: entry.value,
      };
      return filtered;
    });
  }
}
