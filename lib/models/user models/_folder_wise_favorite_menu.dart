class FavouriteFoundResponse {
  final String status;
  final int statusCode;
  final String message;
  final FavouriteData data;
  final List<dynamic> errors;

  FavouriteFoundResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory FavouriteFoundResponse.fromJson(Map<String, dynamic> json) {
    return FavouriteFoundResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: FavouriteData.fromJson(json['data'] ?? {}),
      errors: json['errors'] ?? [],
    );
  }
}

class FavouriteData {
  final String type;
  final List<FavouriteAttribute> attributes;

  FavouriteData({
    required this.type,
    required this.attributes,
  });

  factory FavouriteData.fromJson(Map<String, dynamic> json) {
    return FavouriteData(
      type: json['type'] ?? '',
      attributes: (json['attributes'] as List)
          .map((e) => FavouriteAttribute.fromJson(e))
          .toList(),
    );
  }
}

class FavouriteAttribute {
  final String folderName;
  final String folderId;
  final List<FavouriteItem> favourites;

  FavouriteAttribute({
    required this.folderName,
    required this.folderId,
    required this.favourites,
  });

  factory FavouriteAttribute.fromJson(Map<String, dynamic> json) {
    return FavouriteAttribute(
      folderName: json['folderName'] ?? '',
      folderId: json['folderId'] ?? '',
      favourites: (json['favourites'] as List)
          .map((e) => FavouriteItem.fromJson(e))
          .toList(),
    );
  }
}

class FavouriteItem {
  final String id;
  final Menu menu;
  final DateTime createdAt;
  final DateTime updatedAt;

  FavouriteItem({
    required this.id,
    required this.menu,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FavouriteItem.fromJson(Map<String, dynamic> json) {
    return FavouriteItem(
      id: json['_id'] ?? '',
      menu: Menu.fromJson(json['menu'] ?? {}),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Menu {
  final String id;
  final String itemName;
  final String image;
  final double rating;
  final Category category;
  final Restaurant restaurent;

  Menu({
    required this.id,
    required this.itemName,
    required this.image,
    required this.rating,
    required this.category,
    required this.restaurent,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['_id'] ?? '',
      itemName: json['itemName'] ?? '',
      image: json['image'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      category: Category.fromJson(json['category'] ?? {}),
      restaurent: Restaurant.fromJson(json['restaurent'] ?? {}),
    );
  }
}

class Category {
  final String id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class Restaurant {
  final String id;
  final String fullName;

  Restaurant({
    required this.id,
    required this.fullName,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
    );
  }
}
