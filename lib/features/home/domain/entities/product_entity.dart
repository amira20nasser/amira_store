class ReviewEntity {
  final String reviewerName;
  final DateTime reviewDate;
  final int rating;
  final String comment;

  const ReviewEntity({
    required this.reviewerName,
    required this.reviewDate,
    required this.rating,
    required this.comment,
  });
}

class ProductEntity {
  final int productId;
  final String thumbnailUrl;
  final String name;
  final double cost;
  final double reductionPercentage;
  final double stars;
  final List<String> imageUrls;
  final String overview, brandName, cat;
  final String skuProduct,
      dimensionsProduct,
      weightProduct,
      minOrderQuantity,
      warrantyInfo,
      shippingInfo,
      policy,
      availableStatus;
  final List<ReviewEntity> customersReviews;
  const ProductEntity({
    required this.productId,
    required this.thumbnailUrl,
    required this.cost,
    required this.reductionPercentage,
    required this.stars,
    required this.name,
    required this.imageUrls,
    required this.overview,
    required this.brandName,
    required this.cat,
    required this.skuProduct,
    required this.dimensionsProduct,
    required this.weightProduct,
    required this.minOrderQuantity,
    required this.warrantyInfo,
    required this.shippingInfo,
    required this.policy,
    required this.availableStatus,
    required this.customersReviews,
  });
}
