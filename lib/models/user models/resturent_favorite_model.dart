class FavouriteRestaurantsResponse {
  final String status;
  final int statusCode;
  final String message;
  final FavouriteData data;

  FavouriteRestaurantsResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory FavouriteRestaurantsResponse.fromJson(Map<String, dynamic> json) {
    return FavouriteRestaurantsResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: FavouriteData.fromJson(json['data'] ?? {}),
    );
  }
}

class FavouriteData {
  final String type;
  final List<FavouriteRestaurantItem> attributes;

  FavouriteData({
    required this.type,
    required this.attributes,
  });

  factory FavouriteData.fromJson(Map<String, dynamic> json) {
    return FavouriteData(
      type: json['type'] ?? '',
      attributes: (json['attributes'] as List<dynamic>?)
              ?.map((e) => FavouriteRestaurantItem.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class FavouriteRestaurantItem {
  final String id;
  final RestaurantInfo restaurant;
  final String createdAt;
  final String updatedAt;
  final String type;

  FavouriteRestaurantItem({
    required this.id,
    required this.restaurant,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
  });

  factory FavouriteRestaurantItem.fromJson(Map<String, dynamic> json) {
    return FavouriteRestaurantItem(
      id: json['_id'] ?? '',
      restaurant: RestaurantInfo.fromJson(json['restaurant'] ?? {}),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      type: json['type'] ?? '',
    );
  }
}

class RestaurantInfo {
  final String id;
  final String fullName;
  final String image;
  final String address;
  final double rating;
  final List<String> cuisines;
  final Map<String, dynamic>
      category; // You can make a separate model if needed

  RestaurantInfo({
    required this.id,
    required this.fullName,
    required this.image,
    required this.address,
    required this.rating,
    required this.cuisines,
    required this.category,
  });

  factory RestaurantInfo.fromJson(Map<String, dynamic> json) {
    return RestaurantInfo(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      image: json['image'] ?? '',
      address: json['address'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      cuisines:
          (json['cuisines'] as List<dynamic>?)?.whereType<String>().toList() ??
              [],
      category: json['category'] ?? {},
    );
  }
}
