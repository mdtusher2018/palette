// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/controller/personal_details_controller.dart';
import 'package:palette/utils/helper.dart';
import 'package:palette/views/Feed/post_details_page.dart';
import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonDesigns.dart';
import 'package:palette/views/res/commonWidgets.dart';
import 'package:palette/views/Profile/badges_page.dart';
import 'package:palette/views/Feed/followers_page.dart';
import 'package:palette/views/Feed/following_page.dart';
import 'package:palette/views/Feed/logs_page.dart';

class PersonDetailsPage extends StatelessWidget {
  final String id;
  RxBool isFollow;
  PersonDetailsPage(
      {super.key, required, required this.id, required this.isFollow});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(PersonDetailsController(userId: id, isFollow: isFollow));
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final data = controller.userDetails.value;
      if (data == null)
        return Scaffold(
            body: Center(
                child: commonText("No Data Found", size: 18, isBold: true)));

      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header with cover and profile image
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(getFullImagePath(data.coverImage)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(getFullImagePath(data.image)),
                  ),
                  Positioned(top: 24, left: 16, child: commonBackButton())
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    commonText(data.fullName, size: 18, isBold: true),
                    const SizedBox(height: 4),
                    commonText(data.aboutme,
                        size: 16, isBold: true, textAlign: TextAlign.center),
                    const SizedBox(height: 4),
                    commonSmallButton(
                      text: (controller.isFollow.value) ? "Unfollow" : "Follow",
                      verticalPadding: 10,
                      color: AppColors.primary,
                      ontap: () {
                        controller.followUnfollow(id: id);
                      },
                      haveIcon: true,
                      width: 120,
                      fontSize: 16,
                      textColor: AppColors.white,
                      borderWidth: 0,
                      icon: Icon(Icons.add, color: AppColors.white),
                    ),
                    const SizedBox(height: 16),
                    // Followers, Following, Logs
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            onTap: () => navigateToPage(FollowersPage(
                                  id: id,
                                )),
                            child: profileStat(
                                data.followers.toString(), "Followers")),
                        Container(
                          color: AppColors.black.withOpacity(0.3),
                          height: 40,
                          width: 1,
                        ),
                        InkWell(
                            onTap: () => navigateToPage(FollowingPage(
                                  id: id,
                                )),
                            child: profileStat(
                                data.following.toString(), "Following")),
                        Container(
                          color: AppColors.black.withOpacity(0.3),
                          height: 40,
                          width: 1,
                        ),
                        InkWell(
                            onTap: () => navigateToPage(LogsPage(
                                  id: id,
                                )),
                            child:
                                profileStat(data.logsCount.toString(), "Logs")),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Badges
                    if (controller.badge.isNotEmpty)
                      Column(
                        children: [
                          sectionHeader("Badges", ontap: () {
                            navigateToPage(BadgesPage(
                              id: id,
                            ));
                          }),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 100,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.badges.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                return badgesCard(
                                  imageUrl: getFullImagePath(
                                      data.badges[index].image),
                                  name: data.badges[index].title,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        commonText("Stats", size: 18, isBold: true),
                      ],
                    ),
                    Row(
                      children: [
                        statsCard(
                            "Logs This Week", data.logThisWeek.toString()),
                        const SizedBox(width: 16),
                        statsCard("Favorite", data.favourites.toString()),
                        const SizedBox(width: 16),
                        statsCard("Most Visited", data.mostVisited),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        commonText("Food Logs", size: 18, isBold: true),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.logs.length,
                      padding: const EdgeInsets.only(top: 16),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final log = data.logs[index];
                        return InkWell(
                          onTap: () {
                            navigateToPage(PostDetailsPage(id: log.id));
                          },
                          child: buildPostCardDesign(
                            profileImage: data.image,
                            profileName: data.fullName,
                            menuImagePath: log.image,
                            name: log.itemName ?? "N/A",
                            time: getTimeDifference(log.createdAt.toString()),
                            resturant: log.restaurent,
                            ratting: log.rating.toString(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
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

  Widget statsCard(String label, String count) {
    if (count.isEmpty) {
      count = "N/A";
    }
    return Expanded(
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 2,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Row(
                  children: [
                    commonText(label,
                        size: 14, color: AppColors.gray, isBold: true),
                  ],
                ),
              ),
              SizedBox(height: 4),
              FittedBox(
                  child: Row(children: [
                commonText(count,
                    size: 14, isBold: true, color: AppColors.primary),
              ])),
            ],
          ),
        ),
      ),
    );
  }
}
