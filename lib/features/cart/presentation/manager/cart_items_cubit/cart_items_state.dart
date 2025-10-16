part of 'cart_items_cubit.dart';

sealed class CartItemsState {}

class CartItemsInitial extends CartItemsState {}

class CartItemsSuccess extends CartItemsState {}

class CartItemsLoading extends CartItemsState {}

class CartItemsFailure extends CartItemsState {
  String msg;
  CartItemsFailure(this.msg);
}
