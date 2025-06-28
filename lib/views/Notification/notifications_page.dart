import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/controller/home page controller/notification_controller.dart';
import 'package:palette/utils/helper.dart';
import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonWidgets.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final NotificationController controller = Get.put(NotificationController());
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Add scroll listener
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          !controller.isLoadingMore.value &&
          controller.currentPage <= controller.totalPages) {
        controller.fetchNotifications(initial: false);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: commonText("Notification",
            size: 21, isBold: true, color: AppColors.white),
        leading: commonBackButton(),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      bottomSheet: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.notifications.isEmpty) {
          log(controller.notifications.length.toString());
          return Center(
              child: commonText("No notification", size: 16, isBold: true));
        }

        return ListView.separated(
          separatorBuilder: (context, index) {
            return Divider();
          },
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          itemCount: controller.notifications.length + 1,
          itemBuilder: (context, index) {
            if (index == controller.notifications.length) {
              return controller.isLoadingMore.value
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : const SizedBox();
            }

            final notification = controller.notifications[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                minVerticalPadding: 0,
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.notifications,
                  size: 32,
                  color: AppColors.primary,
                ),
                title: commonText(
                  notification.message,
                  size: 16,
                  isBold: true,
                  color: AppColors.primary,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // commonText(
                    //   getTimeDifference(notification.createdAt.toString()),
                    //   size: 14,
                    //   color: AppColors.primary,
                    // ),
                    const SizedBox(height: 4),
                    commonText(
                      getTimeDifference(notification.createdAt.toString()),
                      isBold: true,
                      size: 12,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
