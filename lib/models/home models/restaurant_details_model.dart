import 'package:palette/models/common_models.dart';

class RestaurantDetailsResponse {
  final int? status;
  final int? statusCode;
  final String? message;
  final RestaurantData? data;

  RestaurantDetailsResponse({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory RestaurantDetailsResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailsResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null ? RestaurantData.fromJson(json['data']) : null,
    );
  }
}

class RestaurantData {
  final String? type;
  final RestaurantAttributes? attributes;

  RestaurantData({
    this.type,
    this.attributes,
  });

  factory RestaurantData.fromJson(Map<String, dynamic> json) {
    return RestaurantData(
      type: json['type'],
      attributes: json['attributes'] != null
          ? RestaurantAttributes.fromJson(json['attributes'])
          : null,
    );
  }
}

class RestaurantAttributes {
  final String? id;
  final String? fullName;
  final String? image;
  final String? coverImage;
  final String? address;
  final String? phoneNumber;
  final Restaurant? restaurant;
  final List<RestaurantFeedback> feedbacks;
  final List<String> gallery;
  final List<RestaurantMenu> menus;
    bool  isFavourite; 

  RestaurantAttributes({
    this.id,
    this.fullName,
    this.image,
    this.coverImage,
    this.address,
    this.phoneNumber,
    this.restaurant,
    required this.feedbacks,
    required this.gallery,
    required this.menus,  required this.isFavourite
  });

  factory RestaurantAttributes.fromJson(Map<String, dynamic> json) {
    return RestaurantAttributes(
      id: json['_id'],
      fullName: json['fullName'],
      image: json['image'],
      coverImage: json['coverImage'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      restaurant: json['restaurant'] != null
          ? Restaurant.fromJson(json['restaurant'])
          : null,
      feedbacks: (json['feedbacks'] as List?)
              ?.map((f) => RestaurantFeedback.fromJson(f))
              .toList() ??
          [],
      gallery: (json['gallery'] as List?)?.cast<String>() ?? [],
      menus: (json['menus'] as List?)
              ?.map((m) => RestaurantMenu.fromJson(m))
              .toList() ??
          [],     isFavourite:  json["isFavourite"]??false,
    );
  }
}

class Restaurant {
  final String id;
  final String user;
  final List<String> cuisines;
  final List<OpenHour> openHours;
  final String? createdAt;
  final String? updatedAt;
  final double rating;
  final int totalFeedback;
  final bool? checkin;

  Restaurant(
      {required this.id,
      required this.user,
      required this.cuisines,
      required this.openHours,
      this.createdAt,
      this.updatedAt,
      required this.rating,
      required this.totalFeedback,
      this.checkin});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['_id'] ?? "",
      user: json['user'] ?? "",
      cuisines: (json['cuisines'] as List?)?.cast<String>() ?? [],
      openHours: (json['openHours'] == null)
          ? []
          : (json['openHours'] as List?)
                  ?.map((o) => OpenHour.fromJson(o))
                  .toList() ??
              [],
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalFeedback: json['totalfeedback'] ?? 0,
      checkin: json['checkin'] ?? false,
    );
  }
}

class OpenHour {
  final String? day;
  final bool isOpen;
  final String? openingTime;
  final String? closingTime;

  OpenHour({
    this.day,
    required this.isOpen,
    this.openingTime,
    this.closingTime,
  });

  factory OpenHour.fromJson(Map<String, dynamic> json) {
    return OpenHour(
      day: json['day'],
      isOpen: json['isOpen'] ?? false,
      openingTime: json['openingTime'],
      closingTime: json['closingTime'],
    );
  }
}
