class NotificationModel {
  final String status;
  final int statusCode;
  final String message;
  final NotificationData data;

  NotificationModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: NotificationData.fromJson(json['data'] ?? {}),
    );
  }
}

class NotificationData {
  final String type;
  final List<NotificationItem> attributes;

  NotificationData({
    required this.type,
    required this.attributes,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      type: json['type'] ?? '',
      attributes: (json['attributes'] as List<dynamic>?)
              ?.map((e) => NotificationItem.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class NotificationItem {
  final String id;
  final String sender;
  final String target;
  final String type;
  final bool toAdmin;
  final String message;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationItem({
    required this.id,
    required this.sender,
    required this.target,
    required this.type,
    required this.toAdmin,
    required this.message,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['_id'] ?? '',
      sender: json['sender'] ?? '',
      target: json['target'] ?? '',
      type: json['type'] ?? '',
      toAdmin: json['toAdmin'] ?? false,
      message: json['message'] ?? '',
      isRead: json['isRead'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}
