class FeedbackResponse {
  final String message;
  final FeedbackData data;

  FeedbackResponse({required this.message, required this.data});

  factory FeedbackResponse.fromJson(Map<String, dynamic> json) {
    return FeedbackResponse(
      message: json['message'],
      data: FeedbackData.fromJson(json['data']['attributes']),
    );
  }
}

class FeedbackData {
  final String id;
  final String sender;
  final String menu;
  final String restaurant;
  final String comment;
  final int rating;
  final String createdAt;

  FeedbackData({
    required this.id,
    required this.sender,
    required this.menu,
    required this.restaurant,
    required this.comment,
    required this.rating,
    required this.createdAt,
  });

  factory FeedbackData.fromJson(Map<String, dynamic> json) {
    return FeedbackData(
      id: json['_id'],
      sender: json['sender'],
      menu: json['menu'] ?? "",
      restaurant: json['restaurant'] ?? "",
      comment: json['comment'],
      rating: json['rating'],
      createdAt: json['createdAt'],
    );
  }
}
