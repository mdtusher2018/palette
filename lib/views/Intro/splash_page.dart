import 'dart:async';
import 'package:flutter/material.dart';
import 'package:palette/services/local_storage_service.dart';
import 'package:palette/views/Onboarding/onboarding_page.dart';
import 'package:palette/views/res/image_path.dart';

import 'package:palette/views/res/commonWidgets.dart';
import 'package:palette/views/root_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  void _checkAuthAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = await LocalStorageService().getToken();
    if (token != null && token.isNotEmpty) {
      final user = await LocalStorageService().loadUserAttributes();
      if (user != null) {
        navigateToPage(RootPage(userInfo: user));
        return; // ✅ Stop here if navigating to RootPage
      }
    }

    // Fallback to onboarding
    navigateToPage(OnboardingScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Image.asset(
            AppAssetsPath.logo,
          ),
        ),
      ),
    );
  }
}
