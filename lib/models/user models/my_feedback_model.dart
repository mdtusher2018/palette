class MyFeedbackModel {
  final String status;
  final int statusCode;
  final String message;
  final MyFeedbackData data;

  MyFeedbackModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory MyFeedbackModel.fromJson(Map<String, dynamic> json) {
    return MyFeedbackModel(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: MyFeedbackData.fromJson(json['data']),
    );
  }
}

class MyFeedbackData {
  final String type;
  final List<MyFeedback> attributes;

  MyFeedbackData({
    required this.type,
    required this.attributes,
  });

  factory MyFeedbackData.fromJson(Map<String, dynamic> json) {
    return MyFeedbackData(
      type: json['type'],
      attributes: List<MyFeedback>.from(
        json['attributes'].map((x) => MyFeedback.fromJson(x)),
      ),
    );
  }
}

class MyFeedback {
  final String id;
  final double rating;
  final String comment;
  final String createdAt;
  final String reviewerName;
  final String reviewerImage;
  final String reviewerId;
  final String? image;
  final String? video;

  MyFeedback({
    required this.id,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.reviewerName,
    required this.reviewerImage,
    required this.reviewerId,
    this.image,
    this.video,
  });

  factory MyFeedback.fromJson(Map<String, dynamic> json) {
    return MyFeedback(
      id: json['_id'],
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'],
      createdAt: json['createdAt'],
      reviewerName: json['reviewerName'],
      reviewerImage: json['reviewerImage'],
      reviewerId: json['reviewerId'],
      image: json['image'], // optional
      video: json['video'], // optional
    );
  }
}
