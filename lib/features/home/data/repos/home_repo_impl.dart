import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repos/home_repo.dart';
import '../datasources/home_remote_datasource.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDatasource remoteDatasource;

  HomeRepoImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, Map<String, List<ProductEntity>>>>
  fetchProductsByCategory() async {
    try {
      final categorizedProducts = await remoteDatasource
          .fetchProductsByCategory();
      return right(categorizedProducts);
    } on DioException catch (e) {
      return left(DioFailure.fromDioException(e));
    }
  }
}
