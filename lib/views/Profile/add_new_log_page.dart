import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/controller/profile%20controller/AddNewLogController.dart';
import 'package:palette/models/user%20models/catagory_model.dart';
import 'package:palette/views/res/image_path.dart';
import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonWidgets.dart';
import 'package:palette/views/res/video_screen.dart';

class AddNewLogPage extends GetView<AddNewLogController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: commonText("Add New Log",
            size: 20, isBold: true, color: AppColors.white),
        leading: commonBackButton(),
        centerTitle: true,
      ),
      bottomSheet: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonText("Restaurant", size: 14, isBold: true),
                const SizedBox(height: 8),
                commonSearchBar(
                  noshadow: true,
                  controller: controller.restaurantController,
                  hintText: "Search Restaurant",
                ),
                const SizedBox(height: 16),
                commonText("Item", size: 14, isBold: true),
                const SizedBox(height: 8),
                commonSearchBar(
                  noshadow: true,
                  controller: controller.itemController,
                  hintText: "Search Item",
                ),
                const SizedBox(height: 16),
                commonText("Category", size: 14, isBold: true),
                const SizedBox(height: 8),
                Obx(() {
                  return DropdownButtonFormField<FoodCategory>(
                    value: controller.selectedCategory.value,
                    hint: commonText("Select Food Category"),
                    isExpanded: true,
                    items: controller.categories.map((category) {
                      return DropdownMenuItem<FoodCategory>(
                        value: category,
                        child: commonText(category.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedCategory.value = value;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.primary, width: 2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.primary, width: 2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.primary, width: 2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 16),
                commonText("Upload Media", isBold: true, size: 14),
                const SizedBox(height: 8),
                Obx(() {
                  File? image = controller.selectedImage.value;
                  File? video = controller.selectedVideo.value;

                  if (image != null) {
                    return Column(
                      children: [
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                                image: FileImage(image), fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 30,
                          child: ElevatedButton.icon(
                            onPressed: controller.pickImage,
                            icon: const Icon(Icons.camera_alt,
                                color: Colors.white),
                            label: commonText('Change Photos',
                                color: Colors.white, isBold: true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        commonText("or", size: 14, isBold: true),
                        const SizedBox(height: 4),
                        SizedBox(
                          height: 30,
                          child: ElevatedButton.icon(
                            onPressed: controller.pickVideo,
                            icon: const Icon(Icons.play_circle_fill,
                                color: Colors.white),
                            label: commonText('Add Videos',
                                color: Colors.white, isBold: true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (video != null) {
                    return Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: VideoApp(
                            videoUrl: video.path,
                            isLocal: true,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 30,
                          child: ElevatedButton.icon(
                            onPressed: controller.pickVideo,
                            icon: const Icon(Icons.camera_alt,
                                color: Colors.white),
                            label: commonText('Change Video',
                                color: Colors.white, isBold: true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        commonText("or", size: 14, isBold: true),
                        const SizedBox(height: 4),
                        SizedBox(
                          height: 30,
                          child: ElevatedButton.icon(
                            onPressed: controller.pickImage,
                            icon: const Icon(Icons.play_circle_fill,
                                color: Colors.white),
                            label: commonText('Add Image',
                                color: Colors.white, isBold: true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        uploadButton("Upload Image", controller.pickImage),
                        const SizedBox(height: 8),
                        commonText("Or", isBold: true),
                        const SizedBox(height: 8),
                        uploadButton("Upload Video", controller.pickVideo),
                      ],
                    );
                  }
                }),
                const SizedBox(height: 16),
                commonText("Rating", isBold: true, size: 14),
                const SizedBox(height: 8),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < controller.rating.value
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          color: Colors.orange,
                          size: 40,
                        ),
                        onPressed: () {
                          controller.updateRating(index + 1.0);
                        },
                      );
                    }),
                  );
                }),
                const SizedBox(height: 16),
                commonTextfieldWithTitle("Notes", controller.notesController,
                    hintText: "Add Notes about this dish",
                    maxLine: 4,
                    color: Colors.white,
                    borderWidth: 2.0,
                    borderColor: AppColors.primary),
                const SizedBox(height: 24),
                commonButton(
                  "Post",
                  onTap: () {
                    if (controller.isValidToSubmit()) {
                      controller.submitLog();
                    } else {
                      commonSnackbar(
                        context,
                        "Fill in all required fields and pick either image or video",
                        backgroundColor: Colors.red,
                      );
                    }
                  },
                  textalign: TextAlign.center,
                ),
              ],
            ),
            Obx(
              () {
                if (controller.isLoading.value) {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  );
                }
                return SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget uploadButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssetsPath.upload, height: 40),
              const SizedBox(height: 4),
              commonText(text, color: AppColors.primary),
            ],
          ),
        ),
      ),
    );
  }
}
