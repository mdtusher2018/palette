import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/controller/home%20page%20controller/notification_controller.dart';
import 'package:palette/utils/helper.dart';
import 'package:palette/views/res/image_path.dart';
import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonWidgets.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({super.key});
  final NotificationController controller = Get.put(NotificationController());
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
      bottomSheet: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (controller.notifications.isEmpty) {
              Center(
                child: commonText("No notification"),
              );
            }

            return ListView.builder(
              itemCount: controller.notifications.length,
              itemBuilder: (context, index) {
                return ListTile(
                  minVerticalPadding: 0,
                  contentPadding: EdgeInsets.all(0),
                  leading: Image.asset(AppAssetsPath.notifications),
                  title: commonText(controller.notifications[index].message,
                      size: 16, isBold: true, color: AppColors.primary),
                  subtitle: commonText(
                      getTimeDifference(
                          controller.notifications[index].createdAt.toString()),
                      isBold: true,
                      size: 14),
                );
              },
            );
          })),
    );
  }
}
