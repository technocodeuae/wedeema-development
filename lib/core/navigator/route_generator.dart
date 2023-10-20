import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wadeema/ui/address/map/pages/map_page.dart';
import 'package:wadeema/ui/work_focus_version/auth/pages/change_password_page_new.dart';
import 'package:wadeema/ui/work_focus_version/auth/pages/complete_info_page.dart';
import 'package:wadeema/ui/work_focus_version/auth/pages/forget_pasword_page.dart';
import 'package:wadeema/ui/work_focus_version/auth/pages/send_otp_page.dart';
import 'package:wadeema/ui/work_focus_version/tour/tour_page.dart';

import '../../../../ui/work_focus_version/splash/pages/splash_page.dart';
import '../../data/models/profile/entity/profile_entity.dart';
import '../../ui/work_focus_version/ads/args/argument_category.dart';
import '../../ui/work_focus_version/ads/args/argument_policy.dart';
import '../../ui/work_focus_version/ads/pages/add_details_page.dart';
import '../../ui/work_focus_version/ads/pages/add_main_details_page.dart';
import '../../ui/work_focus_version/ads/pages/choose_listing_page.dart';
import '../../ui/work_focus_version/ads/pages/choose_right_category_page.dart';
import '../../ui/work_focus_version/ads/pages/safety_page.dart';
import '../../ui/work_focus_version/ads/pages/select_city_page.dart';
import '../../ui/work_focus_version/auth/pages/change_password_page.dart';
import '../../ui/work_focus_version/auth/pages/forget_password_page_old.dart';
import '../../ui/work_focus_version/auth/pages/otp_page.dart';
import '../../ui/work_focus_version/auth/pages/sign_in_page.dart';
import '../../ui/work_focus_version/auth/pages/sign_in_with_phone_number.dart';
import '../../ui/work_focus_version/auth/pages/sign_up_page.dart';
import '../../ui/work_focus_version/chat/args/argument_message.dart';
import '../../ui/work_focus_version/chat/pages/chat_messages_page.dart';
import '../../ui/work_focus_version/chat/pages/chats_page.dart';
import '../../ui/work_focus_version/home/arg/items_args.dart';
import '../../ui/work_focus_version/home/arg/view_all_args.dart';
import '../../ui/work_focus_version/home/pages/home_page.dart';
import '../../ui/work_focus_version/home/pages/items_details_page.dart';
import '../../ui/work_focus_version/home/pages/looking_for_details_page.dart';
import '../../ui/work_focus_version/home/pages/my_favourite_page.dart';
import '../../ui/work_focus_version/home/pages/search_page.dart';
import '../../ui/work_focus_version/home/pages/view_all_page.dart';
import '../../ui/work_focus_version/notifications/pages/notifications_page.dart';
import '../../ui/work_focus_version/onboarding/pages/onboarding_page.dart';
import '../../ui/work_focus_version/profile/pages/client_account_page.dart';
import '../../ui/work_focus_version/profile/pages/edit_account_page.dart';
import '../../ui/work_focus_version/profile/pages/follow_follower_block_user_page.dart';
import '../../ui/work_focus_version/profile/pages/more_info_page.dart';
import '../../ui/work_focus_version/profile/pages/my_account_page.dart';
import '../../ui/work_focus_version/profile/pages/my_profile_page.dart';
import '../../ui/work_focus_version/settings/pages/about_app_page.dart';
import '../../ui/work_focus_version/settings/pages/account_settings_pages.dart';
import '../../ui/work_focus_version/settings/pages/faq_page.dart';
import '../../ui/work_focus_version/settings/pages/privacy_policy_page.dart';
import '../../ui/work_focus_version/settings/pages/terms_and_conditions_page.dart';

class RouteGenerator {
  static Route? generateRoutes(RouteSettings settings) {
    final args = settings.arguments;
    return CupertinoPageRoute(builder: (BuildContext context) => getPage(settings, args), settings: settings);
    // return PageRouteBuilder(
    //   pageBuilder: (c, a1, a2) {
    //     return getPage(settings, args);
    //   },
    //   settings: settings,
    // );
  }

  static Widget getPage(RouteSettings settings, args) {
    switch (settings.name) {
      // case TaskPage.routeName:
      //   return TaskPage(
      //     isComingFromMetro: settings.arguments as bool?,
      //   );
      case SplashPage.routeName:
        return SplashPage();

      case SignInPage.routeName:
        return SignInPage();

      case SignInWithPhoneNumber.routeName:
        return SignInWithPhoneNumber();

      case SignUpPage.routeName:
        return SignUpPage();

      case MapPage.routeName:
        return MapPage();

      case HomePage.routeName:
        return HomePage();

      case TourPage.routeName:
        return TourPage();

      case FollowFollowerBlockUser.routeName:
        return FollowFollowerBlockUser(
          action: (settings.arguments as int?),
        );

      case FAQPage.routeName:
        return FAQPage();

      case AboutAppPage.routeName:
        return AboutAppPage();

      case AccountSettingsPage.routeName:
        return AccountSettingsPage();

      case PrivacyPolicyPage.routeName:
        return PrivacyPolicyPage();

      case TermsPage.routeName:
        return TermsPage();

      case MyFavouritePage.routeName:
        return MyFavouritePage();

      case SearchPage.routeName:
        return SearchPage();

      case ViewAllPage.routeName:
        return ViewAllPage(
          arg: (settings.arguments as ViewAllArgs),
        );
      case ChatMessagesPage.routeName:
        return ChatMessagesPage(
          data: (settings.arguments as ArgumentMessage),
        );

      case NotificationsPage.routeName:
        return NotificationsPage();

      case MyProfilePage.routeName:
        return MyProfilePage();

      case MyAccountPage.routeName:
        return MyAccountPage();

      case ClientAccountPage.routeName:
        return ClientAccountPage(
          userId: (settings.arguments as int?),
        );

      case EditAccountPage.routeName:
        return EditAccountPage(
          data: (settings.arguments as ProfileEntity),
        );

      case MoreInfoPage.routeName:
        return MoreInfoPage();

      case ForgetPasswordPage.routeName:
        return ForgetPasswordPage();

      case ForgetPage.routeName:
        return ForgetPage();

      case CompleteInfoPage.routeName:
        return CompleteInfoPage(phoneNumber: (settings.arguments as Map<String, String>?)?['phone_number'] ?? '',);


      case OTPPage.routeName:
        return OTPPage();

      case ItemsDetailsPage.routeName:
        return ItemsDetailsPage(
          args: (settings.arguments as ItemsArgs),
        );

      case LookingForDetailsPage.routeName:
        return LookingForDetailsPage(
          args: (settings.arguments as ItemsArgs),
        );

      // case AppPdfViewer.routeName:
      //   return AppPdfViewer(
      //     document: args as PDFDocument,
      //   );
      case OnBoardingPage.routeName:
        return OnBoardingPage();

      case SelectCityPage.routeName:
        return SelectCityPage();

      case ChatsPage.routeName:
        return ChatsPage();

      case ChangePasswordPage.routeName:
        return ChangePasswordPage();
      case SelectListingPage.routeName:
        return SelectListingPage(
          dataMap: (settings.arguments as Map<String, dynamic>),
        );

      case SafetyPage.routeName:
        return SafetyPage(
          dataMap: (settings.arguments as ArgumentPolicy),
        );

      case AddDetailsPage.routeName:
        return AddDetailsPage(
          dataMap: (settings.arguments as Map<String, dynamic>),
        );

      case AddMainDetailsPage.routeName:
        return AddMainDetailsPage(
          argumentCategory: (settings.arguments as ArgumentCategory),
        );

      case ChooseRightCategoryPage.routeName:
        return ChooseRightCategoryPage(
          argumentCategory: (settings.arguments as ArgumentCategory),
        );

      case SendOtpPage.routeName:
        return SendOtpPage(
          phoneNumber: (settings.arguments as Map<String, dynamic>?)?['phone_number'] ?? '',
          isChangePassword: (settings.arguments as Map<String, dynamic>?)?['is_change_password'] ?? false,
        );
      case ChangePasswordPageNew.routeName:
        return ChangePasswordPageNew(
          phoneNumber: (settings.arguments as Map<String, dynamic>?)?['phone_number'] ?? '',
        );

      default:
        // settings = settings.copyWith(name: DefaultRoute.routeName);
        return DefaultRoute();
    }
  }
}

class DefaultRoute extends StatelessWidget {
  static const routeName = '/DefaultRoute';

  const DefaultRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
