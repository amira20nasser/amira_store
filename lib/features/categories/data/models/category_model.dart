import '../../domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.name,
    required super.imageUrl,
    required super.productsUrl,
  });

  factory CategoryModel.fromJson({
    required Map<String, dynamic> dummyJson,
    required String imageUrl,
  }) {
    return CategoryModel(
      name: dummyJson['name'],
      imageUrl: imageUrl,
      productsUrl: dummyJson['url'],
    );
  }

  @override
  String toString() {
    return 'Category: $name $imageUrl $productsUrl';
  }
}
