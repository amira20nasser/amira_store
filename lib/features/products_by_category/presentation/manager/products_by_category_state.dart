part of 'products_by_category_cubit.dart';

abstract class ProductsByCategoryState {}

class ProductsByCategoryInitial extends ProductsByCategoryState {}

class ProductsByCategoryLoading extends ProductsByCategoryState {}

class ProductsByCategoryLoaded extends ProductsByCategoryState {
  final List<ProductEntity> products;
  ProductsByCategoryLoaded(this.products);
}

class ProductsByCategoryError extends ProductsByCategoryState {
  final String message;
  ProductsByCategoryError(this.message);
}
