import 'package:palette/models/explore/ExploreResponseModel.dart';
import 'package:palette/models/explore/near_by_resturant.dart';
import 'package:palette/services/ExploreService.dart';

class ExploreRepository {
  final ExploreService _exploreService = ExploreService();

  Future<ExploreResponseModel> getExploreData({String? search}) {
    return _exploreService.fetchExploreList(search: search);
  }

  Future<List<RestaurantAttribute>> getNearbyRestaurants({
    required double lat,
    required double lng,
  }) {
    return _exploreService.fetchNearbyRestaurants(lat: lat, lng: lng);
  }
}
