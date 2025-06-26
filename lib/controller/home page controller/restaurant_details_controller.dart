import 'dart:developer';

import 'package:get/get.dart';
import 'package:palette/models/common_models.dart';
import 'package:palette/models/home%20models/feedback_by_restaurent_id.dart';
import 'package:palette/models/home%20models/restaurant_details_model.dart';
import 'package:palette/repositories/home%20repository/home_repository.dart';

class RestaurantDetailsController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();

  var isLoading = true.obs;
  var restaurantDetails = Rxn<RestaurantAttributes>();
  // Reactive state variables
  var isLoadingMenus = false.obs;
  var isLoadingGallery = false.obs;
  var isLoadingFeedback = false.obs;

  var menuList = <RestaurantMenu>[].obs;
  var galleryList = <String>[].obs;
  var feedbackList = <RestaurentFeedbackItem>[].obs;
  var folderList = <Map<String, String>>[].obs;

  var errorMessage = ''.obs;

  final String id;
  RestaurantDetailsController(this.id);

  Future<void> fetchRestaurantDetails(String id) async {
    try {
      isLoading.value = true;
      final response = await _homeRepository.getRestaurantDetailsById(id);

      restaurantDetails.value = response.data!.attributes;
    } catch (e) {
      log(e.toString());
      Get.snackbar("Error", "Failed to fetch restaurant details");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMenus(String restaurantId) async {
    try {
      isLoadingMenus.value = true;
      final response =
          await _homeRepository.getMenuByRestaurantId(restaurantId);
      menuList.value = response.data.attributes;
    } catch (e) {
      errorMessage.value = 'Failed to fetch menu: $e';
    } finally {
      isLoadingMenus.value = false;
    }
  }

  Future<void> fetchGallery(String restaurantId) async {
    try {
      isLoadingGallery.value = true;
      final response =
          await _homeRepository.getGalleriesByRestaurantId(restaurantId);
      galleryList.value = response.data.attributes.first.image;
    } catch (e) {
      errorMessage.value = 'Failed to fetch gallery: $e';
    } finally {
      isLoadingGallery.value = false;
    }
  }

  Future<void> fetchFeedback(String restaurantId) async {
    try {
      isLoadingFeedback.value = true;
      final response =
          await _homeRepository.getFeedbackByRestaurantId(restaurantId);
      feedbackList.value = response.data.attributes;
    } catch (e) {
      errorMessage.value = 'Failed to fetch feedback: $e';
    } finally {
      isLoadingFeedback.value = false;
    }
  }

  Future<void> checkInToRestaurant(String restaurantId) async {
    try {
      final response = await _homeRepository.checkInToRestaurant(restaurantId);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        Get.snackbar(
          "Check-In Successful",
          "You've checked in at ${response.data.attributes.restaurantName}",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar("Check-In Failed", "Unable to check in right now.");
        return;
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar("Check-In Failed", "Unable to check in right now.");
    }
  }

  Future<void> fetchFolders() async {
    try {
      errorMessage.value = '';

      final response = await _homeRepository.getMyFolders();

      // Extract just the folder names
      folderList.assignAll(
        response.data.attributes
            .map((e) => {
                  "id": e.id, // Assuming e._id was parsed as `id` in your model
                  "foldername": e.foldername,
                })
            .toList(),
      );
    } catch (e) {
      log("Folder Fetch Error: $e");
      errorMessage.value = 'Failed to load folders';
    } finally {
      isLoading.value = false;
    }
  }

  Future<String>? createNewFolder(String name) async {
    try {
      final response = await _homeRepository.createFolder(name);

      Get.snackbar("Success", response.message);
      return response.data.attributes.id;
    } catch (e) {
      log(e.toString());
      Get.snackbar("Error", "Failed to create folder: $e");
    } finally {
      isLoading.value = false;
    }
    return "";
  }

  Future<void> addFavourite({
    required String restaurantId,
    required String folderId,
  }) async {
    try {
      isLoading.value = true;
      final response = await _homeRepository.addFavourite(
        restaurantId: restaurantId,
        folderId: folderId,
      );
      Get.snackbar("Success", response.message);
    } catch (e) {
      log(e.toString());
      Get.snackbar("Error", "Failed to add to favourites: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
