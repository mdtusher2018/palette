class UnfavouriteResponse {
  final String status;
  final int statusCode;
  final String message;
  final UnfavouriteData data;

  UnfavouriteResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory UnfavouriteResponse.fromJson(Map<String, dynamic> json) {
    return UnfavouriteResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: UnfavouriteData.fromJson(json['data'] ?? {}),
    );
  }
}

class UnfavouriteData {
  final String type;
  final UnfavouriteAttributes attributes;

  UnfavouriteData({
    required this.type,
    required this.attributes,
  });

  factory UnfavouriteData.fromJson(Map<String, dynamic> json) {
    return UnfavouriteData(
      type: json['type'] ?? '',
      attributes: UnfavouriteAttributes.fromJson(json['attributes'] ?? {}),
    );
  }
}

class UnfavouriteAttributes {
  final bool acknowledged;
  final int deletedCount;

  UnfavouriteAttributes({
    required this.acknowledged,
    required this.deletedCount,
  });

  factory UnfavouriteAttributes.fromJson(Map<String, dynamic> json) {
    return UnfavouriteAttributes(
      acknowledged: json['acknowledged'] ?? false,
      deletedCount: json['deletedCount'] ?? 0,
    );
  }
}
