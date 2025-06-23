// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/controller/profile%20controller/AddNewLogController.dart';
import 'package:palette/controller/profile%20controller/my_logs_and_feedback_controller.dart';
import 'package:palette/repositories/profile_repository.dart';
import 'package:palette/services/api_service.dart';
import 'package:palette/services/profile_service.dart';
import 'package:palette/utils/helper.dart';
import 'package:palette/views/Feed/post_details_page.dart';
import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonDesigns.dart';
import 'package:palette/views/Profile/add_new_log_page.dart';

import '../res/commonWidgets.dart';

class MyPalettePage extends StatelessWidget {
  MyLogsAndFeedbackController controller = Get.put(MyLogsAndFeedbackController(
      ProfileRepository(ProfileService(ApiService()))));

  MyPalettePage({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          leading: commonBackButton(),
          title: commonText("My Palette",
              size: 20, color: AppColors.white, isBold: true),
          centerTitle: true,
        ),
        bottomSheet: Obx(() {
          return Column(
            children: [
              SizedBox(height: 16),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildLogsTab(context, controller),
                    if (controller.feedback.isEmpty)
                      Center(
                          child: commonText("No Feedback Found",
                              isBold: true, size: 18)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: buildReviews(
                        reviews: controller.feedback.isNotEmpty
                            ? List.generate(controller.feedback.length,
                                (index) {
                                return {
                                  "text": controller.feedback[index].comment,
                                  "rating": controller.feedback[index].rating,
                                  "time": controller.feedback[index].createdAt,
                                  'profileImage': getFullImagePath(
                                      controller.feedback[index].reviewerImage),
                                  'name':
                                      controller.feedback[index].reviewerName,
                                  'commentImage':
                                      (controller.feedback[index].image !=
                                                  null &&
                                              controller.feedback[index].image!
                                                  .isNotEmpty)
                                          ? getFullImagePath(controller
                                              .feedback[index].image
                                              .toString())
                                          : "",
                                  'video': (controller.feedback[index].video !=
                                              null &&
                                          controller.feedback[index].video!
                                              .isNotEmpty)
                                      ? controller.feedback[index].video!
                                          .toString()
                                      : ""
                                };
                              })
                            : [],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 16),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 1,
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TabBar(
            indicator: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            labelColor: AppColors.white,
            unselectedLabelColor: AppColors.black,
            dividerColor: Colors.transparent,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            unselectedLabelStyle: TextStyle(fontSize: 16),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: "Logs"),
              Tab(text: "Reviews"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogsTab(
      BuildContext context, MyLogsAndFeedbackController controller) {
    if (controller.isLoading.value) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: [
        (controller.logs.isNotEmpty)
            ? Expanded(child: buildLogs(controller))
            : Expanded(
                child: Center(
                    child: commonText("No Logs Found", isBold: true, size: 18)),
              ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 40,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                // Navigate to Add New Log Page
                Get.to(() => AddNewLogPage(), binding: BindingsBuilder(() {
                  Get.put(AddNewLogController());
                }));
              },
              icon: Icon(
                Icons.add,
                color: AppColors.white,
                size: 24,
              ),
              label: commonText("Add New Log",
                  color: AppColors.white, size: 14, isBold: true),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        )
      ],
    );
  }

  Widget buildLogs(MyLogsAndFeedbackController controller) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(16),
      itemCount: controller.logs.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              // Navigate to Log Details Page
              navigateToPage(PostDetailsPage(
                id: controller.logs[index].id,
              ));
            },
            child: buildLogsCardDesign(
                iteamName: controller.logs[index].itemName.toString(),
                image: (controller.logs[index].image != null &&
                        controller.logs[index].image!.isNotEmpty)
                    ? getFullImagePath(controller.logs[index].image!)
                    : "https://th.bing.com/th/id/OIP.jUfCu2A6ilKJAdybISEMgwHaHa?rs=1&pid=ImgDetMain&cb=idpwebpc2",
                restaurent: controller.logs[index].restaurent,
                ratting: controller.logs[index].rating.toString()));
      },
    );
  }
}
