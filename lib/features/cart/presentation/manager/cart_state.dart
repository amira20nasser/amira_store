part of 'cart_cubit.dart';

sealed class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartActionInProgress extends CartState {
  final String productId;
  CartActionInProgress(this.productId);
}

class CartLoaded extends CartState {
  final List<CartItemEntity> cartItems;
  CartLoaded(this.cartItems);
}

class AddedToCartSuccess extends CartState {
  final String itemId;
  AddedToCartSuccess(this.itemId);
}

class RemovedFromCartSuccess extends CartState {
  final String itemId;
  RemovedFromCartSuccess(this.itemId);
}

class CartFailure extends CartState {
  final String message;
  CartFailure(this.message);
}
