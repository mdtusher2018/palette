class ApiEndpoints {
  static const String baseUrl = 'http://172.252.13.74:8029/api/v1/'; //live
  static const String imageUrl = 'http://172.252.13.74:8029';

  // static const String baseUrl = 'http://10.0.70.37:8029/api/v1/';
  // static const String imageUrl = 'http://10.0.70.37:8029';
  // Auth endpoints
  static const String signIn = 'auth/local';
  static const String signUp = 'auth/signup';
  static const String googleSignin = 'auth/signInGoogle';
  static const String verifyEmail = 'auth/verify-email';
  static const String forgetPassword = 'auth/forget-password';
  static const String verifyOtp = 'auth/verify-otp';
  static const String resetPassword = 'auth/reset-password';
  static const String changePassword = 'auth/change-password';
  static const String resendOtp = 'auth/resend-otp';

  // User endpoints/Profile EndPoints
  static const String updateProfile = 'users/update-profile';
  static const String userDetails = 'users/user-details';
  static String staticContents(String type) => 'static-contents?type=$type';
  static const String topRated = "feedback/topratedItems";
  static const String userChallenge = "userChallenge/userCurrent-challenge";
  static const String addNewLog = "logs/add-log";
  static const String myProfile = "users/myprofile";
  static const String myfollower = "users/all-followers";
  static const String myfollowing = "users/all-following";
  static const String myLogs = "logs/my-logs";
  static const String myFeedBack = "feedback/my-feedback";
  static String pinUnpin(String id) => "feedback/toggle/$id";
  static const String fetchCatagory = "food-categories";

  // static const String deleteOwnAccount = 'users/delete-own-account';

  // Home page
  static const String highlights = 'menu-management/menu-highlights';
  static const String forYou = 'menu-management/manu-for-you';
  static const String ads = 'ads/allActive-ads';
  static String getMenuDetails(String id) => 'menu-management/get-menu/$id';
  static const String submitMenuFeedback = 'feedback/add-menu-feedback';
  static const String submitRestaurantFeedback =
      'feedback/add-restaurent-feedback';
  static const String userStatus = 'users/my-stats';
  static const String checkIn = 'checkIn';
  static const String getMyFolder = 'folder/all';
  static const String postMyFolder = 'folder/add';
  static const String addFavorite = "favourite";
  static String getRestaurantDetails(String id) => 'my-restaurent/$id';
  static String getMenuByRestaurantId(String id) => 'menu-management/$id';
  static String getGarallyByRestaurantId(String id) =>
      'gallery/galleryById/$id';
  static String getFeedbackRestaurantId(String id) => 'feedback/restaurant/$id';
  static String notification(String page, String limit) =>
      'notifications/my-notifications?page=$page&limit=$limit';

  //explore
  static const String exploreList = 'explore/list';
  static const String nearbyRestaurant = "my-restaurent/map";

  //feed
  static const String allFeed = "logs/feed";

  static const String foodiesToFollow = "users/fooodies";
  static String personalDetails(String id) => "users/personal/$id";
  static String getLogDetails(String id) => "logs/details/$id";
  static String getAllFollowers(String id) => "users/all-followers/$id";
  static String getAllFollowing(String id) => "users/all-following/$id";
  static String getAllFeedByUSerId(String id) => "logs/logsByUserId/$id";
  static String getAllBadgeByUSerId(String id) => "userChallenge/badges/$id";
  static String followUnfollow(String id) => "users/follow/$id";

  //favorite
  static const String myFavoriteResturent = "favourite/favourite-restaurant";
  static const String myFavoriteMenuFolders = "folder/menu-folders";
  static const String unFavorite = "favourite/unfavourite";
  static String menuByFolderId(String id) => "favourite/menuByFolder/$id";
}
