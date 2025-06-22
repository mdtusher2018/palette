import 'package:palette/models/common_models.dart';

class MyLogsResponse {
  final String status;
  final int statusCode;
  final String type;
  final String message;
  final List<LogEntry> data;

  MyLogsResponse({
    required this.status,
    required this.statusCode,
    required this.type,
    required this.message,
    required this.data,
  });

  factory MyLogsResponse.fromJson(Map<String, dynamic> json) {
    return MyLogsResponse(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      type: json['type'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => LogEntry.fromJson(e))
              .toList() ??
          [],
    );
  }
}
