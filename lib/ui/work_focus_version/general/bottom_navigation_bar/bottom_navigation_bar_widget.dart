import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wadeema/core/utils/app_general_utils.dart';
import 'package:wadeema/ui/work_focus_version/ads/pages/choose_listing_page.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/di/di_manager.dart';
import '../../chat/pages/chats_page.dart';
import '../../home/pages/home_page.dart';
import '../../home/pages/my_favourite_page.dart';
import '../../profile/pages/my_profile_page.dart';

class bottomNavigationBarWidget extends StatefulWidget {
  const bottomNavigationBarWidget({Key? key, required this.indexPage}) : super(key: key);
  final int indexPage;

  @override
  State<bottomNavigationBarWidget> createState() =>
      _bottomNavigationBarWidgetState();
}

class _bottomNavigationBarWidgetState extends State<bottomNavigationBarWidget>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  var token;

  @override
  bool get wantKeepAlive => true;

  late double widthC, heightC;
  PageStorageKey homeKey = PageStorageKey('HomePage');
  PageStorageKey chatKey = PageStorageKey('ChatPage');
  PageStorageKey adsKey = PageStorageKey('AdsPage');
  PageStorageKey favouriteKey = PageStorageKey('FavouritePage');
  PageStorageKey settingKey = PageStorageKey('SettingPage');

   late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 5,
      vsync: this,
    );
    tabController.addListener(_handleTabSelection);
  }

  _handleTabSelection() {
    setState(() {
      _currentIndex = tabController.index;
    });
  }
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
int indexPage = 0;
int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    PagesEnum pagesEnum;
    print(_currentIndex);
    return Padding(
      padding:
          EdgeInsets.only(left: 30.sp, right: 30.sp, bottom: 7.sp, top: 5.sp),
      child: Stack(
        children: <Widget>[
          Container(
            height: 40.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimens.containerBorderRadius),
              ),
              border: Border.all(
                  color: AppColorsController().borderColor, width: 0.2.sp),
              color: AppColorsController().white,
            ),
            padding: EdgeInsets.only(left: 2.sp, right: 2.sp, top: 2.sp),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 30.sp,
                    child: TabBar(
                      controller: tabController,
                      indicatorWeight: 0.1,
                      indicatorColor: AppColorsController().black,
                      indicatorPadding: EdgeInsets.all(0.0),
                      labelPadding: EdgeInsets.all(0.0),
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: <Widget>[
                        InkWell(
                          onTap: () {
                        if(widget.indexPage!=0){
                          DIManager.findNavigator().pushReplacementNamed(
                            HomePage.routeName,
                            arguments: homeKey,
                          );

                        }

                                          },
                          child: _buildTabItem(
                             indexPage: _currentIndex,
                              text: "",
                              iconPath: AppAssets.homeIcons,
                              page: PagesEnum.PAGE_1),
                        ),
                        InkWell(
                          onTap: () {
                            if(widget.indexPage!=1){
                              if (!AppUtils.checkIfGuest(context)) {
                                DIManager.findNavigator().pushReplacementNamed(
                                  ChatsPage.routeName,
                                  // arguments: chatKey,
                                );
                              }

                            }


                          },
                          child: _buildTabItem(indexPage: _currentIndex,
                              text: "",
                              iconPath: AppAssets.messengerIcons,
                              page: PagesEnum.PAGE_2),
                        ),
                        InkWell(
                          onTap: () {
                            if(widget.indexPage!=2){
                              if (!AppUtils.checkIfGuest(context)) {
                                DIManager.findNavigator().pushReplacementNamed(
                                    SelectListingPage.routeName,
                                    arguments: {'city_id': -1});
                              }

                            }

                          },
                          child: _buildTabItem(indexPage: _currentIndex,
                              text: "",
                              iconPath: AppAssets.addIcons,
                              page: PagesEnum.PAGE_3),
                        ),
                        InkWell(
                          onTap: () {
                            if(widget.indexPage!=3){
                              if (!AppUtils.checkIfGuest(context)) {
                                DIManager.findNavigator().pushReplacementNamed(
                                  MyFavouritePage.routeName,
                                  // arguments: favouriteKey
                                );
                              }

                            }

                          },
                          child: _buildTabItem(indexPage: _currentIndex,
                              text: "",
                              iconPath: AppAssets.favouritesIcons,
                              page: PagesEnum.PAGE_4),
                        ),
                        InkWell(
                          onTap: () {
                            if(widget.indexPage!=4){
                              DIManager.findNavigator().pushReplacementNamed(
                                MyProfilePage.routeName,
                                // arguments: settingKey
                              );

                            }


                          },
                          child: _buildTabItem(indexPage: _currentIndex,
                              text: "",
                              iconPath: AppAssets.menuIcons,
                              page: PagesEnum.PAGE_5),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(
      {required String text,
      required String? iconPath,
      required PagesEnum page,
      required int indexPage,
      Color? svgColor,
      double? iconSize}) {
    bool isSelected = (page.index ==widget.indexPage);

    return isSelected
        ? AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: 40.sp,
      height: 30.sp,
      decoration: BoxDecoration(color: Colors.transparent),
      child: Column(
        children: [
          Container(
            height: 26.sp,
            width: 26.sp,
            decoration: BoxDecoration(color: Colors.transparent),
            child: SvgPicture.asset(
              iconPath!,
              color: AppColorsController().iconColor,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            height: 1.sp,
            width: 30.sp,
            decoration: BoxDecoration(color: Colors.black),

          ),
        ],
      ),
    )
        : AnimatedContainer(
            duration: Duration(milliseconds: 500),
            width: 40.sp,
            height: 30.sp,
            decoration: BoxDecoration(color: Colors.transparent),
            child: Column(
              children: [
                Container(
                  height: 26.sp,
                  width: 26.sp,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: SvgPicture.asset(
                    iconPath!,
                    color: AppColorsController().iconColor,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          );
  }
}

enum PagesEnum {
  PAGE_1,
  PAGE_2,
  PAGE_3,
  PAGE_4,
  PAGE_5,
}

//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../../../../core/constants/app_assets.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/constants/dimens.dart';
// import '../../../../core/di/di_manager.dart';
// import '../../../../core/shared_prefs/shared_prefs.dart';
// import '../../../../core/utils/localization/app_localizations.dart';
// import '../../ads/pages/select_city_page.dart';
// import '../../chat/pages/chats_page.dart';
// import '../../home/pages/home_page.dart';
// import '../../home/pages/my_favourite_page.dart';
// import '../../profile/pages/my_profile_page.dart';

// class bottomNavigationBarWidget extends StatefulWidget {
//   final Function(int)? onTap;
//   final int? selectedIndex;
//
//   bottomNavigationBarWidget({Key? key,this.onTap,this.selectedIndex}) : super(key: key);
//
//   @override
//   State<bottomNavigationBarWidget> createState() =>
//       _bottomNavigationBarWidgetState();
// }

// class _bottomNavigationBarWidgetState extends State<bottomNavigationBarWidget>
//     with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
//   var token;
//   final homeKey = PageStorageKey('home');
//   final messageKey = PageStorageKey('message');
//
//   @override
//   bool get wantKeepAlive => true;
//
//   late double widthC, heightC;
//
//   static late TabController tabController;
//
//   int _selectedIndex = 0;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: 5, vsync: this);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       color: AppColorsController().white,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 42.sp),
//         child: Container(
//           padding: EdgeInsets.all(4.sp),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(
//               Radius.circular(Dimens.containerBorderRadius),
//             ),
//             border: Border.all(color: AppColorsController().black, width: 0.2),
//             color: AppColorsController().white,
//           ),
//           child: Material(
//             color: AppColorsController().white,
//             child: Stack(
//               children: <Widget>[
//                 Container(
//                   color: AppColorsController().white,
//                   padding: EdgeInsets.only(left: 2.sp, right: 2.sp, top: 2.sp),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           height: 30.sp,
//                           child: TabBar(
//                             controller: tabController,
//                             indicatorWeight: 0.1,
//                             indicatorColor: AppColorsController().black,
//                             indicatorPadding: EdgeInsets.all(0.0),
//                             labelPadding: EdgeInsets.all(0.0),
//                             indicatorSize: TabBarIndicatorSize.label,
//                             tabs: <Widget>[
//                               InkWell(
//                                 onTap: () {
//
//                                   widget.onTap!(0);
//
//                                   // DIManager.findNavigator().pushNamed(
//                                   //   HomePage.routeName,
//                                   //   arguments: homeKey,
//                                   // );
//                                   // Navigator.of(context)
//                                   //     .pushNamedAndRemoveUntil(Routes.homePage,(route) => false,)
//                                   //     .then((value) => {
//                                   //             tabController.index = 0
//                                   //         });
//                                 },
//                                 child: _buildTabItem(
//                                     text: "",
//                                     iconPath: AppAssets.homeIcons,
//                                     page: PagesEnum.PAGE_1),
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   if (DIManager.findDep<SharedPrefs>()
//                                       .getToken() !=
//                                       null &&
//                                       DIManager.findDep<SharedPrefs>()
//                                           .getToken()!
//                                           .isNotEmpty) {
//                                     widget.onTap!(1);
//                                     // DIManager.findNavigator().pushNamed(
//                                     //   ChatsPage.routeName,
//                                     //   arguments: homeKey,
//                                     //
//                                     // );
//                                   } else {
//                                     var snackBar = SnackBar(
//                                       content:
//                                       Text(translate('you_should_sign_in')),
//                                       behavior: SnackBarBehavior.floating,
//                                       duration: Duration(seconds: 1),
//                                     );
//                                     ScaffoldMessenger.of(context)
//                                         .showSnackBar(snackBar);
//                                   }
//                                 },
//                                 child: _buildTabItem(
//                                     text: "",
//                                     iconPath: AppAssets.messengerIcons,
//                                     page: PagesEnum.PAGE_2),
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   if (DIManager.findDep<SharedPrefs>()
//                                       .getToken() !=
//                                       null &&
//                                       DIManager.findDep<SharedPrefs>()
//                                           .getToken()!
//                                           .isNotEmpty) {
//                                     DIManager.findNavigator().pushNamed(
//                                       SelectCityPage.routeName,
//                                     );
//                                   } else {
//                                     var snackBar = SnackBar(
//                                       content:
//                                       Text(translate('you_should_sign_in')),
//                                       behavior: SnackBarBehavior.floating,
//                                       duration: Duration(seconds: 1),
//                                     );
//                                     ScaffoldMessenger.of(context)
//                                         .showSnackBar(snackBar);
//                                   }
//                                 },
//                                 child: _buildTabItem(
//                                     text: "",
//                                     iconPath: AppAssets.addIcons,
//                                     page: PagesEnum.PAGE_3),
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   if (DIManager.findDep<SharedPrefs>()
//                                       .getToken() !=
//                                       null &&
//                                       DIManager.findDep<SharedPrefs>()
//                                           .getToken()!
//                                           .isNotEmpty) {
//
//                                     DIManager.findNavigator().pushNamed(
//                                       MyFavouritePage.routeName,
//                                     );
//                                   }
//                                   else{
//                                     var snackBar = SnackBar(
//                                       content: Text(translate('you_should_sign_in')),
//                                       behavior: SnackBarBehavior.floating,
//                                       duration: Duration(seconds: 1),
//                                     );
//                                     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                                   }
//
//                                 },
//                                 child: _buildTabItem(
//                                     text: "",
//                                     iconPath: AppAssets.favouritesIcons,
//                                     page: PagesEnum.PAGE_4),
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   DIManager.findNavigator().pushNamed(
//                                     MyProfilePage.routeName,
//                                   );
//                                   // Navigator.of(context)
//                                   //     .pushNamedAndRemoveUntil(Routes.myProfilePage,(route) => false,)
//                                   //     .then((value) => {
//                                   //             tabController.index = 2
//                                   //         });
//                                 },
//                                 child: _buildTabItem(
//                                     text: "",
//                                     iconPath: AppAssets.menuIcons,
//                                     page: PagesEnum.PAGE_5),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTabItem(
//       {required String text,
//         required String? iconPath,
//         required PagesEnum page,
//         Color? svgColor,
//         double? iconSize}) {
//     bool isSelected = (page.index == tabController.index);
//
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 500),
//       width: 40,
//       height: 30,
//       decoration: BoxDecoration(
//           color: Colors.transparent
//       ),
//       child: Column(
//         children: [
//           Container(
//             height: 26.sp,
//             width: 26.sp,
//             decoration: BoxDecoration(
//                 color: Colors.transparent
//             ),
//             child: SvgPicture.asset(
//               iconPath!,
//               color: AppColorsController().iconColor,
//
//               fit: BoxFit.fill,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// enum PagesEnum {
//   PAGE_1,
//   PAGE_2,
//   PAGE_3,
//   PAGE_4,
//   PAGE_5,
// }
