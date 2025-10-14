import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/services/api_service.dart';
import '../../domain/entities/category_entity.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryEntity>> fetchCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final ApiService api;

  CategoryRemoteDataSourceImpl(this.api);

  @override
  Future<List<CategoryEntity>> fetchCategories() async {
    final response = await api.get(
      ApiConstants.productEndPoint + ApiConstants.categoriesEndPoint,
    );
    final categories = response.data as List;

    List<CategoryEntity> result = await _getCategoriesList(categories);
    return result;
  }

  Future<List<CategoryEntity>> _getCategoriesList(
    List<dynamic> categories,
  ) async {
    List<CategoryEntity> res = [];
    for (final Map<String, dynamic> category in categories) {
      final imageUrl = await _fetchCategoryImage(category['name']);
      var categoryModel = CategoryModel.fromJson(
        dummyJson: category,
        imageUrl: imageUrl,
      );
      res.add(categoryModel);
    }
    return res;
  }

  Future<String> _fetchCategoryImage(String categoryName) async {
    final response = await Dio().get(
      ApiConstants.pexelsBaseUrl,
      queryParameters: {'query': categoryName, 'per_page': 1},
      options: Options(headers: {'Authorization': ApiConstants.pexelsApiKey}),
    );

    final photos = response.data['photos'] as List?;
    if (photos != null && photos.isNotEmpty) {
      return photos[0]['src']['medium'];
    } else {
      return 'https://via.placeholder.com/150';
    }
  }
}
