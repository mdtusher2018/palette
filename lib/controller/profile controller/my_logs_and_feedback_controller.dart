import 'package:get/get.dart';
import 'package:palette/models/common_models.dart';
import 'package:palette/models/user%20models/my_feedback_model.dart';
import 'package:palette/repositories/profile_repository.dart';

class MyLogsAndFeedbackController extends GetxController {
  final ProfileRepository profileRepository;

  MyLogsAndFeedbackController(this.profileRepository);

  RxBool isLoading = false.obs;
  RxList<LogEntry> logs = <LogEntry>[].obs;
  RxList<MyFeedback> feedback = <MyFeedback>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyLogs();
    fetchMyFeedBack();
  }

  Future<void> fetchMyLogs() async {
    try {
      isLoading.value = true;
      final response = await profileRepository.fetchMyLogs();
      logs.assignAll(response.data);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch logs');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMyFeedBack() async {
    try {
      isLoading.value = true;
      final response = await profileRepository.fetchMyFeedBack();
      feedback.assignAll(response.data.attributes);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch logs');
    } finally {
      isLoading.value = false;
    }
  }
}
