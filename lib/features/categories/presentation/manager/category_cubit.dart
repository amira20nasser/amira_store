import 'package:amira_store/features/categories/domain/entities/category_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/fetch_category.dart';

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

class CategoryCubit extends Cubit<CategoryState> {
  final FetchCategoriesUseCase fetchCategoriesUseCase;

  CategoryCubit(this.fetchCategoriesUseCase) : super(CategoryInit());

  Future<void> loadCategories() async {
    emit(CategoryLoading());
    final res = await fetchCategoriesUseCase();
    res.fold(
      (failure) => emit(CategoryFailure(msg: failure.message)),
      (categories) => emit(CategorySuccess(categories: categories)),
    );
  }
}
