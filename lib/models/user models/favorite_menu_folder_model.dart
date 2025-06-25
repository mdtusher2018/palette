class FavoriteMenuFoldersFetchResponse {
  final int status;
  final int statusCode;
  final String message;
  final FolderData data;

  FavoriteMenuFoldersFetchResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory FavoriteMenuFoldersFetchResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteMenuFoldersFetchResponse(
      status: json['status'] ?? 0,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: FolderData.fromJson(json['data'] ?? {}),
    );
  }
}

class FolderData {
  final String type;
  final List<MenuFolderAttributes> attributes;

  FolderData({
    required this.type,
    required this.attributes,
  });

  factory FolderData.fromJson(Map<String, dynamic> json) {
    return FolderData(
      type: json['type'] ?? '',
      attributes: (json['attributes'] as List<dynamic>?)
              ?.map((e) => MenuFolderAttributes.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class MenuFolderAttributes {
  final String id;
  final String foldername;
  final List<MenuImage> menuImages;

  MenuFolderAttributes({
    required this.id,
    required this.foldername,
    required this.menuImages,
  });

  factory MenuFolderAttributes.fromJson(Map<String, dynamic> json) {
    return MenuFolderAttributes(
      id: json['_id'] ?? '',
      foldername: json['foldername'] ?? '',
      menuImages: (json['menuImages'] as List<dynamic>?)
              ?.map((e) => MenuImage.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class MenuImage {
  final String image;

  MenuImage({required this.image});

  factory MenuImage.fromJson(Map<String, dynamic> json) {
    return MenuImage(
      image: json['image'] ?? '',
    );
  }
}
