part of 'all_products_cubit.dart';

sealed class AllProductsState {}

class AllProductsInitial extends AllProductsState {}

class AllProductsLoading extends AllProductsState {}

class AllProductsError extends AllProductsState {
  String msg;
  AllProductsError(this.msg);
}

class AllProductsPaginationError extends AllProductsState {
  String msg;
  AllProductsPaginationError(this.msg);
}

class AllProductsSuccess extends AllProductsState {
  List<ProductEntity> products;
  AllProductsSuccess(this.products);
}

class AllProductsPaginationLoading extends AllProductsState {}
