import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/controller/feed%20controller/feeds_by_user_id_controller.dart';
import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonDesigns.dart';
import 'package:palette/views/Feed/post_details_page.dart';

import '../res/commonWidgets.dart';

class LogsPage extends StatelessWidget {
  final String id;
  LogsPage({required this.id});
  @override
  Widget build(BuildContext context) {
    FeedsByUserIdController controller =
        Get.put(FeedsByUserIdController(id: id));
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: AppColors.primary,
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            elevation: 0,
            leading: commonBackButton(),
            title: commonText("Logs",
                size: 20, color: AppColors.white, isBold: true),
            centerTitle: true,
          ),
          bottomSheet: Container(
            padding: EdgeInsets.all(16),
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (controller.logs.isEmpty) {
                return Center(
                  child: commonText("No logs found", size: 18, isBold: true),
                );
              }
              return ListView.builder(
                itemCount: controller.logs.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        navigateToPage(PostDetailsPage(
                          id: controller.logs[index].id,
                        ));
                      },
                      child: buildLogsCardDesign(
                          image: controller.logs[index].image ??
                              "https://th.bing.com/th/id/OIP.jUfCu2A6ilKJAdybISEMgwHaHa?rs=1&pid=ImgDetMain&cb=idpwebpc2",
                          iteamName: controller.logs[index].itemName ?? "",
                          ratting: controller.logs[index].rating.toString(),
                          restaurent: controller.logs[index].restaurent));
                },
              );
            }),
          )),
    );
  }
}
