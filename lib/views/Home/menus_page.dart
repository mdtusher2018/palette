import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/controller/home%20page%20controller/restaurant_details_controller.dart';
import 'package:palette/utils/helper.dart';

import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonDesigns.dart';
import 'package:palette/views/res/commonWidgets.dart';
import 'package:palette/views/Home/food_details_page.dart';

class MenusScreen extends StatelessWidget {
  final String restaurantId;

  const MenusScreen({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    final RestaurantDetailsController controller =
        Get.put(RestaurantDetailsController(restaurantId));
    controller.fetchMenus(restaurantId);
    return Scaffold(
      appBar: AppBar(
        title:
            commonText("Menus", size: 21, isBold: true, color: AppColors.white),
        leading: commonBackButton(),
      ),
      backgroundColor: AppColors.primary,
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isLoadingMenus.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.menuList.isEmpty) {
                  return Center(child: commonText("No menu found", size: 16));
                }

                return ListView.builder(
                  itemCount: controller.menuList.length,
                  itemBuilder: (context, index) {
                    final item = controller.menuList[index];

                    return menuCard(
                      catagory: item.category?.name ?? '',
                      name: item.name ?? "",
                      price: "\$${item.price.toStringAsFixed(2)}",
                      description: item.description ?? "",
                      rating: item.rating.toString(),
                      imageUrl: getFullImagePath(item.image ?? ""),
                      // You may need to prepend the base URL
                      onTap: () {
                        navigateToPage(FoodDetailsPage(id: item.id ?? ""));
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
