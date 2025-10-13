part of 'search_products_cubit.dart';

sealed class SearchProductsState {}

class SearchProductsInitial extends SearchProductsState {}

class SearchProductsLoading extends SearchProductsState {}

class SearchProductsLoaded extends SearchProductsState {
  final List<ProductEntity> products;
  SearchProductsLoaded(this.products);
}

class SearchProductsError extends SearchProductsState {
  final String message;
  SearchProductsError(this.message);
}
