import 'package:hive/hive.dart';

part 'cart_item_entity.g.dart';

@HiveType(typeId: 0)
class CartItemEntity {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double price;
  @HiveField(3)
  final String imageUrl;
  @HiveField(4)
  final String category;
  @HiveField(5)
  final int quantity;
  @HiveField(6)
  final int minOrder;

  const CartItemEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.quantity,
    required this.minOrder,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'quantity': quantity,
      'minOrder': minOrder,
    };
  }

  factory CartItemEntity.fromMap(Map<String, dynamic> map) {
    return CartItemEntity(
      id: map['id'],
      name: map['name'],
      price: (map['price'] as num).toDouble(),
      imageUrl: map['imageUrl'],
      category: map['category'],
      quantity: map['quantity'],
      minOrder: map['minOrder'],
    );
  }
  CartItemEntity copyWith({int? quantity}) {
    return CartItemEntity(
      category: category,
      name: name,
      id: id,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl,
      minOrder: minOrder,
      price: price,
    );
  }
}
