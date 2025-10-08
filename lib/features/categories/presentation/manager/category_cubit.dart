import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/usecases/fetch_category.dart';
part 'category_state.dart';

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
