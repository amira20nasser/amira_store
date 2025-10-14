import 'package:amira_store/core/error/failure.dart';
import 'package:amira_store/features/cart/data/datasources/cart_firestore_datasource.dart';

import 'package:amira_store/features/cart/domain/entities/cart_item_entity.dart';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/repos/cart_repo.dart';

class CartRepoImpl extends CartRepo {
  CartRepoImpl(this.cartFirestoreDatasource);
  CartFirestoreDatasource cartFirestoreDatasource;
  @override
  Future<Either<Failure, void>> addToCart(CartItemEntity item) async {
    try {
      var res = await cartFirestoreDatasource.addToCart(item);
      return Right(res);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure.fromCode(e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart() async {
    try {
      var res = await cartFirestoreDatasource.clearCart();
      return Right(res);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure.fromCode(e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartItemEntity>>> getCartItems() async {
    try {
      var res = await cartFirestoreDatasource.getCartItems();
      return Right(res);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure.fromCode(e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromCart(String itemId) async {
    try {
      var res = await cartFirestoreDatasource.removeFromCart(itemId);
      return Right(res);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure.fromCode(e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateCartItemQuantity(
    String itemId,
    int quantity,
  ) async {
    try {
      var res = await cartFirestoreDatasource.updateCartItemQuantity(
        itemId,
        quantity,
      );
      return Right(res);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure.fromCode(e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
