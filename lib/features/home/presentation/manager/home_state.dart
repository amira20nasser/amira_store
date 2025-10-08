part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final Map<String, List<ProductEntity>> categorizedProducts;
  HomeSuccess(this.categorizedProducts);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
