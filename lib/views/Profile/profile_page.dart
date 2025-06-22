// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/repositories/profile_repository.dart';
import 'package:palette/services/api_service.dart';
import 'package:palette/services/profile_service.dart';
import 'package:palette/utils/helper.dart';
import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonDesigns.dart';
import 'package:palette/views/res/commonWidgets.dart';
import 'package:palette/views/Profile/badges_page.dart';
import 'package:palette/views/Profile/challenges_page.dart';
import 'package:palette/views/Profile/favorites_page.dart';
import 'package:palette/views/Feed/followers_page.dart';
import 'package:palette/views/Feed/following_page.dart';
import 'package:palette/views/Profile/my_palette_page.dart';
import 'package:palette/views/Profile/profile_settings_page.dart';
import 'package:palette/views/Profile/top_rated_iteams_page.dart';

import '../../controller/profile controller/user_controller.dart';

class ProfilePage extends StatelessWidget {
  UserController controller =
      Get.put(UserController(ProfileRepository(ProfileService(ApiService()))));

  @override
  Widget build(BuildContext context) {
    controller.fetchUserFullProfile();
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        leading: SizedBox(),
        centerTitle: true,
        title: commonText("Profile",
            size: 21, isBold: true, color: AppColors.white),
      ),
      bottomSheet: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            if (controller.profile.value == null) {
              return Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile info
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(
                        (controller.profile.value!.image.isNotEmpty)
                            ? getFullImagePath(controller.profile.value!.image)
                            : 'https://www.w3schools.com/w3images/avatar2.png'),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          commonText(controller.profile.value!.fullName,
                              size: 18, isBold: true),
                          SizedBox(width: 6),
                          Icon(Icons.verified,
                              color: Colors.blueAccent, size: 18)
                        ],
                      ),
                      SizedBox(height: 4),
                      commonSmallButton(
                        text: "Explorer Palette",
                        width: 120,
                        borderWidth: 0,
                        color: AppColors.primary,
                        textColor: AppColors.white,
                      ),
                      SizedBox(height: 8),
                      commonSmallButton(
                        text: "Profile Settings",
                        ontap: () {
                          Get.put(UserController(
                              ProfileRepository(ProfileService(ApiService()))));

                          navigateToPage(ProfileSettingsPage());
                        },
                        width: 110,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Followers/Following
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            // Navigate to Followers Page
                            navigateToPage(
                                FollowersPage(
                                  id: controller.profile.value!.id,
                                  myinfo: true,
                                ), onPop: (value) {
                              controller.fetchUserFullProfile();
                            });
                          },
                          child: profileStat(
                              controller.profile.value!.followers.toString(),
                              "Followers")),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                          width: 1,
                          height: 40,
                          color: AppColors.black.withOpacity(0.5)),
                      SizedBox(
                        width: 30,
                      ),
                      InkWell(
                          onTap: () {
                            navigateToPage(
                                FollowingPage(
                                    id: controller.profile.value!.id,
                                    myinfo: true), onPop: (value) {
                              controller.fetchUserFullProfile();
                            });
                          },
                          child: profileStat(
                              controller.profile.value!.following.toString(),
                              "Following")),
                    ],
                  ),
                  SizedBox(height: 24),

                  // Badges Section
                  sectionHeader(
                    "Badges",
                    ontap: () {
                      navigateToPage(BadgesPage(
                        id: controller.profile.value!.id,
                      ));
                    },
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.profile.value!.badges.length,
                      separatorBuilder: (_, __) => SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        return badgesCard(
                            imageUrl: getFullImagePath(
                                controller.profile.value!.badges[index].image),
                            name:
                                controller.profile.value!.badges[index].title);
                      },
                    ),
                  ),
                  if (controller.profile.value!.topChallenges.isNotEmpty)
                    SizedBox(height: 24),

                  // Current Challenges
                  if (controller.profile.value!.topChallenges.isNotEmpty)
                    sectionHeader("Current Challenges", ontap: () {
                      // Navigate to Challenges Page
                      navigateToPage(ChallengesPage());
                    }),

                  if (controller.profile.value!.topChallenges.isNotEmpty)
                    SizedBox(height: 12),
                  Column(
                    children: controller.profile.value!.topChallenges
                        .map((challenge) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: challengeCard(challenge),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 24),

                  // Menu Items
                  menuItem(
                    "My Palette",
                    ontap: () {
                      // Navigate to My Palette Page
                      navigateToPage(MyPalettePage());
                    },
                  ),
                  menuItem(
                    "Top Rated Items",
                    ontap: () {
                      // Navigate to Top Rated Items Page
                      navigateToPage(TopRatedItemsPage(), onPop: (value) {
                        controller.fetchUserFullProfile();
                      });
                    },
                  ),
                  menuItem(
                    "Favorites",
                    ontap: () {
                      // Navigate to Favorites Page
                      navigateToPage(FavoritesPage());
                    },
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget profileStat(String count, String label) {
    return Column(
      children: [
        commonText(count, size: 18, isBold: true),
        SizedBox(height: 4),
        commonText(label, size: 14, color: AppColors.black, isBold: true),
      ],
    );
  }

  Widget sectionHeader(String title, {required Function()? ontap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        commonText(title, size: 16, isBold: true),
        InkWell(onTap: ontap, child: commonText("View All", isBold: true)),
      ],
    );
  }

  Widget menuItem(
    String label, {
    required Function()? ontap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: commonText(label, size: 16, isBold: true),
      trailing: Icon(Icons.chevron_right),
      onTap: ontap,
    );
  }
}
