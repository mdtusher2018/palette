// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/controller/auth_controller.dart';
import 'package:palette/views/res/image_path.dart';
import '../res/colors.dart';
import '../res/commonWidgets.dart';

class NewPasswordPage extends StatelessWidget {
  NewPasswordPage({super.key, required this.userEmail});
  final String userEmail;
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  late final AuthController authController;

  @override
  Widget build(BuildContext context) {
    authController = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        leading: commonBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            Image.asset(AppAssetsPath.unlock),
            const SizedBox(height: 30),
            commonText("Create Your New Password", size: 21, isBold: true),
            const SizedBox(height: 24),
            Obx(() => commonTextfieldWithTitle(
                  "New Password",
                  newPasswordController,
                  assetIconPath: AppAssetsPath.lock,
                  hintText: "New Password",
                  isPasswordVisible: authController.isLoading.value
                      ? false
                      : !isNewPasswordVisible,
                  issuffixIconVisible: true,
                  changePasswordVisibility: () {
                    isNewPasswordVisible = !isNewPasswordVisible;
                  },
                )),
            const SizedBox(height: 16),
            Obx(() => commonTextfieldWithTitle(
                  "Confirm Password",
                  confirmPasswordController,
                  assetIconPath: AppAssetsPath.lock,
                  hintText: "Confirm Password",
                  isPasswordVisible: authController.isLoading.value
                      ? false
                      : !isConfirmPasswordVisible,
                  issuffixIconVisible: true,
                  changePasswordVisibility: () {
                    isConfirmPasswordVisible = !isConfirmPasswordVisible;
                  },
                )),
            const Spacer(),
            Obx(() {
              if (authController.isLoading.value) {
                return const CircularProgressIndicator();
              }
              return commonButton(
                "Continue",
                onTap: () {
                  final newPassword = newPasswordController.text.trim();
                  final confirmPassword = confirmPasswordController.text.trim();

                  if (newPassword.isEmpty || confirmPassword.isEmpty) {
                    commonSnackbar(context, "Please fill both password fields");
                    return;
                  }
                   if (newPassword.length<6) {
                    commonSnackbar(context, "Password must be 6 character.");
                    return;
                  }
                  if (newPassword != confirmPassword) {
                    commonSnackbar(context, "Passwords do not match");
                    return;
                  }

                  authController.resetPassword(userEmail, newPassword);
                },
              );
            }),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
