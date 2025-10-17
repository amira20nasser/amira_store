import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/domain/entities/product_entity.dart';
import '../../domain/usecases/get_products_usecase.dart';
part 'all_products_state.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  AllProductsCubit(this.getProductsUsecase) : super(AllProductsInitial());
  GetProductsUsecase getProductsUsecase;

  Future<void> getProducts({
    int pageNumber = 0,
    String sortBy = '',
    String order = '',
  }) async {
    if (sortBy.isNotEmpty || order.isNotEmpty) {
      emit(AllProductsInitial());
    } else if (pageNumber == 0) {
      emit(AllProductsLoading());
    } else {
      emit(AllProductsPaginationLoading());
    }

    var res = await getProductsUsecase(
      pageNumber: pageNumber,
      order: order,
      sortBy: sortBy,
    );
    res.fold((error) {
      if (pageNumber == 0) {
        emit(AllProductsError(error.message));
      } else {
        emit(AllProductsPaginationError(error.message));
      }
    }, (products) => emit(AllProductsSuccess(products)));
  }
}
