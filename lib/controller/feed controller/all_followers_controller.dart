import 'package:get/get.dart';
import 'package:palette/models/feed%20models/all_followers_model.dart';
import 'package:palette/repositories/feed_repository.dart';

class AllFollowersController extends GetxController {
  final FeedRepository _feedRepository = FeedRepository();
  String id;
  bool myinfo;
  AllFollowersController(this.id, this.myinfo);
  RxList<FollowerUser> followers = <FollowerUser>[].obs;
  RxBool isLoading = false.obs;

  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllFollowers();

    // Reactively call fetchAllFollowers when searchQuery changes
    ever(searchQuery, (_) => fetchAllFollowers());
  }

  Future<void> fetchAllFollowers() async {
    try {
      isLoading.value = true;

      final result = await _feedRepository.getFollowers(id, myinfo,
          search: searchQuery.value);

      // Flatten the followers lists from attributes into a single list
      final allFollowers = result.attributes;

      followers.assignAll(allFollowers);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch followers');
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearch(String query) {
    searchQuery.value = query.trim();
  }

  Future<void> followUnfollow({required int index}) async {
    try {
      final result = await _feedRepository.followUnfollow(followers[index].id);
      if (result.statusCode == 200) {
        followers[index].isFollower = !followers[index].isFollower;
        followers.refresh();
      }
    } catch (e) {
      Get.snackbar('Error',
          'Failed to ${followers[index].isFollower ? "unfollow" : "follow"}');
    }
  }
}
