import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/cart_item_entity.dart';
import '../../../domain/repos/cart_repo.dart';

part 'cart_items_state.dart';

class CartItemsCubit extends Cubit<CartItemsState> {
  CartItemsCubit(this.cart) : super(CartItemsInitial());
  CartRepo cart;
  double totalPrice = 0.0;
  List<CartItemEntity> items = [];
  Future<void> getCartItems() async {
    if (isClosed) return;
    emit(CartItemsLoading());
    var res = await cart.getCartItems();
    res.fold((error) => emit(CartItemsFailure(error.message)), (items) {
      totalPrice = 0.0;
      this.items = items;
      for (var item in items) {
        totalPrice +=
            double.parse((item.price).toStringAsFixed(1)) * item.quantity;
      }
      emit(CartItemsSuccess());
    });
  }
}
