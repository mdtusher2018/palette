class NearbyRestaurantsResponse {
  final int status;
  final int statusCode;
  final String message;
  final RestaurantData data;

  NearbyRestaurantsResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory NearbyRestaurantsResponse.fromJson(Map<String, dynamic> json) {
    return NearbyRestaurantsResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: RestaurantData.fromJson(json['data']),
    );
  }
}

class RestaurantData {
  final String type;
  final List<RestaurantAttribute> attributes;

  RestaurantData({
    required this.type,
    required this.attributes,
  });

  factory RestaurantData.fromJson(Map<String, dynamic> json) {
    return RestaurantData(
      type: json['type'],
      attributes: List<RestaurantAttribute>.from(
        json['attributes'].map((x) => RestaurantAttribute.fromJson(x)),
      ),
    );
  }
}

class RestaurantAttribute {
  final String id;
  final String fullName;
  final Location location;

  RestaurantAttribute({
    required this.id,
    required this.fullName,
    required this.location,
  });

  factory RestaurantAttribute.fromJson(Map<String, dynamic> json) {
    return RestaurantAttribute(
      id: json['_id'],
      fullName: json['fullName'],
      location: Location.fromJson(json['location']),
    );
  }
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      coordinates:
          List<double>.from(json['coordinates'].map((x) => x.toDouble())),
    );
  }

  double get longitude => coordinates[0];
  double get latitude => coordinates[1];
}
