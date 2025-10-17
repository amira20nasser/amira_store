import 'package:amira_store/core/constants/api_constants.dart';

import '../../../../core/services/api_service.dart';
import '../../../home/data/models/product_model/product_model.dart';
import '../../../home/domain/entities/product_entity.dart';

class AllProductsDatasource {
  ApiService api;
  AllProductsDatasource(this.api);
  Future<List<ProductEntity>> getAllProducts({
    int pageNumber = 0,
    String sortBy = '',
    String order = '',
  }) async {
    var response = await api.get(
      ApiConstants.productEndPoint,
      queryParams: {'skip': 30 * pageNumber, 'sortBy': sortBy, 'order': order},
    );
    return ProductModel.fromMap(response.data).products ?? [];
  }
}
