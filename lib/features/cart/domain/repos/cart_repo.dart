import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/cart_item_entity.dart';

abstract class CartRepo {
  Future<Either<Failure, void>> addToCart(CartItemEntity item);
  Future<Either<Failure, List<CartItemEntity>>> getCartItems();
  Future<Either<Failure, void>> updateCartItemQuantity(
    String itemId,
    int quantity,
  );
  Future<Either<Failure, void>> removeFromCart(String itemId);
  Future<Either<Failure, void>> clearCart();
  Future<void> syncLocalCartToFirebase();
}
