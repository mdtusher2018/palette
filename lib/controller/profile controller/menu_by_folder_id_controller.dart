import 'package:get/get.dart';
import 'package:palette/models/user%20models/_folder_wise_favorite_menu.dart';
import 'package:palette/repositories/profile_repository.dart';

class MenuByFolderId extends GetxController {
  final ProfileRepository profileRepository;
  final String id;

  MenuByFolderId(this.profileRepository, this.id);

  // Rxn allows null value initially
  Rxn<FolderWiseFavouriteAttribute> folderWiseFavouriteAttribute =
      Rxn<FolderWiseFavouriteAttribute>();

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavoriteByFolderId();
  }

  Future<void> fetchFavoriteByFolderId() async {
    try {
      isLoading.value = true;

      final response = await profileRepository.menuByFolderId(id: id);

      if (response.data.attributes.isNotEmpty) {
        folderWiseFavouriteAttribute.value = response.data.attributes.first;
      } else {
        Get.snackbar('Oops!', 'No favourites found for this folder.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch logs');
    } finally {
      isLoading.value = false;
    }
  }
}
