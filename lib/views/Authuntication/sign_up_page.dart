// ignore_for_file: must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette/controller/auth_controller.dart';
import '../res/colors.dart';
import '../res/commonWidgets.dart';
import '../res/image_path.dart';
import 'sign_in_page.dart';

class SignUpPage extends StatelessWidget {
  bool? isAdmin;
  SignUpPage({super.key, this.isAdmin});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final ValueNotifier<bool> isPasswordVisible = ValueNotifier<bool>(true);
  final ValueNotifier<bool> isConfirmPasswordVisible =
      ValueNotifier<bool>(true);

  late final AuthController authController;

  @override
  Widget build(BuildContext context) {
    authController = Get.put(AuthController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(AppAssetsPath.logo, height: 150),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: FittedBox(
                        child: commonText(
                          "Create your Account",
                          isBold: true,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              commonTextfieldWithTitle(
                "Email",
                emailController,
                hintText: "Email",
                assetIconPath: AppAssetsPath.email,
              ),
              const SizedBox(height: 16),
              commonTextfieldWithTitle(
                (isAdmin != null && isAdmin == true)
                    ? "Establishment Name"
                    : "User Name",
                userIdController,
                hintText: (isAdmin != null && isAdmin == true)
                    ? "Establishment Name"
                    : "User Name",
                assetIconPath: AppAssetsPath.person,
              ),
              const SizedBox(height: 16),
              ValueListenableBuilder<bool>(
                valueListenable: isPasswordVisible,
                builder: (context, visible, _) {
                  return commonTextfieldWithTitle(
                    "Password",
                    passwordController,
                    hintText: "Password",
                    assetIconPath: AppAssetsPath.lock,
                    isPasswordVisible: visible,
                    issuffixIconVisible: true,
                    changePasswordVisibility: () {
                      isPasswordVisible.value = !visible;
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              ValueListenableBuilder<bool>(
                valueListenable: isConfirmPasswordVisible,
                builder: (context, visible, _) {
                  return commonTextfieldWithTitle(
                    "Confirm Password",
                    confirmPasswordController,
                    hintText: "Confirm password",
                    assetIconPath: AppAssetsPath.lock,
                    isPasswordVisible: visible,
                    issuffixIconVisible: true,
                    changePasswordVisibility: () {
                      isConfirmPasswordVisible.value = !visible;
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 20),
              Obx(() {
                if (authController.isLoading.value) {
                  return const CircularProgressIndicator();
                }
                return commonButton(
                  "Sign Up",
                  onTap: () {
                    final fullName = userIdController.text.trim();
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    final confirmPassword =
                        confirmPasswordController.text.trim();

                    if (password != confirmPassword) {
                      commonSnackbar(context, "Passwords do not match");
                      return;
                    }
                    if (email.isEmpty || fullName.isEmpty || password.isEmpty) {
                      commonSnackbar(context, "Please fill all fields");
                      return;
                    }

                    authController.signUp(fullName, email, password,
                        isAdmin: isAdmin ?? false);
                  },
                );
              }),
              Obx(() {
                if (authController.errorMessage.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    commonSnackbar(context, authController.errorMessage.value,
                        backgroundColor: Colors.red);
                    authController.errorMessage.value = '';
                  });
                }
                return const SizedBox.shrink();
              }),
              const SizedBox(height: 20),
              commonText("or continue with",
                  size: 14, color: AppColors.black, isBold: true),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  await authController.signInAndGetEmail();
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: Colors.black38, width: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    AppAssetsPath.googleIcon,
                    height: 30,
                    width: 30,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: GoogleFonts.sora(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          navigateToPage(SignInPage(isAdmin: isAdmin));
                        },
                      text: "Sign In",
                      style: GoogleFonts.sora(
                        color: AppColors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
