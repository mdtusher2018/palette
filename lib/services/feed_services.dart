import 'dart:developer';

import 'package:palette/models/feed%20models/all_following_model.dart';
import 'package:palette/models/feed%20models/all_followers_model.dart';
import 'package:palette/models/feed%20models/badges_model.dart';
import 'package:palette/models/feed%20models/follow_unfollow_model.dart';
import 'package:palette/models/feed%20models/foodies_model.dart';
import 'package:palette/models/feed%20models/log_model.dart';
import 'package:palette/models/feed%20models/personal_details_model.dart';
import 'package:palette/models/feed%20models/single_log_model.dart';
import 'package:palette/services/api_service.dart';
import 'package:palette/utils/api_endpoints.dart';

class FeedService {
  final ApiService _apiService = ApiService();

  Future<FoodieListResponse> fetchFoodies() async {
    final json = await _apiService.get(ApiEndpoints.foodiesToFollow);
    return FoodieListResponse.fromJson(json);
  }

  Future<LogModel> fetchLogs() async {
    final json = await _apiService.get(ApiEndpoints.allFeed);
    return LogModel.fromJson(json);
  }

  Future<PersonalDetailsModel> fetchPersonalDetails(String id) async {
    final json = await _apiService.get(ApiEndpoints.personalDetails(id));
    return PersonalDetailsModel.fromJson(json);
  }

  Future<SingleLogModel> fetchALogDetails(String id) async {
    final json = await _apiService.get(ApiEndpoints.getLogDetails(id));
    return SingleLogModel.fromJson(json);
  }

  // Future<AllFollowerModel> fetchFollowers(String id, bool myinfo) async {
  //   final json = await _apiService.get(
  //       (myinfo) ? ApiEndpoints.myfollower : ApiEndpoints.getAllFollowers(id));
  //   return AllFollowerModel.fromJson(json);
  // }

  // Future<AllFollowingModel> fetchFollowing(String id, bool myinfo) async {
  //   final json = await _apiService.get(
  //       (myinfo) ? ApiEndpoints.myfollowing : ApiEndpoints.getAllFollowing(id));
  //   return AllFollowingModel.fromJson(json);
  // }

  Future<AllFollowerModel> fetchFollowers(String id, bool myinfo,
      {String? search}) async {
    String url =
        myinfo ? ApiEndpoints.myfollower : ApiEndpoints.getAllFollowers(id);

    if (search != null && search.isNotEmpty) {
      url += '?search=$search';
    }

    final json = await _apiService.get(url);
    return AllFollowerModel.fromJson(json);
  }

  Future<AllFollowingModel> fetchFollowing(String id, bool myinfo,
      {String? search}) async {
    String url =
        myinfo ? ApiEndpoints.myfollowing : ApiEndpoints.getAllFollowing(id);

    if (search != null && search.isNotEmpty) {
      url += '?search=$search';
    }

    final json = await _apiService.get(url);
    return AllFollowingModel.fromJson(json);
  }

  Future<LogModel> fetchLogsByUserId(String id) async {
    log(ApiEndpoints.getAllFeedByUSerId(id));
    final json = await _apiService.get(ApiEndpoints.getAllFeedByUSerId(id));
    return LogModel.fromJson(json);
  }

  Future<BadgeListResponse> fetchBadgeByUserId(String id) async {
    final json = await _apiService.get(ApiEndpoints.getAllBadgeByUSerId(id));
    return BadgeListResponse.fromJson(json);
  }

  Future<UserFollowUnfollowModel> folloUnfollow(String id) async {
    final json = await _apiService.get(ApiEndpoints.followUnfollow(id));
    return UserFollowUnfollowModel.fromJson(json);
  }
}
