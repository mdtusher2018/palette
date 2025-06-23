import 'package:palette/models/common_models.dart';

class GoogleSignInResponseModel {
  final String status;
  final int statusCode;
  final String message;
  final GoogleUserData data;

  GoogleSignInResponseModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory GoogleSignInResponseModel.fromJson(Map<String, dynamic> json) {
    return GoogleSignInResponseModel(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: GoogleUserData.fromJson(json['data'] ?? {}),
    );
  }
}

class GoogleUserData {
  final String type;
  final UserAttributes attributes;
  final String accessToken;

  GoogleUserData({
    required this.type,
    required this.attributes,
    required this.accessToken,
  });

  factory GoogleUserData.fromJson(Map<String, dynamic> json) {
    return GoogleUserData(
      type: json['type'] ?? '',
      attributes: UserAttributes.fromJson(json['attributes'] ?? {}),
      accessToken: json['accessToken'] ?? '',
    );
  }
}
