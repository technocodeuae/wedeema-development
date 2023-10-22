import '../../core/enums/Saeed_URLs.dart';

class AppEndpoints {
  AppEndpoints._();

  static const String BASE_URL = 'https://wadeema.syria5.com/api/mobile/';
  static const String Authorization = 'auth/';
  static const String AuthorizationAPP = 'Authorization';
  static const String Filter = 'filtter/';
  static const String Categories = 'categories';
  static const String User = 'user/';
  static const String Ads = 'ad';
  static const String Chat = 'chat';
  static const String Notifications = 'notifications';


  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;
// to do

  /// AUTH API
  static const String register =  '${Authorization}signup';
  static const String authenticate =  '${Authorization}login';
  static const String logout =  '${Authorization}logout';
  static const String resetPassword =  '${Authorization}resetPassword';
  static const String forgetPassword =  '${Authorization}sendPasswordResetEmail';
  static const String sendVerificationCode =  '${Authorization}sendVerificationCode';
  static const String validateMobileNumber =  '${Authorization}validateMobileNumber';
  static const String verifyAccount =  '${Authorization}verifyAccount';


  ///
  static const String sponsors =  'sponsors';
  static const String allAdsFilter =  'filter/ads';
  static const String allAdsFilterSearch =  'search/ads';
  static const String allCategoryAds =  'ads';
  static const String allAdsRecent =  '${Filter}ads/recent';
  static const String allAdsMostRated =  '${Filter}ads/most_rated';
  static const String allAdsPopular =  '${Filter}ads/popular';
  static const String likeAd =  'like';
  static const String dislikeAd =  'dislike';
  static const String favouriteAd =  'add/to/favorite';
  static const String unFavouriteAd =  'delete/of/favorite';
  static const String categories =  Categories;
  static const String subCategories =  'sub${Categories}';
  static const String cities =  'cities';

  /// User
  static const String properties =  'properties';
  static const String profile =  '${User}profile/';
  static const String storeAds =  '${User}ad/store';
  static const String moreInfoProfile =  '${User}profile_see_more/';
  static const String showProfile =  '${User}profile_show/';
  static const String editProfile =  '${User}profile_edit';
  static const String blockUser =  '${User}block';
  static const String unBlockUser =  '${User}unblock';
  static const String followUser =  '${User}follow';
  static const String unFollowUser =  '${User}unFollow';
  static const String allFollowingsUser =  '${User}followings';
  static const String allFollowersUser =  '${User}followers';
  static const String allBlockersUser =  '${User}blockers';

  /// chat
  static const String allChats =  'chats';
  static const String getChatMassage =  '${Chat}/messages/';
  static const String sendMassage =  '${Chat}/send-message';


  /// rating
  static const String evaluate =  'evaluate';

  /// my favourite
  ///
  static const String myFavouriteAds =  'user/my_favorite_ads';


  /// notifications
  static const String allNotifications =  '${Notifications}';
  static const String readNotification =  '${Notifications}/read';
  static const String removeNotification =  '${Notifications}/remove';
  static const String changeNotificationStatus =  '${Authorization}/change_notification_status';


  /// Settings
  static const String allFaq =  'faqs';
  static const String aboutApp =  'about_app';
  static const String privacyPolicy =  'privacy_policy';
  static const String terms =  'terms';
}
