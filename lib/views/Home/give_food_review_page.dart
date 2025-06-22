import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/controller/home%20page%20controller/submit_feedback_controller.dart';
import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonWidgets.dart';
import 'package:palette/views/res/video_screen.dart';

class GiveReviewPage extends StatelessWidget {
  final String id;
  final bool isMenu;
  const GiveReviewPage({super.key, required this.id, required this.isMenu});

  @override
  Widget build(BuildContext context) {
    final SubmitFeedbackController controller =
        Get.put(SubmitFeedbackController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: commonText("Give Review", size: 20, isBold: true),
        leading: commonBackButton(),
      ),
      bottomSheet: SizedBox(
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Obx(() => SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Star Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (i) {
                        final index = i + 1;
                        return InkWell(
                          onTap: () =>
                              controller.rating.value = index.toDouble(),
                          child: Icon(
                            controller.rating.value >= index
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.orange,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 16),

                    // Review Text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        maxLines: 5,
                        controller: controller.reviewController,
                        decoration: InputDecoration(
                          hintText: 'Write a review....',
                          filled: true,
                          fillColor: const Color(0xFFFBDCDC),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: AppColors.primary, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: AppColors.primary, width: 2),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Add Photo Button
                    SizedBox(
                      height: 30,
                      child: ElevatedButton.icon(
                        onPressed: controller.pickImage,
                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                        label: commonText(
                          controller.mediaType.value == 'image'
                              ? 'Change Photo'
                              : 'Add Photo',
                          color: Colors.white,
                          isBold: true,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Only show "or" if nothing is picked

                    commonText("or", size: 14, isBold: true),
                    const SizedBox(height: 8),

                    // Add Video Button
                    SizedBox(
                      height: 30,
                      child: ElevatedButton.icon(
                        onPressed: controller.pickVideo,
                        icon: const Icon(Icons.play_circle_fill,
                            color: Colors.white),
                        label: commonText(
                          controller.mediaType.value == 'video'
                              ? 'Change Video'
                              : 'Add Video',
                          color: Colors.white,
                          isBold: true,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Media Preview (always comes after the buttons)
                    if (controller.selectedMedia.value != null)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: controller.mediaType.value == 'image'
                                ? Image.file(
                                    controller.selectedMedia.value!,
                                    fit: BoxFit.cover,
                                    height: 200,
                                  )
                                : VideoApp(
                                    videoUrl:
                                        controller.selectedMedia.value!.path),
                          ),
                        ),
                      ),

                    const SizedBox(height: 16),

                    // Submit Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : commonButton("Submit Review",
                              height: 40,
                              onTap: () => controller.submitReview(
                                  menuId: (isMenu) ? id : "",
                                  restaurantId: (isMenu) ? "" : id)),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
