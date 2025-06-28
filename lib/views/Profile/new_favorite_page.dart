import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/controller/profile%20controller/favorite_controller.dart';
import 'package:palette/models/user%20models/favorite_menu_folder_model.dart';
import 'package:palette/utils/helper.dart';
import 'package:palette/views/Home/resturant_details_page.dart';
import 'package:palette/views/Profile/favourite_items_page.dart';
import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonDesigns.dart';
import '../res/commonWidgets.dart';
import '../res/image_path.dart';

class NewFavoritePage extends StatelessWidget {
  final FavouriteController controller = Get.put(FavouriteController());
  NewFavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchFavouriteRestaurants();
      controller.fetchFolders();
    });
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          leading: commonBackButton(),
          title: commonText("Favorites",
              size: 20, color: AppColors.white, isBold: true),
        ),
        bottomSheet: Column(
          children: [
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  _buildMenu(),
                  _buildResturent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: EdgeInsets.only(left: 50, right: 50, top: 16, bottom: 16),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 1,
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TabBar(
            indicator: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            labelColor: AppColors.white,
            unselectedLabelColor: AppColors.black,
            dividerColor: Colors.transparent,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            unselectedLabelStyle: TextStyle(fontSize: 16),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: "Food Item"),
              Tab(text: "Restaurants"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResturent() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (controller.errorMessage.value != null) {
        return Center(
            child: commonText("Error: ${controller.errorMessage.value}"));
      }

      return ListView(
        padding: EdgeInsets.all(16),
        children: [
          if (controller.favouriteRestaurants.isEmpty)
            Center(
                child:
                    commonText("No Favorites Found", isBold: true, size: 18)),
          SizedBox(height: 12),
          gridSection(
            controller.favouriteRestaurants.map((restaurant) {
              return Stack(
                children: [
                  InkWell(
                    onTap: () {
                      navigateToPage(RestaurantDetailsPage(
                        id: restaurant.restaurant.id,
                      ));
                    },
                    child: cardDesign(
                      isdelete: true,
                      imageUrl: getFullImagePath(restaurant.restaurant.image),
                      buttonName: restaurant.restaurant.cuisines.join(", "),
                      ratting: restaurant.restaurant.rating.toString(),
                      location: restaurant.restaurant.address,
                      isleft: true,
                      name: restaurant.restaurant.fullName,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: InkWell(
                      onTap: () {
                        controller.unFavourite(
                            restaurantId: restaurant.restaurant.id);
                      },
                      child: Image.asset(
                        AppAssetsPath.delete,
                        width: 24,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
            ration: 0.65,
          ),
        ],
      );
    });
  }

  Widget _buildMenu() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (controller.errorMessage.value != null) {
        return Center(
            child: commonText("Error: ${controller.errorMessage.value}"));
      }

      return ListView(
        padding: EdgeInsets.all(16),
        children: [
          if (controller.favouriteRestaurants.isEmpty)
            Center(
                child:
                    commonText("No Favorites Found", isBold: true, size: 18)),
          SizedBox(height: 12),
          gridSection(
            controller.folders.map((folder) {
              // Handling the 4-image display logic
              List<MenuImage> images = folder.menuImages;

              if (images.isEmpty) {
                // Provide 4 default images
                images = [
                  MenuImage(
                      image:
                          'https://tse1.mm.bing.net/th/id/OIP.iZmRJpSySKsI7x8gUlTSyAHaEz?rs=1&pid=ImgDetMain'),
                  MenuImage(
                      image:
                          'https://tse3.mm.bing.net/th/id/OIP.1Vw2Q5yg2-QQyolad3TyawHaE2?w=5184&h=3397&rs=1&pid=ImgDetMain'),
                  MenuImage(
                      image:
                          'https://tse3.mm.bing.net/th/id/OIP.sZ4EFVSzgw4TxTESZR5PBQHaLH?w=800&h=1200&rs=1&pid=ImgDetMain'),
                  MenuImage(
                      image:
                          'https://tse4.mm.bing.net/th/id/OIP.paZokRr6HFdXZQoIAKmDjgHaEK?rs=1&pid=ImgDetMain'),
                ];
              } else if (images.length < 4) {
                // Repeat images to make 4
                final repeated = <MenuImage>[];
                for (int i = 0; i < 4; i++) {
                  repeated.add(images[i % images.length]);
                }
                images = repeated;
              } else {
                // Take only first 4 images
                images = images.take(4).toList();
              }

              return InkWell(
                onTap: () {
                  navigateToPage(
                      TopicWiseFavoritePage(
                        folderId: folder.id,
                      ), onPop: (p0) {
                    controller.fetchFolders();
                    controller.favouriteRestaurants();
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GridView.count(
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        children: images.map((url) {
                          return Image.network(
                            getFullImagePath(url.image),
                            fit: BoxFit.cover,
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 8),
                    commonText(folder.foldername,
                        isBold: true, size: 16, color: AppColors.black),
                  ],
                ),
              );
            }).toList(),
            ration: 0.8,
          ),
        ],
      );
    });
  }

  Widget gridSection(List<Widget> cards, {double ration = 0.7}) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: ration,
      children: cards,
    );
  }
}
