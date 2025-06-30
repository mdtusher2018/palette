class AllFollowingModel {
  final String status;
  final int statusCode;
  final String message;
  final List<FollowingUser> attributes;

  AllFollowingModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.attributes,
  });

  factory AllFollowingModel.fromJson(Map<String, dynamic> json) {
    return AllFollowingModel(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      attributes: (json['data']?['attributes'] as List<dynamic>?)
              ?.map((e) => FollowingUser.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class FollowingUser {
  final String id;
  final String fullName;
  final String image;
  bool isFollowing; // toggle-able field

  FollowingUser({
    required this.id,
    required this.fullName,
    required this.image,
    this.isFollowing = true, // default to true
  });

  factory FollowingUser.fromJson(Map<String, dynamic> json) {
    return FollowingUser(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      image: json['image'] ?? '',
      isFollowing:
          json['isFollowing'], // always default true unless handled manually
    );
  }
}
