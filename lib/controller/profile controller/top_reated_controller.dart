import 'package:get/get.dart';

import 'package:palette/models/user%20models/top_reated_iteams_model.dart';
import 'package:palette/repositories/profile_repository.dart';
import 'package:palette/services/api_service.dart';
import 'package:palette/services/profile_service.dart';

class TopRatedItemsController extends GetxController {
  final ProfileRepository _repository =
      ProfileRepository(ProfileService(ApiService()));

  RxList<TopRatedItem> items = <TopRatedItem>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTopRatedItems();
  }

  void fetchTopRatedItems() async {
    try {
      isLoading.value = true;
      final response = await _repository.fetchTopRatedItems();
      items.assignAll(response.data.attributes);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load top-rated items');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> togglePinUnpin(String feedbackId) async {
    try {
      final response = await _repository.togglePinUnpin(feedbackId);
      if (response.statusCode == 200) {
        Get.snackbar('Success', response.message);
        fetchTopRatedItems();
      } else {
        Get.snackbar('Error', response.message);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to toggle pin status');
    } finally {
      isLoading.value = false;
    }
  }
}
