import 'package:get/get.dart';
import 'package:palette/models/common_models.dart';
import 'package:palette/models/feed%20models/personal_details_model.dart';
import 'package:palette/repositories/feed_repository.dart';

class PersonDetailsController extends GetxController {
  final String userId;

  PersonDetailsController({required this.userId});

  final FeedRepository feedRepository = FeedRepository();
  var isLoading = true.obs;
  var userDetails = Rxn<PersonalUserAttributes>();
  var logs = <PrivateLogEntry>[].obs;
  var badge = <Badge>[].obs;
  RxBool isFollow = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPersonDetails();
  }

  void fetchPersonDetails() async {
    try {
      isLoading(true);
      final data = await feedRepository.getPersonalDetails(userId);
      userDetails.value = data.data.attributes.first;
      logs.value = data.data.attributes.first.logs;
      badge.value = data.data.attributes.first.badges;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> followUnfollow({required String id}) async {
    try {
      final result = await feedRepository.followUnfollow(id);
      if (result.statusCode == 200) {
        isFollow.value = !isFollow.value;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
