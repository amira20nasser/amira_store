import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/di/di_imports.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_manager.dart';
import '../../../../core/services/firebase_service.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/repos/cart_repo.dart';
import '../datasources/cart_firestore_datasource.dart';
import '../datasources/cart_local_datasource.dart';

class CartRepoImpl extends CartRepo {
  CartRepoImpl(this.cartFirestoreDatasource, this.localSource);
  CartFirestoreDatasource cartFirestoreDatasource;
  CartLocalDatasource localSource;
  @override
  Future<Either<Failure, void>> addToCart(CartItemEntity item) async {
    try {
      var isConnected = await NetworkManager.isConnected();
      var res = await localSource.saveCartItem(item);
      var isLoggedIn =
          ServiceLocator.get<FirebaseAuthService>().currentUser != null;
      if (isLoggedIn && isConnected) {
        // Save to firebase in the background
        res = cartFirestoreDatasource.addToCart(item);
      }
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
      var isConnected = await NetworkManager.isConnected();
      var res = await localSource.removeAllItem();
      var isLoggedIn =
          ServiceLocator.get<FirebaseAuthService>().currentUser != null;
      if (isLoggedIn && isConnected) {
        // clear all from firebase in the background
        res = cartFirestoreDatasource.clearCart();
      }
      return Right(res);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure.fromCode(e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<List<CartItemEntity>> _mergeCartsFast(
    List<CartItemEntity> localList,
    List<CartItemEntity> remoteList,
  ) async {
    final Map<int, CartItemEntity> map = {
      for (var item in localList) item.id: item,
    };
    for (final item in remoteList) {
      if (map.containsKey(item.id)) {
        // The Remote is the reference if the data is difference
        final existing = map[item.id]!;
        if (existing.quantity != item.quantity) {
          await localSource.updateCartItemQuantity(existing, item.quantity);
        }
      } else {
        await localSource.saveCartItem(item);
      }
    }
    return map.values.toList();
  }

  @override
  Future<Either<Failure, List<CartItemEntity>>> getCartItems() async {
    try {
      var isConnected = await NetworkManager.isConnected();
      var res = localSource.fetchCartItems();
      var isLoggedIn =
          ServiceLocator.get<FirebaseAuthService>().currentUser != null;
      if (isLoggedIn && isConnected) {
        // get all from firebase
        var res2 = await cartFirestoreDatasource.getCartItems();
        res = await _mergeCartsFast(res, res2);
      }
      return Right(res);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure.fromCode(e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromCart(dynamic itemOrId) async {
    try {
      var isConnected = await NetworkManager.isConnected();
      var res = await localSource.removeItem(itemOrId);
      var isLoggedIn =
          ServiceLocator.get<FirebaseAuthService>().currentUser != null;
      if (isLoggedIn && isConnected) {
        // remove from firebase in background
        res = cartFirestoreDatasource.removeFromCart(
          itemOrId is CartItemEntity ? itemOrId.id : itemOrId,
        );
      }
      return Right(res);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure.fromCode(e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateCartItemQuantity(
    CartItemEntity cartItem,
    int quantity,
  ) async {
    try {
      var isConnected = await NetworkManager.isConnected();
      var res = await localSource.updateCartItemQuantity(cartItem, quantity);
      var isLoggedIn =
          ServiceLocator.get<FirebaseAuthService>().currentUser != null;
      if (isLoggedIn && isConnected) {
        res = cartFirestoreDatasource.updateCartItemQuantity(
          cartItem.id.toString(),
          quantity,
        );
      }
      return Right(res);
    } on FirebaseException catch (e) {
      return Left(FirestoreFailure.fromCode(e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> syncLocalCartToFirebase() async {
    final isConnected = await NetworkManager.isConnected();
    final firebaseAuth = ServiceLocator.get<FirebaseAuthService>();
    final isLoggedIn = firebaseAuth.currentUser != null;

    if (!isConnected || !isLoggedIn) return;

    final localItems = localSource.fetchCartItems();
    if (localItems.isEmpty) return;

    for (final item in localItems) {
      await cartFirestoreDatasource.addToCart(item);
    }
  }
}
