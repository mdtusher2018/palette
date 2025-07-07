class FoodMenuDetailsResponse {
  String status;
  int statusCode;
  String message;
  FoodMenuData data;

  FoodMenuDetailsResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory FoodMenuDetailsResponse.fromJson(Map<String, dynamic> json) {
    return FoodMenuDetailsResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: FoodMenuData.fromJson(json['data']),
    );
  }
}

class FoodMenuData {
  String type;
  List<FoodMenuAttributes> attributes;

  FoodMenuData({
    required this.type,
    required this.attributes,
  });

  factory FoodMenuData.fromJson(Map<String, dynamic> json) {
    return FoodMenuData(
      type: json['type'],
      attributes: List<FoodMenuAttributes>.from(
        json['attributes'].map((x) => FoodMenuAttributes.fromJson(x)),
      ),
    );
  }
}

class FoodMenuAttributes {
  String id;
  String name;
  String image;
  String description;
  double price;
  String category; // <- changed from List<String> to String
  double rating;
  List<FoodFeedbackModel> feedbacks;
  String restaurentName;
  String restaurentId;
  bool  isFavourite;

  FoodMenuAttributes({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.category,
    required this.rating,
    required this.feedbacks,
    required this.restaurentName,
    required this.restaurentId,
    required this.isFavourite
  });

  factory FoodMenuAttributes.fromJson(Map<String, dynamic> json) {
    return FoodMenuAttributes(
      id: json['_id'],
      name: json['name'],
      image: json['image'] ?? "",
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      category: json['category'], // <- now a String
      rating: (json['rating'] as num).toDouble(),
      feedbacks: json['feedbacks'] != null
          ? List<FoodFeedbackModel>.from(
              json['feedbacks'].map((x) => FoodFeedbackModel.fromJson(x)))
          : [],
      restaurentName: json['restaurentName'],
      restaurentId: json['restaurentId'],
      isFavourite:  json["isFavourite"]??false,
    );
  }
}

class FoodFeedbackModel {
  String id;
  String sender;
  double rating;
  String comment;
  String? image;
  String? video;
  String? createdAt;
  String? updatedAt;
  String reviewerName;
  String reviewerImage;
  String reviewerId;

  FoodFeedbackModel({
    required this.id,
    required this.sender,
    required this.rating,
    required this.comment,
    this.image,
    this.video,
    this.createdAt,
    this.updatedAt,
    required this.reviewerName,
    required this.reviewerImage,
    required this.reviewerId,
  });

  factory FoodFeedbackModel.fromJson(Map<String, dynamic> json) {
    return FoodFeedbackModel(
      id: json['_id'],
      sender: json['sender'],
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'],
      image: json['image'],
      video: json['video'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      reviewerName: json['reviewerName'],
      reviewerImage: json['reviewerImage'],
      reviewerId: json['reviewerId'],
    );
  }
}
