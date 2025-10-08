import '../../../../core/constants/api_constants.dart';
import '../../../../core/services/api_service.dart';
import '../../domain/entities/product_entity.dart';
import '../models/product_model/product_model.dart';

abstract class HomeRemoteDatasource {
  Future<Map<String, List<ProductEntity>>> fetchProductsByCategory();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDatasource {
  final ApiService apiService;
  HomeRemoteDataSourceImpl(this.apiService);

  @override
  Future<Map<String, List<ProductEntity>>> fetchProductsByCategory() async {
    final Map<String, List<ProductEntity>> categorizedProducts = {};
    final categoryList = await _getCategoryList();
    final futures = categoryList.map((category) async {
      final response = await apiService.get(
        '${ApiConstants.productEndPoint}${ApiConstants.categoryEndPoint}/$category',
      );
      final data = response.data;
      final products = ProductModel.fromMap(data).products;
      categorizedProducts[category] = products ?? [];
    });

    await Future.wait(futures);
    return categorizedProducts;
  }

  Future<List<String>> _getCategoryList() async {
    final response = await apiService.get(
      '${ApiConstants.productEndPoint}${ApiConstants.categoryListEndPoint}',
    );
    return List<String>.from(response.data);
  }
}
