import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/cart_item_entity.dart';

class CartLocalDatasource {
  List<CartItemEntity> fetchCartItems() {
    var box = Hive.box<CartItemEntity>('cartBox');
    return box.values.toList();
  }

  void saveCartData(List<CartItemEntity> items) {
    var box = Hive.box<CartItemEntity>('cartBox');
    box.addAll(items);
  }

  Future<void> saveCartItem(CartItemEntity item) async {
    var box = Hive.box<CartItemEntity>('cartBox');
    await box.add(item);
  }

  Future<void> removeItem(dynamic itemOrId) async {
    if (itemOrId is CartItemEntity) {
      await itemOrId.delete();
      return;
    }
    var box = Hive.box<CartItemEntity>('cartBox');
    final cartItems = box.values.toList();
    final index = cartItems.indexWhere((item) => item.id == itemOrId);
    if (index != -1) {
      await box.deleteAt(index);
    }
  }

  Future<void> removeAllItem() async {
    var box = Hive.box<CartItemEntity>('cartBox');
    await box.clear();
  }

  Future<void> updateCartItemQuantity(
    CartItemEntity cartItem,
    int newQuantity,
  ) async {
    // var box = Hive.box<CartItemEntity>('cartBox');
    // final cartItems = box.values.toList();
    // final index = cartItems.indexWhere((item) => item.id == id);

    // if (index != -1) {
    //   await box.deleteAt(index);
    //   final existingItem = cartItems[index];
    //   final updatedItem = CartItemEntity(
    //     category: existingItem.category,
    //     minOrder: existingItem.minOrder,
    //     id: existingItem.id,
    //     name: existingItem.name,
    //     price: existingItem.price,
    //     imageUrl: existingItem.imageUrl,
    //     quantity: newQuantity,
    //   );

    //   await box.add(updatedItem);
    // }
    cartItem.quantity = newQuantity;
    await cartItem.save();
  }
}
