import 'dart:io';

import 'package:palette/models/home%20models/AddFavouriteResponse.dart';
import 'package:palette/models/home%20models/ads_monetization_model.dart';
import 'package:palette/models/home%20models/create_folder_response.dart';
import 'package:palette/models/home%20models/feedback_by_restaurent_id.dart';
import 'package:palette/models/home%20models/for_you_model.dart';
import 'package:palette/models/home%20models/gallery_by_restaurant_id.dart';
import 'package:palette/models/home%20models/hightlight_model.dart';
import 'package:palette/models/home%20models/menu_by_restaurent_id_model.dart';
import 'package:palette/models/home%20models/menu_details_model.dart';
import 'package:palette/models/home%20models/notification_model.dart';
import 'package:palette/models/home%20models/personal_status_model.dart';
import 'package:palette/models/home%20models/restaurant_details_model.dart';
import 'package:palette/models/home%20models/submit_feedback_model.dart';
import 'package:palette/models/user%20models/favorite_menu_folder_model.dart';
import 'package:palette/services/api_service.dart';
import 'package:palette/utils/api_endpoints.dart';
import 'package:palette/views/Home/checkin_model.dart';

class HomeService {
  final ApiService apiService = ApiService();

  Future<ForYouResponse> fetchForYou() async {
    final jsonResponse = await apiService.get(ApiEndpoints.forYou);
    return ForYouResponse.fromJson(jsonResponse);
  }

  Future<HighLightsResponse> fetchHighLights() async {
    final jsonResponse = await apiService.get(ApiEndpoints.highlights);
    return HighLightsResponse.fromJson(jsonResponse);
  }

  Future<FoodMenuDetailsResponse> fetchMenuDetailsByid(String id) async {
    final jsonResponse = await apiService.get(ApiEndpoints.getMenuDetails(id));
    return FoodMenuDetailsResponse.fromJson(jsonResponse);
  }

  Future<AdsMonetizationResponse> fetchAds() async {
    final jsonResponse = await apiService.get(ApiEndpoints.ads);
    return AdsMonetizationResponse.fromJson(jsonResponse);
  }

  Future<FeedbackResponse> submitFoodFeedback({
    required String menuId,
    required String comment,
    required int rating,
    File? image,
    File? video,
  }) async {
    final response = await apiService.postMultipart(
      url: ApiEndpoints.submitMenuFeedback,
      fields: {
        'menu': menuId,
        'comment': comment,
        'rating': rating.toString(),
      },
      imageFile: image,
      videoFile: video,
    );
    return FeedbackResponse.fromJson(response);
  }

  Future<FeedbackResponse> submitRestaurantFeedback({
    required String restaurantId,
    required String comment,
    required int rating,
    File? image,
    File? video,
  }) async {
    final response = await apiService.postMultipart(
      url: ApiEndpoints.submitRestaurantFeedback,
      fields: {
        'restaurant': restaurantId,
        'comment': comment,
        'rating': rating.toString(),
      },
      imageFile: image,
      videoFile: video,
    );
    return FeedbackResponse.fromJson(response);
  }

  Future<UserStatusResponse> fetchUserStatus() async {
    final jsonResponse = await apiService.get(ApiEndpoints.userStatus);
    return UserStatusResponse.fromJson(jsonResponse);
  }

  Future<RestaurantDetailsResponse> fetchRestaurantDetailsByid(
      String id) async {
    final jsonResponse =
        await apiService.get(ApiEndpoints.getRestaurantDetails(id));
    return RestaurantDetailsResponse.fromJson(jsonResponse);
  }

  Future<MenuByRestaurantIdResponse> fetchMenuRestaurantByid(String id) async {
    final jsonResponse =
        await apiService.get(ApiEndpoints.getMenuByRestaurantId(id));
    return MenuByRestaurantIdResponse.fromJson(jsonResponse);
  }

  Future<GalleriesByRestautentIdResponse> fetchGalleryRestaurantByid(
      String id) async {
    final jsonResponse =
        await apiService.get(ApiEndpoints.getGarallyByRestaurantId(id));
    return GalleriesByRestautentIdResponse.fromJson(jsonResponse);
  }

  Future<FeedbackByRestaurantIdResponse> fetchFeedbackRestaurantByid(
      String id) async {
    final jsonResponse =
        await apiService.get(ApiEndpoints.getFeedbackRestaurantId(id));
    return FeedbackByRestaurantIdResponse.fromJson(jsonResponse);
  }

  Future<CheckInResponse> postCheckIn(String restaurantId) async {
    final response = await apiService.post(
      ApiEndpoints.checkIn,
      {"restaurent": restaurantId},
    );
    return CheckInResponse.fromJson(response);
  }

  Future<FavoriteMenuFoldersFetchResponse> fetchMyFolder() async {
    final jsonResponse =
        await apiService.get(ApiEndpoints.myFavoriteMenuFolders);
    return FavoriteMenuFoldersFetchResponse.fromJson(jsonResponse);
  }

  Future<CreateFolderResponse> createFolder(String folderName) async {
    final response = await apiService.post(
      ApiEndpoints.postMyFolder,
      {'foldername': folderName},
    );

    return CreateFolderResponse.fromJson(response);
  }

  Future<AddFavouriteResponse> addFavourite({
    required String restaurantId,
    required String folderId,
  }) async {
    final response = await apiService.post(ApiEndpoints.addFavorite, {
      if (folderId.isNotEmpty) "folder": folderId,
      if (folderId.isNotEmpty) "menu": restaurantId,
      if (folderId.isEmpty) "restaurant": restaurantId,
    });

    return AddFavouriteResponse.fromJson(response);
  }

  Future<NotificationModel> fetctNotification() async {
    final jsonResponse = await apiService.get(ApiEndpoints.notification);
    return NotificationModel.fromJson(jsonResponse);
  }
}
