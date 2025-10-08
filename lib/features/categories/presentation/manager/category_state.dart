part of 'category_cubit.dart';

abstract class CategoryState {}

class CategoryInit extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<CategoryEntity> categories;
  CategorySuccess({required this.categories});
}

class CategoryFailure extends CategoryState {
  final String msg;
  CategoryFailure({required this.msg});
}
