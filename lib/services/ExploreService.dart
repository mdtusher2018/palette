import 'package:palette/models/explore/ExploreResponseModel.dart';
import 'package:palette/models/explore/near_by_resturant.dart';
import 'package:palette/services/api_service.dart';
import 'package:palette/utils/api_endpoints.dart';

class ExploreService {
  final ApiService apiService = ApiService();

  Future<ExploreResponseModel> fetchExploreList({String? search}) async {
    String url = ApiEndpoints.exploreList;

    if (search != null && search.isNotEmpty) {
      url += '?search=$search';
    }

    final jsonResponse = await apiService.get(url);
    return ExploreResponseModel.fromJson(jsonResponse);
  }

  Future<List<RestaurantAttribute>> fetchNearbyRestaurants({
    required double lat,
    required double lng,
  }) async {
    final url = '${ApiEndpoints.nearbyRestaurant}?lng=$lng&lat=$lat';

    final jsonResponse = await apiService.get(url);
    final response = NearbyRestaurantsResponse.fromJson(jsonResponse);
    return response.data.attributes;
  }
}
