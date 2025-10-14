class CartItemEntity {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String category;
  final int quantity;
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
}
