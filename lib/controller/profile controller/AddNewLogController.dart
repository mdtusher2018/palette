import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette/models/user%20models/catagory_model.dart';
import 'package:palette/repositories/profile_repository.dart';
import 'package:palette/services/api_service.dart';
import 'package:palette/services/profile_service.dart';

class AddNewLogController extends GetxController {
  // Controllers for text fields
  final TextEditingController restaurantController = TextEditingController();
  final TextEditingController itemController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  RxBool isLoading = false.obs;

  ProfileRepository profileRepository =
      ProfileRepository(ProfileService(ApiService()));

  // Rx variables for selected media
  Rx<File?> selectedImage = Rx<File?>(null);
  Rx<File?> selectedVideo = Rx<File?>(null);
  var categories = <FoodCategory>[].obs;

  var selectedCategory = Rxn<FoodCategory>();

  // Rx variable for rating
  RxDouble rating = 3.0.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  /// Pick an image and reset video
  Future<void> pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      selectedImage.value = File(picked.path);
      selectedVideo.value = null;
    }
  }

  /// Pick a video and reset image
  Future<void> pickVideo() async {
    final picked = await _picker.pickVideo(source: ImageSource.gallery);
    if (picked != null) {
      selectedVideo.value = File(picked.path);
      selectedImage.value = null;
    }
  }

  /// Update rating when a star is selected
  void updateRating(double newRating) {
    rating.value = newRating;
  }

  /// Validation before submitting
  bool isValidToSubmit() {
    if (restaurantController.text.trim().isEmpty ||
        itemController.text.trim().isEmpty ||
        notesController.text.trim().isEmpty) {
      return false;
    }

    if (selectedImage.value == null && selectedVideo.value == null) {
      return false;
    }

    return true;
  }

  Future<void> submitLog() async {
    isLoading.value = true;

    Map<String, dynamic> data = {
      "restaurent": restaurantController.text,
      "itemName": itemController.text,
      "rating": rating.value,
      "notes": notesController.text,
      if (selectedCategory.value != null) "item": selectedCategory.value!.id,
    };

    try {
      final result = await profileRepository.addNewLog(
        data: data,
        image: selectedImage.value,
        video: selectedVideo.value,
      );
      if (result.statusCode == 201) {
        Get.back();
        Get.snackbar("Success", "Log added successfully");
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar("Error", "Failed to add log");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      final result = await profileRepository.getAllFoodCategories();
      categories.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch logs");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    restaurantController.dispose();
    itemController.dispose();
    notesController.dispose();
    super.onClose();
  }
}
