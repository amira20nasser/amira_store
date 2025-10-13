import 'package:amira_store/core/constants/api_constants.dart';

import '../../../../core/services/api_service.dart';
import '../../../home/data/models/product_model/product_model.dart';
import '../../../home/domain/entities/product_entity.dart';

class SearchProductsDatasource {
  ApiService apiService;
  SearchProductsDatasource(this.apiService);
  Future<List<ProductEntity>> searchProducts(String query) async {
    final response = await apiService.get(
      ApiConstants.productEndPoint + ApiConstants.searchEndPoint,
      queryParams: {'q': query},
    );
    List<ProductEntity> products =
        ProductModel.fromMap(response.data).products ?? [];
    return products;
  }
}
