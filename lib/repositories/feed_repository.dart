import 'package:palette/models/feed%20models/all_following_model.dart';
import 'package:palette/models/feed%20models/all_followers_model.dart';
import 'package:palette/models/feed%20models/badges_model.dart';
import 'package:palette/models/feed%20models/follow_unfollow_model.dart';
import 'package:palette/models/feed%20models/foodies_model.dart';
import 'package:palette/models/feed%20models/log_model.dart';
import 'package:palette/models/feed%20models/personal_details_model.dart';
import 'package:palette/models/feed%20models/single_log_model.dart';
import 'package:palette/services/feed_services.dart';

class FeedRepository {
  final FeedService _feedService = FeedService();

  Future<FoodieListResponse> getFoodies() async {
    return await _feedService.fetchFoodies();
  }

  Future<LogModel> getLogs() async {
    return await _feedService.fetchLogs();
  }

  Future<PersonalDetailsModel> getPersonalDetails(String id) async {
    return await _feedService.fetchPersonalDetails(id);
  }

  Future<SingleLogModel> getALogDetails(String id) async {
    return await _feedService.fetchALogDetails(id);
  }

  Future<AllFollowerModel> getFollowers(String id, bool myinfo) async {
    return await _feedService.fetchFollowers(id, myinfo);
  }

  Future<AllFollowingModel> getFollowing(String id, bool myinfo) async {
    return await _feedService.fetchFollowing(id, myinfo);
  }

  Future<LogModel> getALlLogsByUserId(String id) async {
    return await _feedService.fetchLogsByUserId(id);
  }

  Future<BadgeListResponse> getALlBadgeByUserId(String id) async {
    return await _feedService.fetchBadgeByUserId(id);
  }

  Future<UserFollowUnfollowModel> followUnfollow(String id) async {
    return await _feedService.folloUnfollow(id);
  }
}
