// ignore_for_file: must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette/controller/auth_controller.dart';
import 'package:palette/services/local_storage_service.dart';
import '../res/colors.dart';
import '../res/commonWidgets.dart';
import '../res/image_path.dart';
import 'forget_password_page.dart';
import 'sign_up_page.dart';

class SignInPage extends StatefulWidget {
  bool? isAdmin;
  SignInPage({super.key, this.isAdmin});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final ValueNotifier<bool> isPasswordVisible = ValueNotifier<bool>(false);

  final ValueNotifier<bool> isRememberMeChecked = ValueNotifier<bool>(false);

  late final AuthController authController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showSavedAccountsBottomSheet(context);
    });
  }

  void showSavedAccountsBottomSheet(BuildContext context) async {
    final savedLogins = await LocalStorageService().getSavedLogins();
    if (savedLogins.isEmpty) return;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Container(
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.person, color: AppColors.primary),
                      const SizedBox(width: 8),
                      commonText("Select an account", size: 16, isBold: true),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...savedLogins.entries.map((entry) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: const Icon(Icons.account_circle_rounded,
                            color: AppColors.primary, size: 30),
                        title: commonText(entry.key, size: 14, isBold: true),
                        subtitle: const Text("••••••••"),
                        trailing: IconButton(
                          icon:
                              const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () async {
                            await LocalStorageService().removeLogin(entry.key);
                            Navigator.pop(context);
                            showSavedAccountsBottomSheet(context); // refresh
                          },
                        ),
                        onTap: () {
                          authController.signIn(entry.key, entry.value,
                              isRememberMeChecked: isRememberMeChecked.value);
                        },
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: FittedBox(
                          child:
                              commonText("Sign in Your Account", isBold: true)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              commonTextfieldWithTitle(
                "Email",
                hintText: "Email",
                emailController,
                assetIconPath: AppAssetsPath.email,
              ),
              const SizedBox(height: 16),
              ValueListenableBuilder<bool>(
                valueListenable: isPasswordVisible,
                builder: (context, visible, _) {
                  return commonTextfieldWithTitle(
                    "Password",
                    hintText: "Password",
                    isPasswordVisible: visible,
                    issuffixIconVisible: true,
                    changePasswordVisibility: () {
                      isPasswordVisible.value = !visible;
                    },
                    passwordController,
                    assetIconPath: AppAssetsPath.lock,
                  );
                },
              ),
              Row(
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: isRememberMeChecked,
                    builder: (context, checked, _) {
                      return Checkbox(
                        value: checked,
                        fillColor:
                            MaterialStateProperty.resolveWith<Color>((states) {
                          if (states.contains(MaterialState.selected))
                            return AppColors.primary;
                          return Colors.transparent;
                        }),
                        onChanged: (value) {
                          isRememberMeChecked.value = !checked;
                        },
                      );
                    },
                  ),
                  commonText("Remember me",
                      size: 14, color: AppColors.black, isBold: true),
                ],
              ),
              const SizedBox(height: 20),
              Obx(() {
                if (authController.isLoading.value)
                  return const CircularProgressIndicator();

                return commonButton(
                  onTap: () {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();

                    if (email.isEmpty || password.isEmpty) {
                      commonSnackbar(
                          context, "Please enter email and password");
                      return;
                    }

                    authController.signIn(email, password,
                        isRememberMeChecked: isRememberMeChecked.value);
                  },
                  "Sign In",
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
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  navigateToPage(ForgetPasswordPage());
                },
                child: commonText("Forgot the password?",
                    size: 14, color: AppColors.black, isBold: true),
              ),
              const SizedBox(height: 30),
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
                  text: "Don’t have an account? ",
                  style: GoogleFonts.sora(color: Colors.black, fontSize: 14),
                  children: [
                    TextSpan(
                      text: "Sign up",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          navigateToPage(SignUpPage(
                            isAdmin: widget.isAdmin,
                          ));
                        },
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
