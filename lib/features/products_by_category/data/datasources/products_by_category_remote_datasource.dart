import '../../../../core/constants/api_constants.dart';
import '../../../../core/services/api_service.dart';
import '../../../home/data/models/product_model/product_model.dart';
import '../../../home/domain/entities/product_entity.dart';

abstract class ProductsByCategoryRemoteDatasource {
  Future<List<ProductEntity>> getProductsByCategory(String categorySlug);
}

class ProductsByCategoryRemoteDataSourceImpl
    implements ProductsByCategoryRemoteDatasource {
  final ApiService apiService;

  ProductsByCategoryRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<ProductEntity>> getProductsByCategory(String categorySlug) async {
    final response = await apiService.get(
      '${ApiConstants.productEndPoint}${ApiConstants.categoryEndPoint}/$categorySlug',
    );
    final products = ProductModel.fromMap(response.data).products;
    return products ?? [];
  }
}
