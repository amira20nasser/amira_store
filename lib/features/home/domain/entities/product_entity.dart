class ProductEntity {
  final int productId;
  final String thumbnailUrl;
  final String name;
  final double cost;
  final double reductionPercentage;
  final double stars;
  const ProductEntity({
    required this.productId,
    required this.thumbnailUrl,
    required this.cost,
    required this.reductionPercentage,
    required this.stars,
    required this.name,
  });
}
