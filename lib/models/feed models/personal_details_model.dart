import 'package:palette/models/common_models.dart';

class PersonalDetailsModel {
  final String status;
  final int statusCode;
  final String message;
  final UserData data;

  PersonalDetailsModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory PersonalDetailsModel.fromJson(Map<String, dynamic> json) {
    return PersonalDetailsModel(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: UserData.fromJson(json['data'] ?? {}),
    );
  }
}

class UserData {
  final String type;
  final List<PersonalUserAttributes> attributes;

  UserData({
    required this.type,
    required this.attributes,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      type: json['type'] ?? '',
      attributes: (json['attributes'] as List<dynamic>? ?? [])
          .map((e) => PersonalUserAttributes.fromJson(e))
          .toList(),
    );
  }
}

class PersonalUserAttributes {
  final String id;
  final String fullName;
  final String image;
  final String coverImage;
  final int followers;
  final int following;
  final int logsCount;
  final String aboutme;
  final List<PrivateLogEntry> logs;
  final int favourites;
  final String mostVisited;
  final int logThisWeek;
  List<Badge> badges; // <-- updated

  PersonalUserAttributes({
    required this.id,
    required this.fullName,
    required this.image,
    required this.coverImage,
    required this.followers,
    required this.following,
    required this.logsCount,
    required this.aboutme,
    required this.logs,
    required this.favourites,
    required this.mostVisited,
    required this.logThisWeek,
    required this.badges, // <-- updated
  });

  factory PersonalUserAttributes.fromJson(Map<String, dynamic> json) {
    return PersonalUserAttributes(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      image: json['image'] ?? '',
      coverImage: json['coverImage'] ?? '',
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      logsCount: json['logsCount'] ?? 0,
      aboutme: json['aboutme'] ?? '',
      logs: (json['logs'] as List<dynamic>? ?? [])
          .map((e) => PrivateLogEntry.fromJson(e))
          .toList(),
      favourites: json['favourites'] ?? 0,
      mostVisited: json['mostVisited'] ?? '',
      logThisWeek: json['logThisWeek'] ?? 0,
      badges:
          (json['badges'] as List?)?.map((e) => Badge.fromJson(e)).toList() ??
              [],
    );
  }
}

class PrivateLogEntry {
  final String id;
  final String user;
  final String restaurent;
  final String item;
  final String image;
  final String video;
  final double rating;
  final String notes;
  final String createdAt;
  final String updatedAt;
  final int v;

  final String? itemName;
  final String? userName;
  final String? userImage;

  PrivateLogEntry({
    required this.id,
    required this.user,
    required this.restaurent,
    required this.item,
    required this.image,
    required this.video,
    required this.rating,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.itemName,
    this.userName,
    this.userImage,
  });

  factory PrivateLogEntry.fromJson(Map<String, dynamic> json) {
    return PrivateLogEntry(
      id: json['_id'] ?? '',
      user: json['user'] ?? '',
      restaurent: json['restaurent'] ?? '',
      item: json['item'] ?? '',
      image: json['image'] ?? '',
      video: json['video'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      notes: json['notes'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
      itemName: json['itemName'],
      userName: json['userName'],
      userImage: json['userImage'],
    );
  }
}
