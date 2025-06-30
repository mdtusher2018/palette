// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/controller/home%20page%20controller/restaurant_details_controller.dart';
import 'package:palette/models/common_models.dart';
import 'package:palette/utils/helper.dart';
import 'package:palette/views/Home/give_food_review_page.dart';
import 'package:palette/views/Home/resturant_reviews_page.dart';
import 'package:palette/views/res/image_path.dart';
import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonDesigns.dart';
import 'package:palette/views/res/commonWidgets.dart';
import 'package:palette/views/Home/photos_page.dart';
import 'package:palette/views/Home/food_details_page.dart';
import 'package:palette/views/Home/menus_page.dart';
import 'package:share_plus/share_plus.dart';

class RestaurantDetailsPage extends StatelessWidget {
  RxInt _currentTabIndex = 0.obs;
  String id;
  RestaurantDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final RestaurantDetailsController controller =
        Get.put(RestaurantDetailsController(id), tag: id);
    controller.fetchRestaurantDetails(id);

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value ||
            controller.restaurantDetails.value == null) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 45.0),
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            getFullImagePath(controller
                                    .restaurantDetails.value!.coverImage ??
                                "https://www.w3schools.com/w3images/lights.jpg"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 16,
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(getFullImagePath(controller
                                        .restaurantDetails.value!.image ??
                                    "https://www.w3schools.com/w3images/avatar2.png")),
                                fit: BoxFit.cover)),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0, top: 24),
                    child: commonBackButton(),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonText(
                        controller.restaurantDetails.value!.fullName ?? "",
                        size: 22,
                        isBold: true),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        if (controller.restaurantDetails.value!.restaurant !=
                            null)
                          commonText(
                              controller
                                  .restaurantDetails.value!.restaurant!.rating
                                  .toString(),
                              size: 14),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 14, color: AppColors.black),
                        SizedBox(width: 4),
                        commonText(
                            controller.restaurantDetails.value!.address ?? "",
                            size: 12),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time,
                            size: 14, color: AppColors.black),
                        SizedBox(width: 4),
                        commonText(
                            getTodayOpenStatus(controller.restaurantDetails
                                .value!.restaurant!.openHours),
                            size: 12),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 14, color: AppColors.black),
                        SizedBox(width: 4),
                        commonText(
                            controller.restaurantDetails.value!.phoneNumber ??
                                "",
                            size: 12),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              controller.fetchFolders().then(
                                (value) {
                                  controller.addFavourite(
                                      restaurantId: id, folderId: "");
                                },
                              );
                            },
                            icon: Icon(Icons.favorite_border,
                                color: AppColors.primary),
                            label: commonText("Add To Favorite",
                                color: AppColors.primary, isBold: true),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColors.primary),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              SharePlus.instance.share(
                                ShareParams(
                                  text:
                                      'Try ${controller.restaurantDetails.value!.fullName} on the Palette App!',
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(AppAssetsPath.share),
                                commonText("Share", size: 14, isBold: true),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(children: [
                      _buildTabBar(),
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return FadeTransition(
                              opacity: animation, child: child);
                        },
                        child: IndexedStack(
                          key: ValueKey<int>(_currentTabIndex.value),
                          index: _currentTabIndex.value,
                          children: [
                            _buildMenuSection(
                              menus: controller.restaurantDetails.value!.menus,
                              isCheckIn: (controller.restaurantDetails.value!
                                          .restaurant !=
                                      null)
                                  ? controller.restaurantDetails.value!
                                          .restaurant!.checkin ??
                                      false
                                  : false,
                              onCheckIn: () {
                                if (controller.restaurantDetails.value!
                                            .restaurant !=
                                        null &&
                                    controller.restaurantDetails.value!
                                            .restaurant!.checkin !=
                                        null) {
                                  controller.checkInToRestaurant(id).then(
                                      (value) => controller
                                          .fetchRestaurantDetails(id));
                                } else {
                                  Get.snackbar("Check In",
                                      "You have already checked in");
                                }
                              },
                            ),
                            _buildPhotoSection(
                                photoPaths: controller
                                    .restaurantDetails.value!.gallery
                                    .map((photo) => getFullImagePath(photo))
                                    .toList()),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        navigateToPage(RestautentReviewsPage(
                                          restaurantId: id,
                                        ));
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: commonText("See all",
                                            size: 16, color: AppColors.primary),
                                      ),
                                    )
                                  ],
                                ),
                                buildReviews(
                                    reviews: controller.restaurantDetails.value!
                                            .feedbacks.isNotEmpty
                                        ? List.generate(
                                            controller.restaurantDetails.value!
                                                .feedbacks.length, (index) {
                                            return {
                                              "text": controller
                                                  .restaurantDetails
                                                  .value!
                                                  .feedbacks[index]
                                                  .comment,
                                              "rating": controller
                                                  .restaurantDetails
                                                  .value!
                                                  .feedbacks[index]
                                                  .rating,
                                              "time": controller
                                                  .restaurantDetails
                                                  .value!
                                                  .feedbacks[index]
                                                  .createdAt,
                                              'profileImage': (controller
                                                              .restaurantDetails
                                                              .value!
                                                              .feedbacks[index]
                                                              .reviewerImage !=
                                                          null &&
                                                      controller
                                                          .restaurantDetails
                                                          .value!
                                                          .feedbacks[index]
                                                          .reviewerImage!
                                                          .isNotEmpty)
                                                  ? getFullImagePath(controller
                                                          .restaurantDetails
                                                          .value!
                                                          .feedbacks[index]
                                                          .reviewerImage ??
                                                      "https://www.w3schools.com/w3images/avatar2.png")
                                                  : "https://www.w3schools.com/w3images/avatar2.png",
                                              'name': controller
                                                  .restaurantDetails
                                                  .value!
                                                  .feedbacks[index]
                                                  .reviewerName,
                                              'commentImage': (controller
                                                              .restaurantDetails
                                                              .value!
                                                              .feedbacks[index]
                                                              .image !=
                                                          null &&
                                                      controller
                                                          .restaurantDetails
                                                          .value!
                                                          .feedbacks[index]
                                                          .image!
                                                          .isNotEmpty)
                                                  ? getFullImagePath(controller
                                                      .restaurantDetails
                                                      .value!
                                                      .feedbacks[index]
                                                      .image
                                                      .toString())
                                                  : "",
                                              'video': (controller
                                                              .restaurantDetails
                                                              .value!
                                                              .feedbacks[index]
                                                              .video !=
                                                          null &&
                                                      controller
                                                          .restaurantDetails
                                                          .value!
                                                          .feedbacks[index]
                                                          .video!
                                                          .isNotEmpty)
                                                  ? controller
                                                      .restaurantDetails
                                                      .value!
                                                      .feedbacks[index]
                                                      .video!
                                                      .toString()
                                                  : ""
                                            };
                                          })
                                        : [],
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true),
                                commonButton("Give Review", onTap: () {
                                  navigateToPage(
                                      GiveReviewPage(
                                        id: controller.id,
                                        isMenu: false,
                                      ), onPop: (value) {
                                    controller.fetchRestaurantDetails(id);
                                  });
                                }, borderRadious: 8),
                                SizedBox(height: 16),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 16),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 1,
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              for (int index = 0; index < 3; index++)
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _currentTabIndex.value = index;
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _currentTabIndex.value == index
                            ? AppColors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: commonText(
                        ["Menu", "Photos", "Reviews"][index],
                        isBold: true,
                        color: _currentTabIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuSection(
      {required List<RestaurantMenu> menus,
      required bool isCheckIn,
      required Function() onCheckIn}) {
    if (menus.isEmpty) {
      return Center(
        child: commonText("No Menu Found", size: 14, isBold: true),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 10),
        Column(
          children: List.generate(
            menus.length,
            (index) => menuCard(
              catagory: (menus[index].category != null)
                  ? menus[index].category!.name ?? "General"
                  : "General",
              description:
                  menus[index].description ?? "No description available",
              imageUrl: getFullImagePath(menus[index].image ?? ""),
              name: menus[index].name ?? "",
              price: menus[index].price.toString(),
              rating: menus[index].rating.toString(),
              onTap: () {
                navigateToPage(FoodDetailsPage(id: menus[index].id!));
              },
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        commonButton("View all menus", onTap: () {
          navigateToPage(MenusScreen(
            restaurantId: id,
          ));
        }, height: 40, width: 150, borderRadious: 8),
        SizedBox(height: 16),
        InkWell(
          onTap: onCheckIn,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: AppColors.primary),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset((isCheckIn)
                    ? AppAssetsPath.checkhin
                    : AppAssetsPath.locationIcon),
                SizedBox(width: 16),
                commonText("Check In"),
              ],
            ),
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildPhotoSection({required List<String> photoPaths}) {
    if (photoPaths.isEmpty) {
      return Center(
        child: commonText("No Menu Found", size: 14, isBold: true),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          GridView.builder(
            itemCount: photoPaths.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  photoPaths[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          SizedBox(
            height: 16,
          ),
          commonButton("View all photos", onTap: () {
            navigateToPage(PhotosPage(
              restaurantId: id,
            ));
          }, height: 40, width: 150, borderRadious: 8),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
