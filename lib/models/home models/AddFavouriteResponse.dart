class AddFavouriteResponse {
  final String status;
  final int statusCode;
  final String message;
  final FavouriteData data;
  final List<dynamic> errors;

  AddFavouriteResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory AddFavouriteResponse.fromJson(Map<String, dynamic> json) {
    return AddFavouriteResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: FavouriteData.fromJson(json['data']),
      errors: json['errors'] ?? [],
    );
  }
}

class FavouriteData {
  final String type;
  final FavouriteAttributes attributes;

  FavouriteData({required this.type, required this.attributes});

  factory FavouriteData.fromJson(Map<String, dynamic> json) {
    return FavouriteData(
      type: json['type'],
      attributes: FavouriteAttributes.fromJson(json['attributes']),
    );
  }
}

class FavouriteAttributes {
  final String id;
  final String user;
  final String restaurant;
  final String folder;
  final String createdAt;
  final String updatedAt;

  FavouriteAttributes({
    required this.id,
    required this.user,
    required this.restaurant,
    required this.folder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FavouriteAttributes.fromJson(Map<String, dynamic> json) {
    return FavouriteAttributes(
      id: json['_id'] ?? "",
      user: json['user'] ?? "",
      restaurant: json['restaurant'] ?? "",
      folder: json['folder'] ?? "",
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
    );
  }
}
