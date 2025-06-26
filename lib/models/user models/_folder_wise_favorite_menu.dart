import 'package:palette/models/common_models.dart';

class FolderWiseFavouriteResponse {
  final String status;
  final int statusCode;
  final String message;
  final FolderWiseFavouriteData data;

  FolderWiseFavouriteResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory FolderWiseFavouriteResponse.fromJson(Map<String, dynamic> json) {
    return FolderWiseFavouriteResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: FolderWiseFavouriteData.fromJson(json['data']),
    );
  }
}

class FolderWiseFavouriteData {
  final String type;
  final List<FolderWiseFavouriteAttribute> attributes;

  FolderWiseFavouriteData({
    required this.type,
    required this.attributes,
  });

  factory FolderWiseFavouriteData.fromJson(Map<String, dynamic> json) {
    return FolderWiseFavouriteData(
      type: json['type'],
      attributes: List<FolderWiseFavouriteAttribute>.from(
        json['attributes'].map((x) => FolderWiseFavouriteAttribute.fromJson(x)),
      ),
    );
  }
}

class FolderWiseFavouriteAttribute {
  final String folderName;
  final String folderId;
  final List<FolderWiseFavouriteItem> favourites;

  FolderWiseFavouriteAttribute({
    required this.folderName,
    required this.folderId,
    required this.favourites,
  });

  factory FolderWiseFavouriteAttribute.fromJson(Map<String, dynamic> json) {
    return FolderWiseFavouriteAttribute(
      folderName: json['folderName'],
      folderId: json['folderId'],
      favourites: List<FolderWiseFavouriteItem>.from(
        json['favourites'].map((x) => FolderWiseFavouriteItem.fromJson(x)),
      ),
    );
  }
}

class FolderWiseFavouriteItem {
  final String id;
  final FolderWiseMenu menu;
  final DateTime createdAt;
  final DateTime updatedAt;

  FolderWiseFavouriteItem({
    required this.id,
    required this.menu,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FolderWiseFavouriteItem.fromJson(Map<String, dynamic> json) {
    return FolderWiseFavouriteItem(
      id: json['_id'],
      menu: FolderWiseMenu.fromJson(json['menu']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class FolderWiseMenu {
  final String id;
  final String itemName;
  final String image;
  final double rating;
  final Category category;
  final FolderWiseRestaurant restaurent;

  FolderWiseMenu({
    required this.id,
    required this.itemName,
    required this.image,
    required this.rating,
    required this.category,
    required this.restaurent,
  });

  factory FolderWiseMenu.fromJson(Map<String, dynamic> json) {
    return FolderWiseMenu(
      id: json['_id'],
      itemName: json['itemName'],
      image: json['image'],
      rating: (json['rating'] as num).toDouble(),
      category: Category.fromJson(json['category']),
      restaurent: FolderWiseRestaurant.fromJson(json['restaurent']),
    );
  }
}

class FolderWiseRestaurant {
  final String id;
  final String fullName;

  FolderWiseRestaurant({
    required this.id,
    required this.fullName,
  });

  factory FolderWiseRestaurant.fromJson(Map<String, dynamic> json) {
    return FolderWiseRestaurant(
      id: json['_id'],
      fullName: json['fullName'],
    );
  }
}
