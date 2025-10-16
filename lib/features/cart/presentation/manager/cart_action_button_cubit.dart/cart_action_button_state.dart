part of 'cart_action_button_cubit.dart';

sealed class CartActionButtonState {}

class InitCartActionButton extends CartActionButtonState {}

class InProgressCartActionButton extends CartActionButtonState {
  final String productId;
  InProgressCartActionButton(this.productId);
}

class SuccessfulCartActionButton extends CartActionButtonState {
  final String productId;
  SuccessfulCartActionButton(this.productId);
}

class FailedCartActionButton extends CartActionButtonState {
  final String msg;
  final String productId;
  FailedCartActionButton(this.msg, this.productId);
}
