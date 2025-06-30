import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette/repositories/home%20repository/home_repository.dart';

class SubmitFeedbackController extends GetxController {
  final HomeRepository _repo = HomeRepository();

  // State variables
  final reviewController = TextEditingController();
  RxDouble rating = 0.0.obs;
  Rxn<File> selectedMedia = Rxn<File>();
  RxnString mediaType = RxnString(); // 'image' or 'video'

  var isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  // Pick image from gallery
  Future<void> pickImage() async {
    final picked =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 75);
    if (picked != null) {
      selectedMedia.value = File(picked.path);
      mediaType.value = 'image';
    }
  }

  // Pick video from gallery
  Future<void> pickVideo() async {
    final picked = await _picker.pickVideo(
        source: ImageSource.gallery, maxDuration: const Duration(seconds: 15));
    if (picked != null) {
      selectedMedia.value = File(picked.path);
      mediaType.value = 'video';
    }
  }

  // Optional: clear media
  void clearMedia() {
    selectedMedia.value = null;
    mediaType.value = null;
  }

  // Submission logic
  Future<void> submitReview(
      {required String menuId, required String restaurantId}) async {
    final comment = reviewController.text.trim();
    if (comment.isEmpty || rating.value == 0) {
      Get.snackbar("Error", "Please provide a comment and rating.");
      return;
    }

    try {
      isLoading.value = true;
      final response = await _repo.submitFoodFeedback(
        menuId: menuId,
        restaurantId: restaurantId,
        comment: comment,
        rating: rating.value.toInt(),
        image: mediaType.value == 'image' ? selectedMedia.value : null,
        video: mediaType.value == 'video' ? selectedMedia.value : null,
      );
      Get.snackbar('Success', response.message);

      // Optional: Reset form
      reviewController.clear();
      rating.value = 0;
      clearMedia();
    } catch (e) {
      log(e.toString());
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
