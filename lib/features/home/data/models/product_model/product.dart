import 'dart:convert';

import '../../../domain/entities/product_entity.dart';
import 'dimensions.dart';
import 'meta.dart';
import 'review.dart';

class Product extends ProductEntity {
  final int id;
  final String? title;
  final String? description;
  final String? category;
  final double? price;
  final double? discountPercentage;
  final double? rating;
  final int? stock;
  final List<String>? tags;
  final String? brand;
  final String? sku;
  final int? weight;
  final Dimensions? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final List<Review>? reviews;
  final String? returnPolicy;
  final int? minimumOrderQuantity;
  final Meta? meta;
  final List<String>? images;
  final String? thumbnail;

  Product({
    required this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.images,
    this.thumbnail,
  }) : super(
         productId: id,
         name: title ?? "",
         cost: price ?? -1,
         reductionPercentage: discountPercentage ?? -1,
         stars: rating ?? 1,
         thumbnailUrl: thumbnail ?? "",
         imageUrls: images ?? const [],
         overview: description ?? "",
         brandName: brand ?? "",
         cat: category ?? "",
         availableStatus: availabilityStatus ?? "",
         dimensionsProduct:
             dimensions?.width.toString() ??
             " x ${dimensions?.height.toString() ?? ""} x ${dimensions?.depth.toString() ?? ""}",
         minOrderQuantity: minimumOrderQuantity ?? 1,
         policy: returnPolicy ?? "",
         shippingInfo: shippingInformation ?? "",
         skuProduct: sku ?? "",
         weightProduct: weight?.toString() ?? "",
         warrantyInfo: warrantyInformation ?? "",
         customersReviews:
             reviews
                 ?.map(
                   (e) => ReviewEntity(
                     reviewerName: e.reviewerName ?? "",
                     reviewDate: e.date ?? DateTime.now(),
                     rating: e.rating ?? -1,
                     comment: e.comment ?? "",
                   ),
                 )
                 .toList() ??
             const [],
       );

  factory Product.fromMap(Map<String, dynamic> data) => Product(
    id: data['id'] as int,
    title: data['title'] as String? ?? "",
    description: data['description'] as String?,
    category: data['category'] as String?,
    price: (data['price'] as num?)?.toDouble(),
    discountPercentage: (data['discountPercentage'] as num?)?.toDouble(),
    rating: (data['rating'] as num?)?.toDouble(),
    stock: data['stock'] as int?,
    tags: (data['tags'] as List<dynamic>).map((e) => e.toString()).toList(),
    brand: data['brand'] as String?,
    sku: data['sku'] as String?,
    weight: data['weight'] as int?,
    dimensions: data['dimensions'] == null
        ? null
        : Dimensions.fromMap(data['dimensions'] as Map<String, dynamic>),
    warrantyInformation: data['warrantyInformation'] as String?,
    shippingInformation: data['shippingInformation'] as String?,
    availabilityStatus: data['availabilityStatus'] as String?,
    reviews: (data['reviews'] as List<dynamic>?)
        ?.map((e) => Review.fromMap(e as Map<String, dynamic>))
        .toList(),
    returnPolicy: data['returnPolicy'] as String?,
    minimumOrderQuantity: data['minimumOrderQuantity'] as int?,
    meta: data['meta'] == null
        ? null
        : Meta.fromMap(data['meta'] as Map<String, dynamic>),
    images: (data['images'] as List<dynamic>).map((e) => e.toString()).toList(),
    thumbnail: data['thumbnail'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'category': category,
    'price': price,
    'discountPercentage': discountPercentage,
    'rating': rating,
    'stock': stock,
    'tags': tags,
    'brand': brand,
    'sku': sku,
    'weight': weight,
    'dimensions': dimensions?.toMap(),
    'warrantyInformation': warrantyInformation,
    'shippingInformation': shippingInformation,
    'availabilityStatus': availabilityStatus,
    'reviews': reviews?.map((e) => e.toMap()).toList(),
    'returnPolicy': returnPolicy,
    'minimumOrderQuantity': minimumOrderQuantity,
    'meta': meta?.toMap(),
    'images': images,
    'thumbnail': thumbnail,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Product].
  factory Product.fromJson(String data) {
    return Product.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Product] to a JSON string.
  String toJson() => json.encode(toMap());
}
