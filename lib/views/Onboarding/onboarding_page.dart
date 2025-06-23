import 'package:flutter/material.dart';
import 'package:palette/views/Authuntication/select_role.dart';
import 'package:palette/views/res/image_path.dart';
import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonWidgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": AppAssetsPath.onBoarding1, // your uploaded image
      "title": "Track What You Eat",
      "description":
          "Log meals, drinks, and dishes from any restaurant or bar — build your food journal with just a few taps",
      "buttonText": "Get Started",
    },
    {
      "image": AppAssetsPath.onBoarding2,
      "title": "Explore, Rate, and Recommend",
      "description":
          "Find popular dishes, see what's trending nearby, and share your own experiences with friends and food lovers",
      "buttonText": "Next",
    },
    {
      "image": AppAssetsPath.onBoarding3,
      "title": "Connect Over Food",
      "description":
          "Follow your friends, discover their favorite spots, and build a community around what you love to eat.",
      "buttonText": "Next",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                final item = onboardingData[index];
                return Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Stack(
                        children: [
                          ClipRRect(
                            child: Image.asset(
                              item["image"]!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 50,
                            right: 20,
                            child: GestureDetector(
                              onTap: () {
                                navigateToPage(SelectRolePage());
                              },
                              child: commonText(
                                "Skip",
                                color: AppColors.white,
                                size: 16,
                                isBold: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            commonText(
                              item["title"]!,
                              size: 24,
                              color: AppColors.black,
                              isBold: true,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            commonText(
                              item["description"]!,
                              size: 16,
                              color: AppColors.gray,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 30),
                            commonButton(
                              item["buttonText"]!,
                              onTap: () {
                                if (currentIndex < onboardingData.length - 1) {
                                  _controller.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                } else {
                                  navigateToPage(SelectRolePage());
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // Page Indicator
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentIndex == index ? 32 : 8,
                  height: 6,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? AppColors.primary
                        : AppColors.gray.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
