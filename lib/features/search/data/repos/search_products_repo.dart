import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failure.dart';
import '../../../home/domain/entities/product_entity.dart';
import '../../domain/repos/search_products_repo.dart';
import '../datasources/search_products_datasource.dart';

class SearchProductsRepoImpl extends SearchProductsRepo {
  final SearchProductsDatasource remoteDataSource;

  SearchProductsRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts(
    String query,
  ) async {
    try {
      final products = await remoteDataSource.searchProducts(query);
      return Right(products);
    } on DioException catch (e) {
      return Left(DioFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
