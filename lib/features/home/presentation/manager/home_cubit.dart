import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/fetch_product_by_category_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FetchSelectedCategoriesUsecase fetchUsecase;

  HomeCubit(this.fetchUsecase) : super(HomeInitial());

  Future<void> fetchSelectedCategories() async {
    if (isClosed) return;
    emit(HomeLoading());
    final res = await fetchUsecase.call();
    res.fold(
      (failure) => emit(HomeError(failure.message)),
      (products) => emit(HomeSuccess(products)),
    );
  }
}
