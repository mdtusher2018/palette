import 'package:get/get.dart';
import 'package:palette/models/user%20models/favorite_menu_folder_model.dart';
import 'package:palette/models/user%20models/resturent_favorite_model.dart';
import 'package:palette/repositories/profile_repository.dart';
import 'package:palette/services/api_service.dart';
import 'package:palette/services/profile_service.dart';

class FavouriteController extends GetxController {
  final ProfileRepository userRepository =
      ProfileRepository(ProfileService(ApiService()));

  FavouriteController();

  @override
  void onInit() {
    super.onInit();
    fetchFavouriteRestaurants();
    fetchFolders();
  }

  RxBool isLoading = false.obs;
  var errorMessage = RxnString();
  RxList<FavouriteRestaurantItem> favouriteRestaurants =
      <FavouriteRestaurantItem>[].obs;
  var folders = <MenuFolderAttributes>[].obs;

  Future<void> fetchFavouriteRestaurants() async {
    try {
      isLoading.value = true;
      final response = await userRepository.getMyfavoriteResturent();
      favouriteRestaurants.value = response.data.attributes;
    } catch (e) {
      Get.snackbar("Error", "Failed to load favorite restaurants");
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void fetchFolders() async {
    try {
      isLoading.value = true;
      final response = await userRepository
          .getMyfavoriteMenuFoler(); // You need this in your repo
      folders.assignAll(response.data.attributes);
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to fetch folders');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> unFavourite({String? restaurantId, String? menuId}) async {
    isLoading.value = true;

    try {
      final success = await userRepository.unFavourite(
        restaurantId: restaurantId,
        menuId: menuId,
      );

      if (success.statusCode == 200) {
        fetchFavouriteRestaurants();
        Get.snackbar("Success", "Favourite updated successfully");
      } else {
        Get.snackbar("Failed", "Unable to update favourite");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
