// model/my_profile_model.dart

import 'package:palette/models/common_models.dart';
import 'package:palette/models/user%20models/UserCurrentChallengeModel.dart';

class MyProfileModel {
  String status;
  int statusCode;
  String message;
  MyProfileData data;

  MyProfileModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory MyProfileModel.fromJson(Map<String, dynamic> json) {
    return MyProfileModel(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: MyProfileData.fromJson(json['data']),
    );
  }
}

class MyProfileData {
  String type;
  List<MyProfileAttributes> attributes;

  MyProfileData({
    required this.type,
    required this.attributes,
  });

  factory MyProfileData.fromJson(Map<String, dynamic> json) {
    return MyProfileData(
      type: json['type'],
      attributes: List<MyProfileAttributes>.from(
        json['attributes'].map((x) => MyProfileAttributes.fromJson(x)),
      ),
    );
  }
}

class MyProfileAttributes {
  String id;
  String fullName;
  String image;
  int followers;
  int following;
  List<Badge> badges; // <-- updated
  List<SingleChallenge> topChallenges;

  MyProfileAttributes({
    required this.id,
    required this.fullName,
    required this.image,
    required this.followers,
    required this.following,
    required this.badges, // <-- updated
    required this.topChallenges,
  });

  factory MyProfileAttributes.fromJson(Map<String, dynamic> json) {
    return MyProfileAttributes(
      id: json['_id'],
      fullName: json['fullName'],
      image: json['image'],
      followers: json['followers'],
      following: json['following'],
      badges:
          (json['badges'] as List?)?.map((e) => Badge.fromJson(e)).toList() ??
              [],
      topChallenges: List<SingleChallenge>.from(
        json['topChallenges'].map((x) => SingleChallenge.fromJson(x)),
      ),
    );
  }
}
