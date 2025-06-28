import 'dart:developer';

import 'package:get/get.dart';
import 'package:palette/models/home models/notification_model.dart';
import 'package:palette/repositories/home%20repository/home_repository.dart';

class NotificationController extends GetxController {
  final RxList<NotificationItem> notifications = <NotificationItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString errorMessage = ''.obs;

  int currentPage = 1;
  int totalPages = 1;
  final int limit = 10;

  final HomeRepository _repository = HomeRepository();

  @override
  void onInit() {
    super.onInit();
    fetchNotifications(initial: true);
  }

  Future<void> fetchNotifications({bool initial = false}) async {
    if (initial) {
      isLoading.value = true;
      currentPage = 1;
      notifications.clear();
    } else {
      if (currentPage > totalPages || isLoadingMore.value) return;
      isLoadingMore.value = true;
    }

    try {
      final response = await _repository.getNotifications(
        page: currentPage,
        limit: limit,
      );

      final data = response.data.attributes;
      log(response.message + "..................");
      notifications.addAll(data.notification);
      totalPages = data.pagination.totalPages;
      currentPage++;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }
}
