// lib/data/services/user_service.dart
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:palette/models/unfavorite_model.dart';
import 'package:palette/models/user%20models/UserCurrentChallengeModel.dart';
import 'package:palette/models/user%20models/_folder_wise_favorite_menu.dart';
import 'package:palette/models/user%20models/add_new_log_model.dart';
import 'package:palette/models/user%20models/catagory_model.dart';
import 'package:palette/models/user%20models/change_password_model.dart';
import 'package:palette/models/user%20models/favorite_menu_folder_model.dart';
import 'package:palette/models/user%20models/my_feedback_model.dart';
import 'package:palette/models/user%20models/my_log_model.dart';
import 'package:palette/models/user%20models/pin_unpin_model.dart';
import 'package:palette/models/user%20models/resturent_favorite_model.dart';
import 'package:palette/models/user%20models/top_reated_iteams_model.dart';
import 'package:palette/models/user%20models/update_user_model.dart';
import 'package:http/http.dart' as http;
import 'package:palette/models/user%20models/user_profile.dart';
import 'package:palette/services/local_storage_service.dart';
import '../../utils/api_endpoints.dart';
import 'api_service.dart';
import 'package:http_parser/http_parser.dart';

class ProfileService {
  ApiService apiService;

  ProfileService(this.apiService);

  Future<dynamic> getUserProfile() async {
    final response = await apiService.get(ApiEndpoints.userDetails);
    return response;
  }

  Future<PasswordChangedResponse> changePassword(
      String oldPassword, String newPassword, String userEmail) async {
    final body = {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
      'userEmail': userEmail,
    };

    final jsonResponse =
        await apiService.patch(ApiEndpoints.changePassword, body);
    return PasswordChangedResponse.fromJson(jsonResponse);
  }

  Future<UserUpdateResponse> updateProfile({
    required Map<String, dynamic> data,
    File? profileImage,
    File? coverImage,
  }) async {
    final uri =
        Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.updateProfile}');

    final request = http.MultipartRequest('PUT', uri);

    LocalStorageService _localStorage = LocalStorageService();
    request.headers['Authorization'] =
        'Bearer ${await _localStorage.getToken()}';

    request.fields['data'] = jsonEncode(data);

    // Helper function to get MIME type from file extension
    MediaType getMediaType(String path) {
      final ext = path.split('.').last.toLowerCase();
      switch (ext) {
        case 'jpg':
        case 'jpeg':
          return MediaType('image', 'jpeg');
        case 'png':
          return MediaType('image', 'png');
        case 'heic':
          return MediaType('image', 'heic');
        case 'heif':
          return MediaType('image', 'heif');
        default:
          // Default fallback MIME type; you may also throw here if unsupported
          return MediaType('application', 'octet-stream');
      }
    }

    if (profileImage != null) {
      final mimeType = getMediaType(profileImage.path);
      request.files.add(await http.MultipartFile.fromPath(
        'profileImage',
        profileImage.path,
        contentType: mimeType,
      ));
    }

    if (coverImage != null) {
      final mimeType = getMediaType(coverImage.path);
      request.files.add(await http.MultipartFile.fromPath(
        'coverImage',
        coverImage.path,
        contentType: mimeType,
      ));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body);
      return UserUpdateResponse.fromJson(json);
    } else {
      throw Exception('Failed to update profile: ${response.body}');
    }
  }

  Future<TopRatedItemsModel> getTopRatedItems() async {
    final response = await apiService.get(ApiEndpoints.topRated);
    return TopRatedItemsModel.fromJson(response);
  }

  Future<UserCurrentChallengeModel> fetchCurrentChallenges() async {
    final response = await apiService.get(ApiEndpoints.userChallenge);
    return UserCurrentChallengeModel.fromJson(response);
  }

  Future<AddNewLogModel> addNewLog({
    required Map<String, dynamic> data,
    File? image,
    File? video,
  }) async {
    final uri = Uri.parse('${ApiEndpoints.baseUrl}${ApiEndpoints.addNewLog}');
    final request = http.MultipartRequest('POST', uri);

    final _localStorage = LocalStorageService();
    request.headers['Authorization'] =
        'Bearer ${await _localStorage.getToken()}';

    request.fields['data'] = jsonEncode(data);

    // ✅ Helper function to detect MIME types for image and video
    MediaType getMediaType(String path) {
      final ext = path.split('.').last.toLowerCase();
      switch (ext) {
        // Image formats
        case 'jpg':
        case 'jpeg':
          return MediaType('image', 'jpeg');
        case 'png':
          return MediaType('image', 'png');
        case 'heic':
          return MediaType('image', 'heic');
        case 'heif':
          return MediaType('image', 'heif');

        // Video formats
        case 'mp4':
          return MediaType('video', 'mp4');
        case 'mov':
          return MediaType('video', 'quicktime');
        case 'avi':
          return MediaType('video', 'x-msvideo');
        case 'mkv':
          return MediaType('video', 'x-matroska');
        case 'webm':
          return MediaType('video', 'webm');

        default:
          return MediaType('application', 'octet-stream');
      }
    }

    if (image != null) {
      final mimeType = getMediaType(image.path);
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
        contentType: mimeType,
      ));
    }

    if (video != null) {
      final mimeType = getMediaType(video.path);
      request.files.add(await http.MultipartFile.fromPath(
        'video',
        video.path,
        contentType: mimeType,
      ));
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body);
      log(response.body);
      return AddNewLogModel.fromJson(json);
    } else {
      throw Exception('Failed to upload log: ${response.body}');
    }
  }

  Future<FoodCategoryModel> fetchFoodCategories() async {
    final response = await apiService.get(ApiEndpoints.fetchCatagory);
    return FoodCategoryModel.fromJson(response);
  }

  Future<MyProfileModel> getMyProfile() async {
    final response = await apiService.get(ApiEndpoints.myProfile);
    return MyProfileModel.fromJson(response);
  }

  Future<MyLogsResponse> getMyLogs() async {
    final response = await apiService.get(ApiEndpoints.myLogs);
    return MyLogsResponse.fromJson(response);
  }

  Future<MyFeedbackModel> getMyFeedback() async {
    final response = await apiService.get(ApiEndpoints.myFeedBack);
    return MyFeedbackModel.fromJson(response);
  }

  Future<FeedbackPinUnpinResponse> togglePinUnpinFeedback(
      String feedbackId) async {
    final responseJson =
        await apiService.get(ApiEndpoints.pinUnpin(feedbackId));
    return FeedbackPinUnpinResponse.fromJson(responseJson);
  }

  Future<FavouriteRestaurantsResponse> getMyFavoriteResturent() async {
    final responseJson = await apiService.get(ApiEndpoints.myFavoriteResturent);
    return FavouriteRestaurantsResponse.fromJson(responseJson);
  }

  Future<FavoriteMenuFoldersFetchResponse> getMyFavoriteMenuFoler() async {
    final responseJson =
        await apiService.get(ApiEndpoints.myFavoriteMenuFolders);
    return FavoriteMenuFoldersFetchResponse.fromJson(responseJson);
  }

  Future<UnfavouriteResponse> unFavorite(Map<String, String> body) async {
    final responseJson = await apiService.post(ApiEndpoints.unFavorite, body);
    return UnfavouriteResponse.fromJson(responseJson);
  }

  Future<FolderWiseFavouriteResponse> menuByFolderId(
      {required String id}) async {
    final responseJson = await apiService.get(ApiEndpoints.menuByFolderId(id));
    return FolderWiseFavouriteResponse.fromJson(responseJson);
  }
}
