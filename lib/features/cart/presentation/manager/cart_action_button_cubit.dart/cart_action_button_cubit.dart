import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/cart_item_entity.dart';
import '../../../domain/repos/cart_repo.dart';

part 'cart_action_button_state.dart';

class CartActionButtonCubit extends Cubit<CartActionButtonState> {
  CartActionButtonCubit(this.cart) : super(InitCartActionButton());
  CartRepo cart;

  Future<void> addItemToCart(CartItemEntity item) async {
    if (isClosed) return;
    emit(InProgressCartActionButton(item.id.toString()));
    var res = await cart.addToCart(item);
    res.fold(
      (error) =>
          emit(FailedCartActionButton(error.message, item.id.toString())),
      (_) => emit(SuccessfulCartActionButton(item.id.toString())),
    );
  }

  Future<void> clearCart() async {
    if (isClosed) return;
    emit(InProgressCartActionButton('-1'));
    var res = await cart.clearCart();
    res.fold(
      (error) => emit(FailedCartActionButton(error.message, '-1')),
      (_) => emit(SuccessfulCartActionButton('-1')),
    );
  }

  Future<void> removeItemFromCart(CartItemEntity cartItem) async {
    if (isClosed) return;
    emit(InProgressCartActionButton(cartItem.id.toString()));

    var res = await cart.removeFromCart(cartItem);
    res.fold(
      (error) => emit(FailedCartActionButton(error.message, '-1')),
      (_) => emit(SuccessfulCartActionButton(cartItem.id.toString())),
    );
  }

  Future<void> removeIdFromCart(int id) async {
    if (isClosed) return;
    emit(InProgressCartActionButton(id.toString()));

    var res = await cart.removeFromCart(id);
    res.fold(
      (error) => emit(FailedCartActionButton(error.message, '-1')),
      (_) => emit(SuccessfulCartActionButton(id.toString())),
    );
  }

  Future<void> updateCartItemQuantity(
    CartItemEntity cartItem,
    int quantity,
  ) async {
    if (isClosed) return;
    var res = await cart.updateCartItemQuantity(cartItem, quantity);
    res.fold(
      (error) =>
          emit(FailedCartActionButton(error.message, cartItem.id.toString())),
      (_) => emit(SuccessfulCartActionButton(cartItem.id.toString())),
    );
  }
}
