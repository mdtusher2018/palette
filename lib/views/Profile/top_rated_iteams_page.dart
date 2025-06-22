import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette/controller/profile%20controller/top_reated_controller.dart';

import 'package:palette/models/user%20models/top_reated_iteams_model.dart';
import 'package:palette/views/res/colors.dart';
import 'package:palette/views/res/commonWidgets.dart';
import 'package:palette/views/res/image_path.dart';

class TopRatedItemsPage extends StatelessWidget {
  final TopRatedItemsController _controller =
      Get.put(TopRatedItemsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: commonBackButton(),
        title: commonText("Top Rated Items",
            size: 21, isBold: true, color: AppColors.white),
        centerTitle: true,
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.items.isEmpty) {
          return const Center(child: Text("No top rated items found"));
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: AppColors.backgroundWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: ListView.separated(
            itemCount: _controller.items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) =>
                itemCard(_controller.items[index], _controller),
          ),
        );
      }),
    );
  }

  Widget itemCard(TopRatedItem item, TopRatedItemsController controller) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      elevation: 1,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                item.menuImage ?? '',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 50),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText(item.menuName,
                      size: 16,
                      fontWeight: FontWeight.w900,
                      color: AppColors.black),
                  const SizedBox(height: 4),
                  commonText(item.restaurentName,
                      size: 14,
                      color: AppColors.black,
                      fontWeight: FontWeight.w900),
                ],
              ),
            ),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 18),
                const SizedBox(width: 4),
                commonText(item.rating.toStringAsFixed(1),
                    size: 14,
                    color: AppColors.black,
                    fontWeight: FontWeight.w900),
                const SizedBox(width: 12),
                InkWell(
                  onTap: () => controller.togglePinUnpin(item.id),
                  child: Image.asset(
                    AppAssetsPath.pin,
                    color: item.pinned ? Colors.red.shade700 : AppColors.gray,
                    width: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
