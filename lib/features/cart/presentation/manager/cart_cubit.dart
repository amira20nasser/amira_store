import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/cart_item_entity.dart';
import '../../domain/repos/cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartRepo cart;
  CartCubit(this.cart) : super(CartInitial());
  List<CartItemEntity> _cartItems = [];
  List<CartItemEntity> get cartItems => _cartItems;
  double totalPrice = 0.0;
  Future<void> updateCartItemQuantity(String itemId, int quantity) async {
    if (!isClosed) {
      var res = await cart.updateCartItemQuantity(itemId, quantity);
      res.fold((error) => emit(CartFailure(error.message)), (_) {
        final index = _cartItems.indexWhere((i) => i.id.toString() == itemId);
        if (index != -1) {
          totalPrice -= _cartItems[index].price * _cartItems[index].quantity;
          _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
          totalPrice += _cartItems[index].price * _cartItems[index].quantity;
        }
        emit(CartLoaded(_cartItems));
      });
    }
  }

  Future<void> getCartItems() async {
    if (!isClosed) {
      emit(CartLoading());
      var res = await cart.getCartItems();
      res.fold((error) => emit(CartFailure(error.message)), (items) {
        _cartItems = items;
        for (var item in items) {
          totalPrice += item.price * item.quantity;
        }
        emit(CartLoaded(items));
      });
    }
  }

  Future<void> clearCart() async {
    if (!isClosed) {
      emit(CartLoading());
      var res = await cart.clearCart();
      res.fold((error) => emit(CartFailure(error.message)), (_) async {
        _cartItems = [];
        totalPrice = 0.0;
        emit(CartInitial());
      });
    }
  }

  Future<void> addItemToCart(CartItemEntity item) async {
    if (!isClosed) {
      emit(CartActionInProgress(item.id.toString()));
      var res = await cart.addToCart(item);
      res.fold((error) => emit(CartFailure(error.message)), (_) async {
        _cartItems.add(item);
        totalPrice += item.price;
        emit(CartLoaded(_cartItems));
      });
    }
  }

  Future<void> removeItemFromCart(String itemId) async {
    if (!isClosed) {
      emit(CartActionInProgress(itemId));
      var res = await cart.removeFromCart(itemId);
      res.fold((error) => emit(CartFailure(error.message)), (_) async {
        var removedItem = _cartItems.firstWhere(
          (e) => e.id.toString() == itemId,
        );
        totalPrice -= removedItem.price * removedItem.quantity;
        // _cartItems.removeWhere((e) => e.id.toString() == itemId);
        _cartItems.remove(removedItem);
        emit(CartLoaded(_cartItems));
      });
    }
  }
}
