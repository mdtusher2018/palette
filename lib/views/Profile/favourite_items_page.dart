import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/controller/profile%20controller/menu_by_folder_id_controller.dart';
import 'package:palette/utils/helper.dart';

import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonDesigns.dart';
import 'package:palette/views/res/commonWidgets.dart';
import 'package:palette/views/res/image_path.dart';

class TopicWiseFavoritePage extends StatelessWidget {
  final String folderId; // Pass this in Navigator

  const TopicWiseFavoritePage({super.key, required this.folderId});

  @override
  Widget build(BuildContext context) {
    MenuByFolderIdController controller =
        Get.put(MenuByFolderIdController(folderId));
    return Scaffold(
      appBar: AppBar(
        title: commonText("Favorites",
            color: AppColors.white, size: 21, isBold: true),
        centerTitle: true,
        leading: commonBackButton(),
      ),
      backgroundColor: AppColors.primary,
      bottomSheet: SizedBox(
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            final attribute = controller.favouriteAttribute.value;

            if (attribute == null || attribute.favourites.isEmpty) {
              return Center(
                  child:
                      commonText("No favorites found", size: 16, isBold: true));
            }

            return gridSection(attribute.favourites.map((fav) {
              final menu = fav.menu;
              return Stack(
                children: [
                  cardDesign(
                    imageUrl: getFullImagePath(menu.image),
                    buttonName: menu.category.name.toString(),
                    ratting: menu.rating.toString(),
                    location: menu.restaurent.fullName,
                    name: menu.itemName,
                    isleft: false,
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: InkWell(
                      onTap: () {
                        controller.unFavourite(menuId: menu.id);
                      },
                      child: Image.asset(
                        AppAssetsPath.delete,
                        width: 24,
                      ),
                    ),
                  ),
                ],
              );
            }).toList());
          }),
        ),
      ),
    );
  }

  Widget gridSection(List<Widget> cards, {double ration = 0.9}) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: ration,
      children: cards,
    );
  }
}
