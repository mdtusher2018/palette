class FeedbackPinUnpinResponse {
  final String status;
  final int statusCode;
  final String message;
  final FeedbackData data;
  final List<dynamic> errors;

  FeedbackPinUnpinResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory FeedbackPinUnpinResponse.fromJson(Map<String, dynamic> json) {
    return FeedbackPinUnpinResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: FeedbackData.fromJson(json['data'] ?? {}),
      errors: json['errors'] ?? [],
    );
  }
}

class FeedbackData {
  final FeedbackAttributes attributes;

  FeedbackData({
    required this.attributes,
  });

  factory FeedbackData.fromJson(Map<String, dynamic> json) {
    return FeedbackData(
      attributes: FeedbackAttributes.fromJson(json['attributes'] ?? {}),
    );
  }
}

class FeedbackAttributes {
  final String id;
  final String sender;
  final String? image;
  final String? video;
  final String menu;
  final String type;
  final int rating;
  final String comment;
  final bool pinned;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  FeedbackAttributes({
    required this.id,
    required this.sender,
    this.image,
    this.video,
    required this.menu,
    required this.type,
    required this.rating,
    required this.comment,
    required this.pinned,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory FeedbackAttributes.fromJson(Map<String, dynamic> json) {
    return FeedbackAttributes(
      id: json['_id'] ?? '',
      sender: json['sender'] ?? '',
      image: json['image'],
      video: json['video'],
      menu: json['menu'] ?? '',
      type: json['type'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      pinned: json['pinned'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      v: json['__v'] ?? 0,
    );
  }
}
