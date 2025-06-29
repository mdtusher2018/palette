// ignore_for_file: must_be_immutable
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/controller/home%20page%20controller/home_controller.dart';
import 'package:palette/models/common_models.dart';
import 'package:palette/utils/helper.dart';
import 'package:palette/views/res/image_path.dart';
import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonDesigns.dart';
import 'package:palette/views/res/commonWidgets.dart';
import 'package:palette/views/Home/food_details_page.dart';
import 'package:palette/views/Notification/notifications_page.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  UserAttributes userInfo;
  HomePage({super.key, required this.userInfo});
  final String dashboardUrl = 'https://www.palatte.com/dashboard';

  void _launchDashboard() async {
    final Uri url = Uri.parse(dashboardUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication, // Triggers system browser chooser
      );
    } else {
      throw 'Could not launch $dashboardUrl';
    }
  }

  void showPendingApprovalDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: commonText(
            'Your account is currently pending approval. You will be notified once it is approved',
            size: 18,
            textAlign: TextAlign.center,
            isBold: true),
      ),
      barrierDismissible: false, // Prevent closing by tapping outside
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userInfo.role == "admin" && !userInfo.verified) {
        showPendingApprovalDialog();
      }
    });
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonText(userInfo.fullName,
                size: 16, isBold: true, color: AppColors.white),
            if (userInfo.role != "restaurant")
              commonText("What tasty food will you try today?",
                  size: 12, color: AppColors.white),
          ],
        ),
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(
                getFullImagePath(userInfo.image)), // Example avatar
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              // Navigate to notifications page
              navigateToPage(NotificationsPage());
            },
            child: CircleAvatar(
              backgroundColor: AppColors.white,
              child: Icon(
                Icons.notifications_active,
                color: AppColors.primary,
              ),
            ),
          ),
          SizedBox(
            width: 16,
          )
        ],
      ),
      bottomSheet: (userInfo.role == "restaurant")
          ? Column(
              children: [
                Spacer(),
                commonText(
                  "Access your dashboard by\nclicking the link below",
                  size: 18,
                  isBold: true,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: commonText(dashboardUrl, size: 14, isBold: true),
                      ),
                      IconButton(
                        icon: const Icon(Icons.open_in_new),
                        onPressed: _launchDashboard,
                      )
                    ],
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
              ],
            )
          : SizedBox(
              height: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Promo Banner
                      Obx(() {
                        if (homeController.isLoading.value) {
                          return SizedBox(
                            height: 150,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        if (homeController.ads.isEmpty) {
                          return SizedBox(); // or show "No Ads"
                        }

                        List<Map<String, String>> items =
                            homeController.ads.map((ad) {
                          return {
                            "image": getFullImagePath(ad.image),
                            "url": ad.link,
                          };
                        }).toList();

                        return AdsCarousel(items: items);
                      }),

                      SizedBox(height: 20),

                      // Highlights of the Week
                      Obx(
                        () {
                          if (homeController.highlights.isNotEmpty) {
                            return commonText("Highlights of the Week",
                                size: 16, isBold: true);
                          }
                          return SizedBox();
                        },
                      ),
                      SizedBox(height: 12),
                      Obx(() {
                        if (homeController.highlights.isEmpty) {
                          return SizedBox();
                        }
                        return SizedBox(
                            height: 200,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  FoodMenu highLight =
                                      homeController.highlights[index];
                                  return InkWell(
                                    onTap: () {
                                      navigateToPage(FoodDetailsPage(
                                        id: highLight.id,
                                      ));
                                    },
                                    child: cardDesign(
                                      width: 190.0,
                                      name: highLight.name,
                                      imageUrl: getFullImagePath(highLight
                                              .image ??
                                          "https://dynamic-media.tacdn.com/media/photo-o/2e/d4/44/98/caption.jpg?w=700&h=500&s=1"),
                                      buttonName: highLight.category,
                                      ratting: highLight.rating.toString(),
                                      location: highLight.restaurentName,
                                      isleft: true,
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    width: 16,
                                  );
                                },
                                itemCount: homeController.highlights.length));
                      }),

                      SizedBox(height: 20),

                      // Stats Section
                      commonText("Your Stats", size: 16, isBold: true),
                      SizedBox(height: 12),
                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildStatCard(
                                "Logs This Week",
                                (homeController.userStatus.value != null)
                                    ? homeController
                                        .userStatus.value!.logThisWeek
                                        .toString()
                                    : "0"),
                            _buildStatCard(
                                "Favorite",
                                (homeController.userStatus.value != null)
                                    ? homeController
                                        .userStatus.value!.favourites
                                        .toString()
                                    : "0"),
                            _buildStatCard(
                              "Most Visited",
                              (homeController.userStatus.value != null)
                                  ? homeController.userStatus.value!.mostVisited
                                  : "N/A",
                            ),
                          ],
                        );
                      }),

                      SizedBox(height: 20),

                      // For You
                      Obx(
                        () {
                          if (homeController.highlights.isNotEmpty) {
                            return commonText("For You",
                                size: 16, isBold: true);
                          }
                          return SizedBox();
                        },
                      ),

                      SizedBox(height: 12),
                      Obx(() {
                        if (homeController.isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: homeController.foryou.length,
                          itemBuilder: (context, index) {
                            return _buildLogsCardDesign(
                              card: homeController.foryou[index],
                              ontap: () {
                                navigateToPage(FoodDetailsPage(
                                  id: homeController.foryou[index].id,
                                ));
                              },
                            );
                          },
                        );
                      })
                      // Chicken Burger again
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
  ) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonText(title, size: 12, isBold: true, color: AppColors.gray),
            SizedBox(height: 4),
            commonText(
              value,
              size: 12,
              isBold: true,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogsCardDesign({
    required FoodMenu card,
    required Function() ontap,
  }) {
    return InkWell(
      onTap: ontap,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                // Image
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(getFullImagePath(card.image ??
                            "https://dynamic-media.tacdn.com/media/photo-o/2e/d4/44/98/caption.jpg?w=700&h=500&s=1")), // fallback image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // Details
                ListTile(
                  title: commonText(card.name, size: 16, isBold: true),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Notes or Category Badge
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: commonText(
                          card.category,
                          size: 14,
                          isBold: true,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(height: 6),

                      // Restaurant info
                      Row(
                        children: [
                          Image.asset(AppAssetsPath.locationIcon),
                          SizedBox(width: 4),
                          commonText(card.restaurentName,
                              size: 12, isBold: true),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 16,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.star, size: 16, color: Colors.orange),
                  SizedBox(width: 2),
                  commonText(card.rating.toString(), isBold: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AdsCarousel extends StatefulWidget {
  final List<Map<String, String>> items; // keys: "image", "url"

  const AdsCarousel({Key? key, required this.items}) : super(key: key);

  @override
  State<AdsCarousel> createState() => _AdsCarouselState();
}

class _AdsCarouselState extends State<AdsCarousel> {
  late PageController _pageController;
  late int _initialPage;
  Timer? _timer;

  static const int _kInfiniteOffset = 10000;

  @override
  void initState() {
    super.initState();
    _initialPage =
        widget.items.isNotEmpty ? widget.items.length * _kInfiniteOffset : 0;
    _pageController = PageController(initialPage: _initialPage);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox();

    return SizedBox(
      height: 150,
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) {
          final itemIndex = index % widget.items.length;
          final imageUrl = widget.items[itemIndex]["image"] ?? "";
          final linkUrl = widget.items[itemIndex]["url"] ?? "";

          return InkWell(
            onTap: () async {
              final Uri url = Uri.parse(linkUrl);
              if (await canLaunchUrl(url)) {
                await launchUrl(
                  url,
                  mode: LaunchMode.externalApplication,
                );
              } else {
                throw 'Could not launch $linkUrl';
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.broken_image),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
