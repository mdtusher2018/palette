// lib/controllers/user_controller.dart
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palette/models/common_models.dart';
import 'package:palette/models/user%20models/change_password_model.dart';
import 'package:palette/models/user%20models/update_user_model.dart';
import 'package:palette/models/user%20models/user_profile.dart';
import 'package:palette/services/local_storage_service.dart';
import '../../repositories/profile_repository.dart';

class UserController extends GetxController {
  ProfileRepository userRepository;

  UserController(this.userRepository);

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var profileImageFile = Rxn<File>();
  var coverImageFile = Rxn<File>();
  final ImagePicker _picker = ImagePicker();

  var userProfile = Rxn<UserAttributes>();
  var userUpdateResponse = Rxn<UserUpdateResponse>();

  Rx<MyProfileAttributes?> profile = Rx<MyProfileAttributes?>(null);

  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final profileResponse = await userRepository.getUserProfile();
      userProfile.value = profileResponse.attributes;
      LocalStorageService().saveUserAttributes(profileResponse.attributes);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
    }
  }

  Future<void> fetchUserFullProfile() async {
    try {
      isLoading.value = true;
      final result = await userRepository.fetchMyProfile();
      profile.value = result.data.attributes.first;
    } catch (e) {
      Get.snackbar("Error", "Failed to load profile data");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changePassword(
      String oldPassword, String newPassword, String userEmail) async {
    var passwordChangedResponse = Rxn<PasswordChangedResponse>();
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await userRepository.changePassword(
          oldPassword, newPassword, userEmail);
      passwordChangedResponse.value = response;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
    }
  }

  Future<void> updateUserProfile(
      {required String fullName,
      required String phoneNumber,
      String? details,
      File? profileImage,
      File? coverImage}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Prepare the update data map
      final updateData = {
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        "aboutme": details,
      };
      if (details != null) {
        updateData['details'] = details;
      }

      final response = await userRepository.updateUserProfile(
          updateData: updateData,
          profileImage: profileImage,
          coverImage: coverImage);
      userUpdateResponse.value = response;
      isLoading.value = false;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        Get.back();
        Get.snackbar("Sucessfull", response.message);
      } else {
        Get.snackbar("Failed", response.message);
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();

      Get.snackbar("Failed", e.toString());
    }
  }

  Future<void> pickProfileImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final allowedExtensions = ['jpg', 'jpeg', 'png', 'heic', 'heif'];
      final ext = pickedFile.name.split('.').last.toLowerCase();

      if (allowedExtensions.contains(ext)) {
        profileImageFile.value = File(pickedFile.path);
      } else {
        Get.snackbar("Invalid format",
            "Please select a jpg, png, jpeg, heic or heif image");
      }
    }
  }

  Future<void> pickCoverImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final allowedExtensions = ['jpg', 'jpeg', 'png', 'heic', 'heif'];
      final ext = pickedFile.name.split('.').last.toLowerCase();

      if (allowedExtensions.contains(ext)) {
        coverImageFile.value = File(pickedFile.path);
      } else {
        Get.snackbar("Invalid format",
            "Please select a jpg, png, jpeg, heic or heif image");
      }
    }
  }
}
