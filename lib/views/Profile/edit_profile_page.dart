// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:palette/controller/profile%20controller/user_controller.dart';

import 'package:palette/utils/helper.dart';
import 'package:palette/views/res/image_path.dart';
import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonWidgets.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController detailsController = TextEditingController();

  UserController controller = Get.find<UserController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (controller.userProfile.value != null) {
      nameController.text = controller.userProfile.value!.fullName;
      phoneController.text = controller.userProfile.value!.phoneNumber;
      detailsController.text = controller.userProfile.value!.aboutMe;
      log(detailsController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary, // Background color
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: commonBackButton(),
        title: commonText(
          "Profile",
          size: 21,
          color: AppColors.white,
          isBold: true,
          textAlign: TextAlign.left,
        ),
        centerTitle: true,
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    Obx(() {
                      return Container(
                        padding: EdgeInsets.all(12),
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                image: controller.coverImageFile.value != null
                                    ? FileImage(
                                        controller.coverImageFile.value!)
                                    : NetworkImage(
                                        getFullImagePath(controller
                                            .userProfile.value!.coverImage),
                                      ) as ImageProvider,
                                fit: BoxFit.cover)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: controller.pickCoverImage,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    child: Image.asset(AppAssetsPath.camera),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Obx(() {
                      return CircleAvatar(
                        radius: 50,
                        backgroundImage: controller.profileImageFile.value !=
                                null
                            ? FileImage(
                                controller.profileImageFile.value!,
                              )
                            : NetworkImage(
                                getFullImagePath(
                                  controller.userProfile.value!.image,
                                ),
                              ) as ImageProvider, // Replace with actual image
                      );
                    }),
                    GestureDetector(
                      onTap: controller.pickProfileImage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: Image.asset(AppAssetsPath.camera),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Name Input Field
            commonTextfieldWithTitle(
              "Name",
              hintText: "Enter your name",
              nameController,
            ),
            SizedBox(
              height: 16,
            ),
            commonTextfieldWithTitle(
              "Phone Number",
              hintText: "Enter your phone number",
              phoneController,
            ),
            SizedBox(
              height: 16,
            ),
            commonTextfieldWithTitle(
              "My Details",
              maxLine: 5,
              hintText: "Write about yourself...",
              detailsController,
            ),

            const SizedBox(height: 10),

            Spacer(),
            commonButton("Update Profile", onTap: () async {
              if (nameController.text.isEmpty) {
                Get.snackbar("Empty Field", "Name can't be empty");
              } else if (phoneController.text.isEmpty) {
                Get.snackbar("Empty Field", "Phone number can't be empty");
              } else if (phoneController.text.length < 8 ||
                  phoneController.text.length > 15) {
                Get.snackbar("Invalid Field", "Invalid Phone number.");
              } else {
                controller.updateUserProfile(
                    fullName: nameController.text,
                    phoneNumber: phoneController.text,
                    profileImage: controller.profileImageFile.value,
                    details: detailsController.text,
                    coverImage: controller.coverImageFile.value);
              }
            }),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
