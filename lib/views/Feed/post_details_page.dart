import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/controller/feed%20controller/SingleLogController.dart';
import 'package:palette/utils/helper.dart';
import 'package:palette/views/res/image_path.dart';
import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonWidgets.dart';
import 'package:palette/views/res/video_screen.dart';

class PostDetailsPage extends StatelessWidget {
  final String id;
  const PostDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final SingleLogController controller =
        Get.put(SingleLogController(id), tag: id);
    return Scaffold(
      appBar: AppBar(
        leading: commonBackButton(),
      ),
      backgroundColor: AppColors.primary,
      bottomSheet: Container(
        padding: EdgeInsets.all(16),
        height: double.infinity,
        width: double.infinity,
        child: Obx(() {
          if (controller.logEntry.value == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.logEntry.value!.image != null &&
                  controller.logEntry.value!.image!.isNotEmpty)
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: NetworkImage(getFullImagePath(
                            controller.logEntry.value!.image!)),
                        fit: BoxFit.cover),
                  ),
                ),
              if (controller.logEntry.value!.video != null &&
                  controller.logEntry.value!.video!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    child: VideoApp(
                      videoUrl: controller.logEntry.value!.video!,
                    ),
                  ),
                ),
              SizedBox(
                height: 16,
              ),
              commonText(controller.logEntry.value!.itemName ?? "N/A",
                  size: 18, isBold: true),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Image.asset(AppAssetsPath.locationIcon),
                  Flexible(
                      child: commonText(controller.logEntry.value!.restaurent,
                          size: 14, isBold: true))
                ],
              ),
              SizedBox(
                height: 4,
              ),
              commonText(controller.logEntry.value!.notes, size: 16)
            ],
          ));
        }),
      ),
    );
  }
}
