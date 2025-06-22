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
import 'package:palette/models/home%20models/my_folders_model.dart';
import 'package:palette/models/home%20models/notification_model.dart';
import 'package:palette/models/home%20models/personal_status_model.dart';
import 'package:palette/models/home%20models/restaurant_details_model.dart';
import 'package:palette/services/home%20services/home_service.dart';
import 'package:palette/models/home%20models/submit_feedback_model.dart';
import 'package:palette/views/Home/checkin_model.dart';

class HomeRepository {
  final HomeService _homeService = HomeService();

  Future<ForYouResponse> getForYou() {
    return _homeService.fetchForYou();
  }

  Future<HighLightsResponse> getHighLights() {
    return _homeService.fetchHighLights();
  }

  Future<FoodMenuDetailsResponse> getMenuDetailsById(String id) async {
    return await _homeService.fetchMenuDetailsByid(id);
  }

  Future<AdsMonetizationResponse> getAds() async {
    return await _homeService.fetchAds();
  }

  Future<FeedbackResponse> submitFoodFeedback({
    required String menuId,
    required String restaurantId,
    required String comment,
    required int rating,
    File? image,
    File? video,
  }) {
    if (menuId.isNotEmpty) {
      return _homeService.submitFoodFeedback(
        menuId: menuId,
        comment: comment,
        rating: rating,
        image: image,
        video: video,
      );
    } else {
      return _homeService.submitRestaurantFeedback(
        restaurantId: restaurantId,
        comment: comment,
        rating: rating,
        image: image,
        video: video,
      );
    }
  }

  Future<UserStatusResponse> getUserStatus() async {
    return await _homeService.fetchUserStatus();
  }

  Future<RestaurantDetailsResponse> getRestaurantDetailsById(String id) async {
    return await _homeService.fetchRestaurantDetailsByid(id);
  }

  Future<MenuByRestaurantIdResponse> getMenuByRestaurantId(String id) async {
    return await _homeService.fetchMenuRestaurantByid(id);
  }

  Future<GalleriesByRestautentIdResponse> getGalleriesByRestaurantId(
      String id) async {
    return await _homeService.fetchGalleryRestaurantByid(id);
  }

  Future<FeedbackByRestaurantIdResponse> getFeedbackByRestaurantId(
      String id) async {
    return await _homeService.fetchFeedbackRestaurantByid(id);
  }

  Future<CheckInResponse> checkInToRestaurant(String restaurantId) {
    return _homeService.postCheckIn(restaurantId);
  }

  Future<FoldersResponse> getMyFolders() async {
    return await _homeService.fetchMyFolder();
  }

  Future<CreateFolderResponse> createFolder(String folderName) {
    return _homeService.createFolder(folderName);
  }

  Future<AddFavouriteResponse> addFavourite({
    required String restaurantId,
    required String folderId,
  }) {
    return _homeService.addFavourite(
      restaurantId: restaurantId,
      folderId: folderId,
    );
  }

  Future<NotificationModel> getNotifications() {
    return _homeService.fetctNotification();
  }
}
