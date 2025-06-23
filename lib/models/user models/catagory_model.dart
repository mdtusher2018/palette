class FoodCategoryModel {
  final String status;
  final int statusCode;
  final String message;
  final FoodCategoryData data;

  FoodCategoryModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory FoodCategoryModel.fromJson(Map<String, dynamic> json) {
    return FoodCategoryModel(
      status: json['status'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: FoodCategoryData.fromJson(json['data'] ?? {}),
    );
  }
}

class FoodCategoryData {
  final String type;
  final List<FoodCategory> attributes;

  FoodCategoryData({
    required this.type,
    required this.attributes,
  });

  factory FoodCategoryData.fromJson(Map<String, dynamic> json) {
    return FoodCategoryData(
      type: json['type'] ?? '',
      attributes: (json['attributes'] as List<dynamic>?)
              ?.map((e) => FoodCategory.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class FoodCategory {
  final String id;
  final String name;

  FoodCategory({
    required this.id,
    required this.name,
  });

  factory FoodCategory.fromJson(Map<String, dynamic> json) {
    return FoodCategory(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
