import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/domain/entities/product_entity.dart';
import '../../domain/usecases/get_products_by_category.dart';
part 'products_by_category_state.dart';

class ProductsByCategoryCubit extends Cubit<ProductsByCategoryState> {
  final GetProductsByCategory getProductsByCategory;

  ProductsByCategoryCubit(this.getProductsByCategory)
    : super(ProductsByCategoryInitial());

  Future<void> fetchProducts(String categorySlug) async {
    emit(ProductsByCategoryLoading());
    var slug = _nameToSlug(categorySlug);
    final res = await getProductsByCategory(slug);
    res.fold(
      (error) => emit(ProductsByCategoryError(error.message)),
      (products) => emit(ProductsByCategoryLoaded(products)),
    );
  }

  String _nameToSlug(String name) {
    return name
        .toLowerCase() // convert to lowercase
        .replaceAll(RegExp(r"[^\w\s-]"), '') // remove special characters
        .replaceAll(RegExp(r"\s+"), '-') // replace spaces with hyphens
        .trim(); // remove extra spaces
  }
}
