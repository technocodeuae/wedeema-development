// import 'package:faker/faker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../core/di/di_manager.dart';
// import 'package:get/get.dart';
// import '../../../../blocs/application/application_bloc.dart';
// import '../../../../blocs/application/states/application_state.dart';
// import '../../../../core/constants/app_assets.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/constants/app_style.dart';
// import '../../../../core/constants/duration_consts.dart';
// import '../../../../core/utils/screen_utils/device_utils.dart';
// import '../../../../core/utils/ui/loader/app_hud_widget.dart';
// import '../../../../core/utils/ui/widgets/images/svg_image_asset.dart';
// import '../../../../core/utils/ui/widgets/utils/horizontal_padding.dart';
// import '../../../../ui/work_focus_version/general/app_animations.dart';
//
//
//
// class RootPage extends StatefulWidget {
//   static const String routeName = '/RootPage';
//
//   const RootPage();
//
//   @override
//   _RootPageState createState() => _RootPageState();
// }
//
// class _RootPageState extends State<RootPage>
//     with SingleTickerProviderStateMixin {
//   final kBigCircleRadius = ScreenHelper.fromWidth55(70);
//   final Duration _animationDuration = Duration(milliseconds: 400);
//
//   late TabController _tabController;
//
//   bool _isOpened = false;
//
//   bool get _getFABVisiblity =>
//       _tabController.index == 0 || _tabController.index == 4;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = Get.put(TabController(length: 5, vsync: this));
//     _tabController.addListener(() {
//       if (mounted) setState(() {});
//       if (_tabController.index != 0) {
//         DIManager.findAC().isBottomBarShowed(false);
//       } else {
//         DIManager.findAC().isBottomBarShowed(true);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () {
//         if (_tabController.index != 0) {
//           _onBackPressed();
//           return Future.value(false);
//         }
//         return Future.value(true);
//       },
//       child: Scaffold(
//         backgroundColor:
//         DIManager.findDep<AppColorsController>().scaffoldBGColor,
//         body: Container(
//           height: 1.sh,
//           child: Stack(
//             children: [
//               LoadingOverlayWidget(
//                 isLoading: _isOpened,
//                 child: TabBarView(
//                   controller: _tabController,
//                   physics: const NeverScrollableScrollPhysics(),
//                   children: [
//                     Container(),
//
//                   ],
//                 ),
//               ),
//               _buildBottomNavigationBar(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBottomNavigationBar() {
//     List<Widget> _tabs = [
//       _buildTapItem(PagesEnum.HOME_PAGE),
//       _buildTapItem(PagesEnum.FOCUS_MODE),
//       //Container(),
//       _buildTapItem(PagesEnum.SERVICES_PAGE),
//       _buildTapItem(PagesEnum.INBOX_PAGE),
//       _buildTapItem(PagesEnum.TASK_PAGE),
//     ];
//
//     return BlocBuilder<ApplicationCubit, ApplicationState>(
//       bloc: DIManager.findDep<ApplicationCubit>(),
//       builder: (context, appState) {
//         final isBottomBarShowed =
//             !appState.isHomeDrawerOpened && appState.isBottomBarShowed;
//         final isAddPostFABShowed =
//             appState.isSideDrawerShowed && !appState.isHomeDrawerOpened;
//         return Container(
//           width: ScreenHelper.width55,
//           alignment: Alignment.bottomCenter,
//           height: 1.sh,
//           // color: Colors.red.withOpacity(0.1),
//           child: Stack(
//             alignment: Alignment.center,
//             fit: StackFit.expand,
//             children: [
//               AnimatedPositioned(
//                 bottom: isBottomBarShowed ? 101 : 25.0,
//                 duration: Duration(
//                   milliseconds: DurationConsts.SHORT_ANIMATION_DURATION,
//                 ),
//                 child: Container(
//                   width: 1.sw,
//                   child: AnimatedSwitcher(
//                     duration: Duration(
//                       milliseconds: DurationConsts.SHORT_ANIMATION_DURATION,
//                     ),
//                     child: isAddPostFABShowed && _getFABVisiblity
//                         ? Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               HorizontalPadding(4),
//                               OpenContainerWrapper(
//                                 closedShape: const RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(24.0)),
//                                 ),
//                                 closedBuilder: (void Function() openBuilder) {
//                                   return FloatingActionButton(
//                                     heroTag: faker.guid.guid(),
//                                     materialTapTargetSize:
//                                         MaterialTapTargetSize.shrinkWrap,
//                                     backgroundColor:
//                                         DIManager.findDep<AppColorsController>()
//                                             .primaryColor,
//                                     onPressed: openBuilder,
//                                     child: Icon(
//                                       Icons.add,
//                                       color: Colors.white,
//                                       size: ScreenHelper.fromWidth55(6.5),
//                                     ),
//                                   );
//                                 },
//                                 openBuilder: (void Function() closedBuilder) {
//
//                                   return Container();
//                                 },
//                               ),
//                               HorizontalPadding(4)
//                             ],
//                           )
//                         : Container(),
//                   ),
//                 ),
//               ),
//               AnimatedPositioned(
//                 bottom: isBottomBarShowed ? 25 : -25.0,
//                 duration: Duration(
//                     milliseconds: DurationConsts.MIN_SHORT_ANIMATION_DURATION),
//                 child: AnimatedOpacity(
//                   opacity: isBottomBarShowed ? 1.0 : 0.0,
//                   duration: Duration(
//                     milliseconds: DurationConsts.MIN_SHORT_ANIMATION_DURATION,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         width: ScreenHelper.width55! * 0.92,
//                         height: 0.065.sh,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(1000),
//                           boxShadow: [AppStyle.normalShadow],
//                         ),
//                         child: TabBar(
//                           controller: _tabController,
//                           tabs: _tabs,
//                           labelColor: Colors.transparent,
//                           indicatorColor: Colors.transparent,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildTapItem(PagesEnum page) {
//     bool isSelected = (page.index == _tabController.index);
//     final iconColor = isSelected
//         ? DIManager.findDep<AppColorsController>().primaryColor
//         : DIManager.findDep<AppColorsController>().notSelectedGrey;
//     Widget? icon;
//     switch (page) {
//       // case PagesEnum.HOME_PAGE:
//       //   icon = AnimatedContainer(
//       //     duration: _animationDuration,
//       //     width: ScreenHelper.fromWidth55(isSelected ? 7.0 : 6.5),
//       //     child: Image.asset(
//       //       (isSelected
//       //           ? AppAssets.home_icon
//       //           : AppAssets.home_not_selected_icon),
//       //       color: iconColor,
//       //       width: ScreenHelper.fromWidth55(7),
//       //     ),
//       //   );
//       //   break;
//
//
//
//
//       case PagesEnum.EMPTY:
//         throw Exception('not allowed');
//     }
//
//     return InkWell(
//       onTap: () {
//         if (page == PagesEnum.FOCUS_MODE) {
//           DIManager.findNavigator().pop();
//           return;
//         }
//         _tabController.index = page.index;
//         setState(() {});
//       },
//       child: Container(
//         width: ScreenHelper.fromWidth55(17.5),
//         child: Center(
//           child: Container(
//             child: icon,
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _onBackPressed() {
//     _tabController.animateTo(0);
//   }
// }
//
// enum PagesEnum {
//   HOME_PAGE,
//   FOCUS_MODE,
//   SERVICES_PAGE,
//   INBOX_PAGE,
//   TASK_PAGE,
//   EMPTY,
// }
//
// class SlideToast extends StatefulWidget {
//   final Widget _toast;
//
//   SlideToast(this._toast);
//
//   @override
//   _SlideToastState createState() => _SlideToastState();
// }
//
// class _SlideToastState extends State<SlideToast> with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _offsetFloat;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 350),
//     );
//
//     _offsetFloat = Tween(begin: Offset(0.0, -0.03), end: Offset.zero).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.fastOutSlowIn,
//       ),
//     );
//
//     _offsetFloat.addListener(() {
//       setState(() {});
//     });
//
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SlideTransition(
//       position: _offsetFloat,
//       child: widget._toast,
//     );
//   }
// }
