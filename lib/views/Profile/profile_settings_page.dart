// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/controller/profile%20controller/user_controller.dart';
import 'package:palette/services/local_storage_service.dart';
import 'package:palette/utils/helper.dart';
import 'package:palette/views/Authuntication/sign_in_page.dart';
import 'package:palette/views/Profile/terms_and_condition_page.dart';
import '../res/colors.dart';
import '../res/commonWidgets.dart';
import '../res/image_path.dart';
import 'edit_profile_page.dart';
import 'change_password_page.dart';
import 'help_center_page.dart';
import 'privacy_policy_page.dart';

class ProfileSettingsPage extends StatelessWidget {
  ProfileSettingsPage({super.key});

  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    userController.fetchUserProfile();

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: commonBackButton(),
        title: commonText(
          "Profile Settings",
          size: 21,
          isBold: true,
          textAlign: TextAlign.center,
          color: AppColors.white,
        ),
        centerTitle: true,
      ),
      bottomSheet: Obx(() {
        if (userController.isLoading.value) {
          return const SizedBox(
            height: 300,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (userController.errorMessage.isNotEmpty) {
          return SizedBox(
            height: 100,
            child: Center(
              child: commonText(
                "Error: ${userController.errorMessage.value}",
                size: 16,
                color: Colors.red,
              ),
            ),
          );
        }

        if (userController.userProfile.value == null) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              // Profile Image, Name, Email
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        userController.userProfile.value!.image.isNotEmpty
                            ? getFullImagePath(
                                userController.userProfile.value!.image)
                            : 'https://www.w3schools.com/w3images/avatar2.png',
                      ),
                    );
                  }),
                  const SizedBox(height: 10),
                  commonText(userController.userProfile.value!.fullName,
                      size: 18, color: Colors.black, isBold: true),
                  commonText(userController.userProfile.value!.email,
                      size: 14, color: Colors.black87),
                ],
              ),
              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      profileMenuItem(
                          AppAssetsPath.edit_profile, "Edit Profile",
                          onTap: () {
                        navigateToPage(
                          EditProfilePage(),
                          onPop: (value) {
                            userController.fetchUserProfile();
                          },
                        );
                      }),
                      const Divider(),
                      profileMenuItem(
                          AppAssetsPath.change_password, "Change Password",
                          onTap: () {
                        navigateToPage(ChangePasswordScreen());
                      }),
                      const Divider(),
                      profileMenuItem(AppAssetsPath.help_center, "Help Center",
                          onTap: () {
                        navigateToPage(HelpCenterScreen());
                      }),
                      const Divider(),
                      profileMenuItem(
                          AppAssetsPath.terms_and_condition, "Terms of Service",
                          onTap: () {
                        navigateToPage(TermsAndServicesScreen());
                      }),
                      const Divider(),
                      profileMenuItem(
                          AppAssetsPath.privacy_policy, "Privacy Policy",
                          onTap: () {
                        navigateToPage(PrivacyPolicyScreen());
                      }),
                      const Divider(),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () async {
                          // Clear all local storage data
                          await LocalStorageService().removeToken();

                          // Navigate to SignInPage and remove all previous routes
                          Get.offAll(() => SignInPage());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Image.asset(AppAssetsPath.logout, width: 24),
                              const SizedBox(width: 10),
                              commonText("Logout",
                                  size: 16, color: Colors.red, isBold: true),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget profileMenuItem(String iconPath, String text,
      {String? value, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Image.asset(iconPath, width: 24),
            const SizedBox(width: 10),
            Expanded(child: commonText(text, size: 14, isBold: true)),
            if (value != null) ...[
              commonText(value, size: 14, isBold: true),
              const SizedBox(width: 10),
            ],
            const Icon(Icons.chevron_right, size: 20),
          ],
        ),
      ),
    );
  }
}
