import 'package:get/get.dart';
import 'package:palette/models/feed%20models/all_following_model.dart';
import 'package:palette/repositories/feed_repository.dart';

class AllFollowingController extends GetxController {
  final FeedRepository _feedRepository = FeedRepository();
  String id;
  bool myinfo;
  AllFollowingController(this.id, this.myinfo);
  RxList<FollowingUser> following = <FollowingUser>[].obs;
  RxBool isLoading = false.obs;

  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllFollowing();

    // Reactively fetch following users on search query change
    ever(searchQuery, (_) => fetchAllFollowing());
  }

  Future<void> fetchAllFollowing() async {
    try {
      isLoading.value = true;

      final result = await _feedRepository.getFollowing(id, myinfo,
          search: searchQuery.value);

      final allFollowing = result.attributes;

      following.assignAll(allFollowing);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch following');
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearch(String query) {
    searchQuery.value = query.trim();
  }

  Future<void> followUnfollow({required int index}) async {
    try {
      final result = await _feedRepository.followUnfollow(following[index].id);
      if (result.statusCode == 200) {
        following[index].isFollowing = !following[index].isFollowing;
        following.refresh();
      }
    } catch (e) {
      Get.snackbar('Error',
          'Failed to ${following[index].isFollowing ? "unfollow" : "follow"}');
    }
  }
}
