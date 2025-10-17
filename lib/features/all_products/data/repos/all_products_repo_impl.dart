import 'package:amira_store/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../home/domain/entities/product_entity.dart';
import '../../domain/repos/all_products_repo.dart';
import '../datasource/all_products_datasource.dart';

class AllProductsRepoImpl extends AllProductsRepo {
  AllProductsDatasource datasource;
  AllProductsRepoImpl(this.datasource);
  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts({
    int pageNumber = 0,
  }) async {
    try {
      var res = await datasource.getAllProducts(pageNumber: pageNumber);
      return right(res);
    } on DioException catch (e) {
      return left(DioFailure.fromDioException(e));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
