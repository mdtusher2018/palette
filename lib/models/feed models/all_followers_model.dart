class AllFollowerModel {
  final String status;
  final int statusCode;
  final String message;
  final List<FollowerUser> attributes;

  AllFollowerModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.attributes,
  });

  factory AllFollowerModel.fromJson(Map<String, dynamic> json) {
    return AllFollowerModel(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      attributes: (json['data']?['attributes'] as List<dynamic>?)
              ?.map((e) => FollowerUser.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class FollowerUser {
  final String id;
  final String fullName;
  final String image;
  bool isFollower;

  FollowerUser({
    required this.id,
    required this.fullName,
    required this.image,
    this.isFollower = true,
  });

  factory FollowerUser.fromJson(Map<String, dynamic> json) {
    return FollowerUser(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      image: json['image'] ?? '',
      isFollower: true,
    );
  }
}
