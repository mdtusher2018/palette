import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/controller/home%20page%20controller/restaurant_details_controller.dart';
import 'package:palette/utils/helper.dart';
import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonDesigns.dart';
import 'package:palette/views/res/commonWidgets.dart';

class RestautentReviewsPage extends StatelessWidget {
  final String restaurantId;
  const RestautentReviewsPage({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    final RestaurantDetailsController controller =
        Get.put(RestaurantDetailsController(restaurantId));
    controller.fetchFeedback(restaurantId);
    return Scaffold(
      appBar: AppBar(
        title: commonText("Reviews",
            size: 21, isBold: true, color: AppColors.white),
        leading: commonBackButton(),
      ),
      backgroundColor: AppColors.primary,
      bottomSheet: Padding(
        padding: EdgeInsets.all(16),
        child: Obx(() {
          return buildReviews(
            maxline: 100000,
            reviews: controller.feedbackList.isNotEmpty
                ? List.generate(controller.feedbackList.length, (index) {
                    return {
                      "text": controller.feedbackList[index].comment,
                      "rating": controller.feedbackList[index].rating,
                      "time": controller.feedbackList[index].createdAt,
                      'profileImage': controller
                                      .feedbackList[index].reviewerImage !=
                                  null &&
                              controller
                                  .feedbackList[index].reviewerImage!.isNotEmpty
                          ? getFullImagePath(
                              controller.feedbackList[index].reviewerImage!)
                          : "https://www.w3schools.com/w3images/avatar2.png",
                      'name': controller.feedbackList[index].reviewerName,
                      'commentImage': (controller.feedbackList[index].image !=
                                  null &&
                              controller.feedbackList[index].image!.isNotEmpty)
                          ? getFullImagePath(
                              controller.feedbackList[index].image.toString())
                          : "",
                      'video': (controller.feedbackList[index].video != null &&
                              controller.feedbackList[index].video!.isNotEmpty)
                          ? controller.feedbackList[index].video!.toString()
                          : ""
                    };
                  })
                : [],
          );
        }),
      ),
    );
  }
}
