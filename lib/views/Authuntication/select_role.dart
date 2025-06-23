import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/views/Authuntication/select_establishment_type.dart';
import 'package:palette/views/Authuntication/sign_in_page.dart';
import '../res/commonWidgets.dart';
import '../res/image_path.dart';

class SelectRolePage extends StatelessWidget {
  const SelectRolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset(AppAssetsPath.logo, height: 150),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: FittedBox(
                        child: commonText(
                          "Welcome to Palette",
                          isBold: true,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: commonText("Please select your role to\ncontinue",
                    textAlign: TextAlign.center, size: 18, isBold: true),
              ),
              const SizedBox(height: 40),
              commonButton(
                "Regular User",
                onTap: () {
                  Get.to(SignInPage());
                },
              ),
              SizedBox(height: 20),
              commonButton("Establishment Owner", onTap: () {
                Get.to(SelectEstablishmentType());
              }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
