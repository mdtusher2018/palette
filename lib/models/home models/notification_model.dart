class NotificationResponseModel {
  final String status;
  final int statusCode;
  final String message;
  final NotificationData data;
  final List<dynamic> errors;

  NotificationResponseModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    return NotificationResponseModel(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: NotificationData.fromJson(json['data']),
      errors: json['errors'] ?? [],
    );
  }
}

class NotificationData {
  final String type;
  final NotificationAttributes attributes;

  NotificationData({
    required this.type,
    required this.attributes,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      type: json['type'],
      attributes: NotificationAttributes.fromJson(json['attributes']),
    );
  }
}

class NotificationAttributes {
  final List<NotificationItem> notification;
  final Pagination pagination;

  NotificationAttributes({
    required this.notification,
    required this.pagination,
  });

  factory NotificationAttributes.fromJson(Map<String, dynamic> json) {
    return NotificationAttributes(
      notification: (json['notification'] as List)
          .map((e) => NotificationItem.fromJson(e))
          .toList(),
      pagination: Pagination.fromJson(json['pagination']),
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
  final int v;

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
    required this.v,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['_id'],
      sender: json['sender'],
      target: json['target'],
      type: json['type'],
      toAdmin: json['toAdmin'],
      message: json['message'],
      isRead: json['isRead'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}

class Pagination {
  final int page;
  final int limit;
  final int totalPages;
  final int totalResults;

  Pagination({
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.totalResults,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
      totalResults: json['totalResults'],
    );
  }
}
