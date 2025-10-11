import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failure.dart';
import '../../../home/domain/entities/product_entity.dart';
import '../../domain/repos/products_by_categort_repo.dart';
import '../datasources/products_by_category_remote_datasource.dart';

class ProductsByCategoryRepositoryImpl implements ProductsByCategoryRepository {
  final ProductsByCategoryRemoteDatasource remoteDataSource;

  ProductsByCategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String categorySlug,
  ) async {
    try {
      var products = await remoteDataSource.getProductsByCategory(categorySlug);
      return right(products);
    } on DioException catch (e) {
      return left(DioFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
