import 'package:get/get.dart';
import 'package:palette/models/user%20models/_folder_wise_favorite_menu.dart';
import 'package:palette/repositories/profile_repository.dart';
import 'package:palette/services/api_service.dart';
import 'package:palette/services/profile_service.dart';

class MenuByFolderIdController extends GetxController {
  final ProfileRepository profileRepository =
      ProfileRepository(ProfileService(ApiService()));
  final String folderId;

  MenuByFolderIdController(this.folderId);

  Rxn<FavouriteAttribute> favouriteAttribute = Rxn<FavouriteAttribute>();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavouriteMenus();
  }

  Future<void> fetchFavouriteMenus() async {
    try {
      isLoading.value = true;

      final response = await profileRepository.menuByFolderId(id: folderId);

      if (response.data.attributes.isNotEmpty) {
        favouriteAttribute.value = response.data.attributes.first;
      } else {
        Get.snackbar('Oops!', 'No favourites found for this folder.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch favourites');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> unFavourite({String? menuId}) async {
    isLoading.value = true;

    try {
      final success = await profileRepository.unFavourite(
        menuId: menuId,
      );

      if (success.statusCode == 200) {
        fetchFavouriteMenus();
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
