part of 'cart_cubit.dart';

sealed class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemEntity> cartItems;
  CartLoaded(this.cartItems);
}

class CartActionInProgress extends CartState {
  final String productId;
  CartActionInProgress(this.productId);
}

class CartFailure extends CartState {
  final String message;
  CartFailure(this.message);
}
