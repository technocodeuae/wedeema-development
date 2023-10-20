import 'package:flutter/material.dart';
import 'package:wadeema/ui/work_focus_version/auth/pages/forget_pasword_page.dart';
import 'package:wadeema/ui/work_focus_version/tour/tour_page.dart';

import '../../../../blocs/application/application_bloc.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/ui/bottom_sheet/custom_bottom_sheetts.dart';
import '../../../../core/utils/ui/dialogs/custom_dialogs.dart';
import '../../../../ui/work_focus_version/splash/pages/splash_page.dart';
import '../../ui/address/map/pages/map_page.dart';
import '../../ui/work_focus_version/ads/pages/add_details_page.dart';
import '../../ui/work_focus_version/ads/pages/add_main_details_page.dart';
import '../../ui/work_focus_version/ads/pages/choose_listing_page.dart';
import '../../ui/work_focus_version/ads/pages/choose_right_category_page.dart';
import '../../ui/work_focus_version/ads/pages/safety_page.dart';
import '../../ui/work_focus_version/ads/pages/select_city_page.dart';
import '../../ui/work_focus_version/auth/pages/forget_password_page_old.dart';
import '../../ui/work_focus_version/auth/pages/otp_page.dart';
import '../../ui/work_focus_version/auth/pages/send_otp_page.dart';
import '../../ui/work_focus_version/auth/pages/sign_in_page.dart';
import '../../ui/work_focus_version/auth/pages/sign_in_with_phone_number.dart';
import '../../ui/work_focus_version/auth/pages/sign_up_page.dart';
import '../../ui/work_focus_version/chat/pages/chat_messages_page.dart';
import '../../ui/work_focus_version/chat/pages/chats_page.dart';
import '../../ui/work_focus_version/home/pages/home_page.dart';
import '../../ui/work_focus_version/home/pages/items_details_page.dart';
import '../../ui/work_focus_version/home/pages/looking_for_details_page.dart';
import '../../ui/work_focus_version/home/pages/search_page.dart';
import '../../ui/work_focus_version/home/pages/view_all_page.dart';
import '../../ui/work_focus_version/profile/pages/client_account_page.dart';
import '../../ui/work_focus_version/profile/pages/edit_account_page.dart';
import '../../ui/work_focus_version/profile/pages/more_info_page.dart';
import '../../ui/work_focus_version/profile/pages/my_account_page.dart';
import '../../ui/work_focus_version/profile/pages/my_profile_page.dart';

class AppNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('This is never get called didPush $route | $previousRoute');
    if (

        /// route.settings.name == null when popupMenu is clicked
        route.settings.name == null ||
            route.settings.name == CustomBottomSheets.routeName ||
            // route is SnackRoute ||
            route.settings.name == CustomDialogs.addNewTaskDialogRouteName ||
            route.settings.name == SignInPage.routeName ||
            route.settings.name == SignUpPage.routeName ||
            route.settings.name == SearchPage.routeName ||
            route.settings.name == ForgetPasswordPage.routeName ||
            route.settings.name == MapPage.routeName ||
            route.settings.name == OTPPage.routeName ||
            route.settings.name == SignInWithPhoneNumber.routeName ||
            route.settings.name == SelectCityPage.routeName ||
            route.settings.name == SelectListingPage.routeName ||
            route.settings.name == AddDetailsPage.routeName ||
            route.settings.name == AddMainDetailsPage.routeName ||
            route.settings.name == ChooseRightCategoryPage.routeName ||
            route.settings.name == SafetyPage.routeName ||
            route.settings.name == HomePage.routeName ||
            route.settings.name == ViewAllPage.routeName ||
            route.settings.name == ClientAccountPage.routeName ||
            route.settings.name == MyProfilePage.routeName ||
            route.settings.name == MyAccountPage.routeName ||
            route.settings.name == EditAccountPage.routeName ||
            route.settings.name == MoreInfoPage.routeName ||
            route.settings.name == ItemsDetailsPage.routeName ||
            route.settings.name == LookingForDetailsPage.routeName ||
            route.settings.name == ChatsPage.routeName ||
            route.settings.name == ChatMessagesPage.routeName ||
            route.settings.name == SendOtpPage.routeName ||
            route.settings.name == SignUpPage.routeName ||
            route.settings.name == TourPage.routeName ||
            route.settings.name == SplashPage.routeName) {
      DIManager.findDep<ApplicationCubit>().setSideDrawer(false);
    } else {
      DIManager.findDep<ApplicationCubit>().setSideDrawer(true);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('This is never get called didPop $route | $previousRoute');
    if ( //route.settings.name == MetroPage.routeName ||
        /// route.settings.name == null when popupMenu is clicked
        route.settings.name == null ||


            route.settings.name == SplashPage.routeName ||
            route.settings.name == HomePage.routeName ||
            route.settings.name == SearchPage.routeName ||
            route.settings.name == ViewAllPage.routeName ||
            route.settings.name == ClientAccountPage.routeName ||
            route.settings.name == MyProfilePage.routeName ||
            route.settings.name == MyAccountPage.routeName ||
            route.settings.name == EditAccountPage.routeName ||
            route.settings.name == MoreInfoPage.routeName ||
            route.settings.name == ItemsDetailsPage.routeName ||
            route.settings.name == LookingForDetailsPage.routeName ||
            route.settings.name == SignUpPage.routeName ||
            route.settings.name == SignInPage.routeName ||
            route.settings.name == SignInWithPhoneNumber.routeName ||
            route.settings.name == ForgetPasswordPage.routeName ||
            route.settings.name == ForgetPage.routeName ||
            route.settings.name == MapPage.routeName ||
            route.settings.name == OTPPage.routeName||
            route.settings.name == SelectCityPage.routeName||
            route.settings.name == SelectListingPage.routeName||
            route.settings.name == AddDetailsPage.routeName ||
            route.settings.name == AddMainDetailsPage.routeName ||
            route.settings.name == ChooseRightCategoryPage.routeName ||
            route.settings.name == ChatsPage.routeName ||
            route.settings.name == ChatMessagesPage.routeName ||

            route.settings.name == SafetyPage.routeName ||
            route.settings.name == SignUpPage.routeName ||
            route.settings.name == SendOtpPage.routeName ||
            route.settings.name == TourPage.routeName


        ) {
      DIManager.findDep<ApplicationCubit>().setSideDrawer(false);
    } else {
      DIManager.findDep<ApplicationCubit>().setSideDrawer(true);
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    print('This is never get called didRemove $route | $previousRoute');
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    print('This is never get called didReplace $newRoute | $oldRoute');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    print(
        'This is never get called didStartUserGesture $route | $previousRoute');
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    print('This is never get called didStopUserGesture');
    super.didStopUserGesture();
  }
}
