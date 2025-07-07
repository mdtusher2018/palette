// ignore_for_file: must_be_immutable

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/controller/home%20page%20controller/food_details_page_controller.dart';
import 'package:palette/utils/helper.dart';
import 'package:palette/views/Home/food_reviews_page.dart';
import 'package:palette/views/Home/give_food_review_page.dart';
import 'package:palette/views/Home/resturant_details_page.dart';
import 'package:palette/views/res/image_path.dart';
import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonDesigns.dart';
import 'package:palette/views/res/commonWidgets.dart';
import 'package:share_plus/share_plus.dart';

class FoodDetailsPage extends StatelessWidget {
  String id;

  FoodDetailsPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller with the id once.
    final MenuDetailsController controller =
        Get.put(MenuDetailsController(id), tag: id);

    return Obx(() {
      if (controller.isLoading.value || controller.menuDetails.value == null) {
        // If the menu item is not yet loaded, show a loading indicator.
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Food Image
              Stack(
                children: [
                  Image.network(
                    (controller.menuDetails.value!.image.isNotEmpty)
                        ? getFullImagePath(controller.menuDetails.value!.image)
                        : "https://static.vecteezy.com/system/resources/previews/023/809/530/non_2x/a-flying-burger-with-all-the-layers-ai-generative-free-photo.jpg",
                    height: 240,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 32),
                    child: commonBackButton(),
                  ),
                ],
              ),

              // Food Info
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonText(controller.menuDetails.value!.name,
                        size: 20, isBold: true),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            navigateToPage(RestaurantDetailsPage(
                                id: controller
                                    .menuDetails.value!.restaurentId));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (controller
                                  .menuDetails.value!.restaurentName.isNotEmpty)
                                Icon(Icons.location_pin,
                                    size: 16, color: AppColors.black),
                              SizedBox(width: 4),
                              commonText(
                                  controller.menuDetails.value!.restaurentName,
                                  isBold: true,
                                  size: 14),
                            ],
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.star, color: Colors.orange, size: 16),
                        SizedBox(width: 4),
                        commonText(
                            controller.menuDetails.value!.rating.toString(),
                            size: 14,
                            isBold: true),
                      ],
                    ),
                    SizedBox(height: 12),
                    commonText("\$${controller.menuDetails.value!.price}",
                        size: 18, isBold: true),
                    SizedBox(height: 16),

                    // Description
                    commonText("Description", size: 16, isBold: true),
                    SizedBox(height: 8),
                    commonText(
                      controller.menuDetails.value!.description.isNotEmpty
                          ? controller.menuDetails.value!.description
                          : "No description available for this item.",
                      size: 14,
                      color: AppColors.gray,
                    ),

                    SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              controller.fetchFolders().then(
                                (value) {
                                  showAddToFavoriteDialog(
                                    context,
                                    favorites: controller.folderList,
                                    postFolder: (value) async {
                                      return await controller
                                          .createNewFolder(value);
                                    },
                                    onFolderTap: (folderId) {
                                      controller.addFavourite(
                                          restaurantId: id, folderId: folderId);
                                          controller.fetchMenu(id);
                                    },
                                  );
                                },
                              );
                            },
                            icon: Icon((controller.menuDetails.value!.isFavourite)?Icons.favorite:Icons.favorite_border,
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
                                    'Try "${controller.menuDetails.value!.name}" at ${controller.menuDetails.value!.restaurentName} on the Palette App!',
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(AppAssetsPath.share),
                              commonText("Share", size: 14, isBold: true)
                            ],
                          ),
                        )),
                      ],
                    ),

                    SizedBox(height: 24),

                    // Reviews
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        commonText("Reviews", size: 16, isBold: true),
                        TextButton(
                          onPressed: () {
                            navigateToPage(FoodReviewsPage(
                              reviews: controller
                                      .menuDetails.value!.feedbacks.isNotEmpty
                                  ? List.generate(
                                      controller.menuDetails.value!.feedbacks
                                          .length, (index) {
                                      return {
                                        "text": controller.menuDetails.value!
                                            .feedbacks[index].comment,
                                        "rating": controller.menuDetails.value!
                                            .feedbacks[index].rating,
                                        "time": controller.menuDetails.value!
                                            .feedbacks[index].createdAt,
                                        'profileImage': controller
                                                .menuDetails
                                                .value!
                                                .feedbacks[index]
                                                .reviewerImage
                                                .isNotEmpty
                                            ? getFullImagePath(controller
                                                .menuDetails
                                                .value!
                                                .feedbacks[index]
                                                .reviewerImage)
                                            : "https://www.w3schools.com/w3images/avatar2.png",
                                        'name': controller.menuDetails.value!
                                            .feedbacks[index].reviewerName,
                                        'commentImage': (controller
                                                        .menuDetails
                                                        .value!
                                                        .feedbacks[index]
                                                        .image !=
                                                    null &&
                                                controller
                                                    .menuDetails
                                                    .value!
                                                    .feedbacks[index]
                                                    .image!
                                                    .isNotEmpty)
                                            ? getFullImagePath(controller
                                                .menuDetails
                                                .value!
                                                .feedbacks[index]
                                                .image
                                                .toString())
                                            : "",
                                        'video': (controller
                                                        .menuDetails
                                                        .value!
                                                        .feedbacks[index]
                                                        .video !=
                                                    null &&
                                                controller
                                                    .menuDetails
                                                    .value!
                                                    .feedbacks[index]
                                                    .video!
                                                    .isNotEmpty)
                                            ? controller.menuDetails.value!
                                                .feedbacks[index].video!
                                                .toString()
                                            : ""
                                      };
                                    })
                                  : [],
                            ));
                          },
                          child: commonText("See All",
                              size: 14, color: AppColors.primary),
                        ),
                      ],
                    ),
                    buildReviews(
                        reviews:
                            controller.menuDetails.value!.feedbacks.isNotEmpty
                                ? List.generate(
                                    min(
                                        controller.menuDetails.value!.feedbacks
                                            .length,
                                        5), (index) {
                                    return {
                                      "text": controller.menuDetails.value!
                                          .feedbacks[index].comment,
                                      "rating": controller.menuDetails.value!
                                          .feedbacks[index].rating,
                                      "time": controller.menuDetails.value!
                                          .feedbacks[index].createdAt,
                                      'profileImage': controller
                                              .menuDetails
                                              .value!
                                              .feedbacks[index]
                                              .reviewerImage
                                              .isNotEmpty
                                          ? getFullImagePath(controller
                                              .menuDetails
                                              .value!
                                              .feedbacks[index]
                                              .reviewerImage)
                                          : "https://www.w3schools.com/w3images/avatar2.png",
                                      'name': controller.menuDetails.value!
                                          .feedbacks[index].reviewerName,
                                      'commentImage': (controller
                                                      .menuDetails
                                                      .value!
                                                      .feedbacks[index]
                                                      .image !=
                                                  null &&
                                              controller
                                                  .menuDetails
                                                  .value!
                                                  .feedbacks[index]
                                                  .image!
                                                  .isNotEmpty)
                                          ? getFullImagePath(controller
                                              .menuDetails
                                              .value!
                                              .feedbacks[index]
                                              .image
                                              .toString())
                                          : "",
                                      'video': (controller.menuDetails.value!
                                                      .feedbacks[index].video !=
                                                  null &&
                                              controller
                                                  .menuDetails
                                                  .value!
                                                  .feedbacks[index]
                                                  .video!
                                                  .isNotEmpty)
                                          ? controller.menuDetails.value!
                                              .feedbacks[index].video!
                                              .toString()
                                          : ""
                                    };
                                  })
                                : [],
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: commonButton("Give Review", onTap: () {
                  navigateToPage(
                      GiveReviewPage(
                        id: controller.id,
                        isMenu: true,
                      ), onPop: (value) {
                    controller.fetchMenu(id);
                  });
                }),
              ),
              SizedBox(
                height: 24,
              )
            ],
          ),
        ),
      );
    });
  }
}
