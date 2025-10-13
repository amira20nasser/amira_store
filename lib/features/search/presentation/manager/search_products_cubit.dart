import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/domain/entities/product_entity.dart';
import '../../domain/usecases/search_products_usecase.dart';

part 'search_products_state.dart';

class SearchProductsCubit extends Cubit<SearchProductsState> {
  SearchProductsUsecase searchProductsUsecase;
  SearchProductsCubit(this.searchProductsUsecase)
    : super(SearchProductsInitial());
  Future<void> searchProducts(String query) async {
    emit(SearchProductsLoading());
    final result = await searchProductsUsecase(query);
    result.fold(
      (failure) => emit(SearchProductsError(failure.message)),
      (products) => emit(SearchProductsLoaded(products)),
    );
  }
}
