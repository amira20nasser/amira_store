import '../../../../core/di/di_imports.dart';
import '../../../../core/services/firebase_service.dart';
import '../../../../core/services/firestore_service.dart';
import '../../domain/entities/cart_item_entity.dart';

class CartFirestoreDatasource {
  FirestoreService firestoreService;
  CartFirestoreDatasource(this.firestoreService);
  Future<void> addToCart(CartItemEntity cart) async {
    var currentUserId =
        ServiceLocator.get<FirebaseAuthService>().currentUser?.uid;
    if (currentUserId == null) throw Exception("User not logged in");
    await firestoreService.setDocument(
      collectionPath: "users/$currentUserId/cart",
      docId: cart.id,
      data: cart.toMap(),
      merge: true,
    );
  }

  Future<List<CartItemEntity>> getCartItems() async {
    var currentUserId =
        ServiceLocator.get<FirebaseAuthService>().currentUser?.uid;
    if (currentUserId == null) throw Exception("User not logged in");
    final querySnapshot = await firestoreService.getCollection(
      collectionPath: "users/$currentUserId/cart",
    );
    return querySnapshot
        .map((doc) => CartItemEntity.fromMap(doc.data()))
        .toList();
  }

  Future<void> updateCartItemQuantity(String itemId, int quantity) async {
    final currentUserId =
        ServiceLocator.get<FirebaseAuthService>().currentUser?.uid;
    if (currentUserId == null) throw Exception("User not logged in");

    await firestoreService.updateDocument(
      collectionPath: "users/$currentUserId/cart",
      docId: itemId,
      data: {'quantity': quantity},
    );
  }

  Future<void> removeFromCart(String itemId) async {
    var currentUserId =
        ServiceLocator.get<FirebaseAuthService>().currentUser?.uid;
    if (currentUserId == null) throw Exception("User not logged in");
    await firestoreService.deleteDocument(
      collectionPath: "users/$currentUserId/cart",
      docId: itemId,
    );
  }

  Future<void> clearCart() async {
    var currentUserId =
        ServiceLocator.get<FirebaseAuthService>().currentUser?.uid;
    if (currentUserId == null) throw Exception("User not logged in");
    final cartItems = await getCartItems();
    for (var item in cartItems) {
      await removeFromCart(item.id);
    }
  }
}
