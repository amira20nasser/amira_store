// import 'package:amira_store/core/utils/logging/logger_helper.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../domain/entities/cart_item_entity.dart';
// import '../../domain/repos/cart_repo.dart';

// part 'cart_state.dart';

// class CartCubit extends Cubit<CartState> {
//   CartRepo cart;
//   CartCubit(this.cart) : super(CartInitial());
//   List<CartItemEntity> _cartItems = [];
//   List<CartItemEntity> get cartItems => _cartItems;
//   double totalPrice = 0.0;
//   Future<void> updateCartItemQuantity(
//     CartItemEntity cartItem,
//     int quantity,
//   ) async {
//     if (!isClosed) {
//       var oldTotalPrice =
//           double.parse((cartItem.price).toStringAsFixed(1)) * cartItem.quantity;
//       var res = await cart.updateCartItemQuantity(cartItem, quantity);
//       res.fold((error) => emit(CartFailure(error.message)), (_) {
//         totalPrice = totalPrice - oldTotalPrice;
//         var newTotalPrice =
//             double.parse((cartItem.price).toStringAsFixed(1)) * quantity;

//         totalPrice += double.parse((newTotalPrice).toStringAsFixed(1));
//         int index = _cartItems.indexWhere((item) => item.id == cartItem.id);
//         _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
//         emit(CartLoaded(_cartItems));
//       });
//     }
//   }

//   Future<void> getCartItems() async {
//     if (!isClosed) {
//       emit(CartLoading());
//       var res = await cart.getCartItems();
//       res.fold((error) => emit(CartFailure(error.message)), (items) {
//         _cartItems = items;
//         totalPrice = 0.0;
//         for (var item in items) {
//           totalPrice +=
//               double.parse((item.price).toStringAsFixed(1)) * item.quantity;
//         }
//         emit(CartLoaded(items));
//       });
//     }
//   }

//   Future<void> clearCart() async {
//     if (!isClosed) {
//       emit(CartLoading());
//       var res = await cart.clearCart();
//       res.fold((error) => emit(CartFailure(error.message)), (_) async {
//         _cartItems = [];
//         totalPrice = 0.0;
//         emit(CartInitial());
//       });
//     }
//   }

//   Future<void> addItemToCart(CartItemEntity item) async {
//     if (!isClosed) {
//       emit(CartActionInProgress(item.id.toString()));
//       var res = await cart.addToCart(item);
//       res.fold((error) => emit(CartFailure(error.message)), (_) async {
//         _cartItems.add(item);
//         totalPrice += item.price;
//         LoggerHelper.debug('Total Price in Cart $totalPrice');
//         emit(CartLoaded(_cartItems));
//       });
//     }
//   }

//   Future<void> removeItemFromCart(CartItemEntity cartItem) async {
//     if (!isClosed) {
//       emit(CartActionInProgress(cartItem.id.toString()));

//       var res = await cart.removeFromCart(cartItem);
//       res.fold((error) => emit(CartFailure(error.message)), (_) async {
//         totalPrice -=
//             double.parse((cartItem.price).toStringAsFixed(1)) *
//             cartItem.quantity;
//         LoggerHelper.debug(
//           'Total Price in Cart $totalPrice ${cartItem.price} ${cartItem.quantity}',
//         );
//         _cartItems.remove(cartItem);
//         emit(CartLoaded(_cartItems));
//       });
//     }
//   }

//   Future<void> removeIdFromCart(int id) async {
//     if (!isClosed) {
//       emit(CartActionInProgress(id.toString()));

//       var res = await cart.removeFromCart(id);
//       res.fold((error) => emit(CartFailure(error.message)), (_) async {
//         _cartItems.remove(_cartItems.firstWhere((item) => item.id == id));
//         emit(CartLoaded(_cartItems));
//       });
//     }
//   }
// }
