import 'package:get/get.dart';
import 'package:palette/models/explore/ExploreResponseModel.dart';
import 'package:palette/models/explore/near_by_resturant.dart';
import 'package:palette/repositories/explore_repository.dart';

class ExploreController extends GetxController {
  final ExploreRepository _repository = ExploreRepository();

  var isLoading = false.obs;
  var errorMessage = RxnString();

  RxList<RestaurantAttribute> restaurants = <RestaurantAttribute>[].obs;
  RxList<RestaurantAttribute> mapresturents = <RestaurantAttribute>[].obs;

  var topMenus = <TopMenu>[].obs;
  var topRestaurants = <TopRestaurant>[].obs;

  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchExploreList();
    ever(searchQuery, (_) => fetchExploreList()); // react to search changes
  }

  Future<void> fetchExploreList() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;
      final response =
          await _repository.getExploreData(search: searchQuery.value);
      topMenus.assignAll(response.data.attributes.topMenu);
      topRestaurants.assignAll(response.data.attributes.topRestaurent);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }

  Future<void> fetchNearbyRestaurants({
    required double lat,
    required double lng,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _repository.getNearbyRestaurants(lat: lat, lng: lng);
      mapresturents.assignAll(result);
    } catch (e) {
      errorMessage.value = 'Failed to fetch restaurants 😢';
      restaurants.clear();
      print("🔥 Error in controller: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
