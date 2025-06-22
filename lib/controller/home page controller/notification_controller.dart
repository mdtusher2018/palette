import 'package:get/get.dart';
import 'package:palette/models/home%20models/notification_model.dart';
import 'package:palette/repositories/home%20repository/home_repository.dart';

class NotificationController extends GetxController {
  final RxList<NotificationItem> notifications = <NotificationItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final HomeRepository _homeRepository = HomeRepository();

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      final data = await _homeRepository.getNotifications();
      notifications.assignAll(data.data.attributes);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
