import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/cart_item_entity.dart';
import '../../domain/repos/cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartRepo cart;
  CartCubit(this.cart) : super(CartInitial());
  static int numberOfCallingData = 0;
  Future<void> getCartItems() async {
    if (!isClosed) {
      emit(CartLoading());
      var res = await cart.getCartItems();
      res.fold((error) => emit(CartFailure(error.message)), (items) {
        numberOfCallingData++;
        emit(CartLoaded(items));
      });
    }
  }

  Future<void> clearCart() async {
    if (!isClosed) {
      emit(CartLoading());
      var res = await cart.clearCart();
      res.fold((error) => emit(CartFailure(error.message)), (_) async {
        emit(CartInitial());
      });
    }
  }

  Future<void> addItemToCart(CartItemEntity item) async {
    if (!isClosed) {
      emit(CartActionInProgress(item.id.toString()));
      var res = await cart.addToCart(item);
      res.fold((error) => emit(CartFailure(error.message)), (_) async {
        emit(AddedToCartSuccess(item.id.toString()));
      });
    }
  }

  Future<void> removeItemFromCart(String itemId) async {
    if (!isClosed) {
      emit(CartActionInProgress(itemId));
      var res = await cart.removeFromCart(itemId);
      res.fold((error) => emit(CartFailure(error.message)), (_) async {
        emit(RemovedFromCartSuccess(itemId));
      });
    }
  }
}
