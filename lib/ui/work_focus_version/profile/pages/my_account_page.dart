import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/dimens.dart';
import 'package:wadeema/data/models/profile/entity/profile_entity.dart';
import 'package:wadeema/ui/work_focus_version/general/buttons/app_button.dart';
import '../../../../blocs/profile/profile_bloc.dart';
import '../../../../blocs/profile/states/profile_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/widgets/general_error_widget.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '../../general/icons/back_icon.dart';

import '../../general/progress_indicator/loading_column_overlay.dart';
import '../widget/image_profile_widget.dart';
import 'edit_account_page.dart';
import 'follow_follower_block_user_page.dart';
import 'more_info_page.dart';

class MyAccountPage extends StatefulWidget {
  static const routeName = '/MyAccountPage';

  const MyAccountPage({Key? key}) : super(key: key);

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  final profileBloc = DIManager.findDep<ProfileCubit>();

  bool loading = false;

  bool seeMore = true;
  bool _isLoader = false;
  bool isPressure = false;

  ProfileEntity? data;

  @override
  void initState() {
    profileBloc.getProfile();
    loading = true;
    _isLoader = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsController().card.withOpacity(0.8),
      body: SafeArea(
        child: LoadingColumnOverlay(
          isLoading: _isLoader,
          child: BackLongPress(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppBarWidget(
                    name: translate("my_profile"),
                    child: InkWell(
                      onTap: () {
                        DIManager.findNavigator().pop();
                      },
                      child: BackIcon(
                        width: 26.sp,
                        height: 18.sp,
                        color: AppColorsController().iconColor,
                      ),
                    ),
                  ),
                  BlocConsumer<ProfileCubit, ProfileState>(
                      bloc: profileBloc,
                      listener: (_, state) {
                        setState(() {
                          _isLoader = false;
                        });
                      },
                      builder: (context, state) {
                        final getProfileState = state.getProfileState;

                        if (getProfileState is BaseFailState) {
                          return Column(
                            children: [
                              VerticalPadding(3.0),
                              GeneralErrorWidget(
                                error: getProfileState.error,
                                callback: getProfileState.callback,
                              ),
                            ],
                          );
                        }

                        if (loading == true &&
                            getProfileState is GetProfileSuccessState) {
                          loading = false;
                          data =
                              (state.getProfileState as GetProfileSuccessState)
                                  .profile;
                          return _buildBody();
                        }
                        return data == null ? Padding(
                          padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/3.2),
                          child: Center(child: Image.asset(
                            "assets/images/wadeema_loader.gif",
                            height: 125.0,
                            width: 125.0,
                          )),
                        ) : _buildBody();
                      }),
                  seeMore == true ? MoreInfoPage() : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: bottomNavigationBarWidget(),
    );
  }

  _buildBody() {
    String apiDate = data!.user!.created_at.toString();
    DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(apiDate);
    String parsedDate2 = DateFormat("dd/MM/yyyy").format(parsedDate).toString();
    final sizeWidth = MediaQuery.of(context).size.width;
    final sizeHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 20.sp),
      margin: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
      decoration: BoxDecoration(
          color: AppColorsController().containerPrimaryColor,
          border: Border.all(
            color: AppColorsController().borderColor.withOpacity(0.2),
            width: 0.3,
          ),
          borderRadius:
              BorderRadius.all(Radius.circular(Dimens.dialogBorderRadius))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: ScrollController(keepScrollOffset: false),
            child: Row(
              children: [
                SizedBox(width: 10.sp),
                ImageProfileWidget(
                  url: data?.user?.profile_pic ?? "",
                ),
                SizedBox(width: 20.sp),
                Row(
                  children: [
                    SizedBox(width: 20.sp),
                    InkWell(
                      child: Column(
                        children: [
                          Text(
                            data?.user?.following?.toString() ?? '',
                            style: AppStyle.lightSubtitle.copyWith(
                                color: AppColorsController().black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            translate("following"),
                            style: AppStyle.lightSubtitle.copyWith(
                                color: AppColorsController().black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      onTap: () {
                        DIManager.findNavigator().pushNamed(
                          FollowFollowerBlockUser.routeName,
                          arguments: 0,
                        );
                      },
                    ),
                    SizedBox(width: 30.sp),
                    InkWell(
                      onTap: () {
                        DIManager.findNavigator().pushNamed(
                          FollowFollowerBlockUser.routeName,
                          arguments: 1,
                        );
                      },
                      child: Column(
                        children: [
                          Text(
                            data?.user?.followers?.toString() ?? '',
                            style: AppStyle.lightSubtitle.copyWith(
                                color: AppColorsController().black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            translate("followers"),
                            style: AppStyle.lightSubtitle.copyWith(
                                color: AppColorsController().black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20.sp),
                    InkWell(
                      onTap: () {
                        // DIManager.findNavigator().pushNamed(
                        //   FollowFollowerBlockUser.routeName,
                        //   arguments: 1,
                        // );
                      },
                      child: Column(
                        children: [
                          Text(
                            '0',
                            style: AppStyle.lightSubtitle.copyWith(
                                color: AppColorsController().black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            translate("number_of_ads"),
                            style: AppStyle.lightSubtitle.copyWith(
                                color: AppColorsController().black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.sp,
          ),
          Text(
            data?.user?.user_name.toString() ?? '',
            style: AppStyle.smallTitleTextStyle.copyWith(
                color: AppColorsController().textPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 19),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 4.sp,
          ),
          Container(
            child: RatingBarIndicator(
              rating: data?.user?.ratings_average?.toDouble() ?? 0,
              itemCount: 5,
              itemSize: 22,
              unratedColor: AppColorsController().darkGreyTextColor,
              direction: Axis.horizontal,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                size: 18,
                color: Colors.amber,
              ),
            ),
          ),
          SizedBox(
            height: 4.sp,
          ),
          Text(
            translate("joined_on") + " " + "${parsedDate2}",
            style: AppStyle.lightSubtitle.copyWith(
                color: AppColorsController().textPrimaryColor,
                fontWeight: FontWeight.w400,
                fontSize: 15),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 4.sp,
          ),
          Text(
            translate("user_id") + " : " + (data?.user?.id?.toString() ?? ''),
            style: AppStyle.verySmallTitleStyle.copyWith(
                color: AppColorsController().black,
                fontWeight: AppFontWeight.midLight,
                fontSize: 15),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 2.sp,
          ),
          _buttonBuild(),

        ],
      ),
    );
  }

  _buttonBuild() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24.sp,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 14.sp,
          ),
          AppButton(
            buttonColor: AppColorsController().buttonRedColor,
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // EditIcon(
                //   height: 26.sp,
                //   width: 26.sp,
                // ),
                // SizedBox(
                //   width: 8.sp,
                // ),
                Text(
                  translate("edit_profile"),
                  style: AppStyle.lightSubtitle.copyWith(
                      color: AppColorsController().white,
                      fontWeight: FontWeight.w600,
                      fontSize: 19),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            onPressed: () {
              DIManager.findNavigator()
                  .pushNamed(EditAccountPage.routeName, arguments: data);
            },
          ),
          // SizedBox(
          //   height: 5.sp,
          // ),   // SizedBox(
          //   height: 5.sp,
          // ),ß
          // AppButton(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //
          //       MoreIcon(
          //         height: 26.sp,
          //         width: 26.sp,
          //       ),
          //       SizedBox(width: 8.sp,),
          //
          //       Text(
          //         translate("more"),
          //         style: AppStyle.lightSubtitle.copyWith(
          //           color: AppColorsController().black,
          //           fontWeight: FontWeight.w400,
          //         ),
          //         maxLines: 2,
          //         overflow: TextOverflow.ellipsis,
          //       ),
          //
          //
          //
          //     ],
          //   ),
          //   onPressed: () {
          //    setState(() {
          //      seeMore = !seeMore;
          //    });
          //   },
          // ),
        ],
      ),
    );
  }

  //
  // _buildBodyFromAccount() {
  //   String apiDate = data!.user!.created_at.toString();
  //   DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(apiDate);
  //   String parsedDate2 = DateFormat("dd/MM/yyyy").format(parsedDate).toString();
  //   final sizeWidth = MediaQuery.of(context).size.width;
  //   final sizeHeight = MediaQuery.of(context).size.height;
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 20.sp),
  //     margin: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
  //     decoration: BoxDecoration(
  //         color: AppColorsController().containerPrimaryColor,
  //         border: Border.all(
  //           color: AppColorsController().borderColor.withOpacity(0.2),
  //           width: 0.3,
  //         ),
  //         borderRadius:
  //         BorderRadius.all(Radius.circular(Dimens.dialogBorderRadius))),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         SingleChildScrollView(
  //           scrollDirection: Axis.horizontal,
  //           controller: ScrollController(keepScrollOffset: false),
  //           child: Row(
  //             children: [
  //               SizedBox(width: 10.sp),
  //               ImageProfileWidget(
  //                 url: data?.user?.profile_pic ?? "",
  //               ),
  //               SizedBox(width: 20.sp),
  //               Row(
  //                 children: [
  //                   SizedBox(width: 20.sp),
  //                   InkWell(
  //                     child: Column(
  //                       children: [
  //                         Text(
  //                           data?.user?.following?.toString() ?? '',
  //                           style: AppStyle.lightSubtitle.copyWith(
  //                               color: AppColorsController().black,
  //                               fontWeight: FontWeight.w400,
  //                               fontSize: AppFontSize.fontSize_14),
  //                           maxLines: 2,
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                         Text(
  //                           translate("following"),
  //                           style: AppStyle.lightSubtitle.copyWith(
  //                               color: AppColorsController().black,
  //                               fontWeight: FontWeight.w400,
  //                               fontSize: 14),
  //                           maxLines: 2,
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                       ],
  //                     ),
  //                     onTap: () {
  //                       DIManager.findNavigator().pushNamed(
  //                         FollowFollowerBlockUser.routeName,
  //                         arguments: 1,
  //                       );
  //                     },
  //                   ),
  //                   SizedBox(width: 30.sp),
  //                   InkWell(
  //                     onTap: () {
  //                       if (currentUserId == widget.userId) {
  //                         DIManager.findNavigator().pushNamed(
  //                           FollowFollowerBlockUser.routeName,
  //                           arguments: 0,
  //                         );
  //                       }
  //                     },
  //                     child: Column(
  //                       children: [
  //                         Text(
  //                           data?.user?.followers?.toString() ?? '',
  //                           style: AppStyle.lightSubtitle.copyWith(
  //                               color: AppColorsController().black,
  //                               fontWeight: FontWeight.w400,
  //                               fontSize: AppFontSize.fontSize_14),
  //                           maxLines: 2,
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                         Text(
  //                           translate("followers"),
  //                           style: AppStyle.lightSubtitle.copyWith(
  //                               color: AppColorsController().black,
  //                               fontWeight: FontWeight.w400,
  //                               fontSize: AppFontSize.fontSize_14),
  //                           maxLines: 2,
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(width: 20.sp),
  //                   InkWell(
  //                     onTap: () {
  //                       // DIManager.findNavigator().pushNamed(
  //                       //   FollowFollowerBlockUser.routeName,
  //                       //   arguments: 1,
  //                       // );
  //                     },
  //                     child: Column(
  //                       children: [
  //                         Text(
  //                           '0',
  //                           style: AppStyle.lightSubtitle.copyWith(
  //                               color: AppColorsController().black,
  //                               fontWeight: FontWeight.w400,
  //                               fontSize: 14),
  //                           maxLines: 2,
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                         Text(
  //                           translate("number_of_ads"),
  //                           style: AppStyle.lightSubtitle.copyWith(
  //                               color: AppColorsController().black,
  //                               fontWeight: FontWeight.w400,
  //                               fontSize: 14),
  //                           maxLines: 2,
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           height: 10.sp,
  //         ),
  //         Text(
  //           translate("user_id") + " : " + (data?.user?.id?.toString() ?? ''),
  //           style: AppStyle.verySmallTitleStyle.copyWith(
  //             color: AppColorsController().black,
  //             fontWeight: AppFontWeight.midLight,
  //           ),
  //           maxLines: 2,
  //           overflow: TextOverflow.ellipsis,
  //         ),
  //         SizedBox(
  //           height: 4.sp,
  //         ),
  //         Row( mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             currentUserId != widget.userId
  //                 ? EvaluateUserButtonWidget(
  //               userId: widget.userId,
  //               onChanged: _onChanged,
  //             )
  //                 : Container(),
  //             SizedBox(
  //               width: 8.sp,
  //             ),
  //             Container(
  //               child: RatingBarIndicator(
  //                 rating: data?.user?.ratings_average?.toDouble() ?? 0,
  //                 itemCount: 5,
  //                 itemSize: 22,
  //                 unratedColor: AppColorsController().darkGreyTextColor,
  //                 direction: Axis.horizontal,
  //                 itemBuilder: (context, _) => Icon(
  //                   Icons.star,
  //                   size: 18,
  //                   color: Colors.amber,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 4.sp,
  //         ),
  //         Text(
  //           translate("joined_on") + " " + data!.user!.created_at.toString(),
  //           style: AppStyle.lightSubtitle.copyWith(
  //               color: AppColorsController().textPrimaryColor,
  //               fontWeight: FontWeight.w400,
  //               fontSize: 15),
  //           maxLines: 2,
  //           overflow: TextOverflow.ellipsis,
  //         ),
  //         SizedBox(
  //           height: 4.sp,
  //         ),
  //         currentUserId != widget.userId
  //             ? FollowButtonWidget(
  //           isFollow: data?.is_follow??false,
  //           userId: widget.userId,
  //           onChanged: _onChanged,
  //         )
  //             : Container(),
  //       ],
  //     ),
  //   );
  // }
  //
  // _buildBodyFromAccount() {
  //   String apiDate = data!.user!.created_at.toString();
  //   DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(apiDate);
  //   String parsedDate2 = DateFormat("dd/MM/yyyy").format(parsedDate).toString();
  //   final sizeWidth = MediaQuery.of(context).size.width;
  //   final sizeHeight = MediaQuery.of(context).size.height;
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 20.sp),
  //     margin: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
  //     decoration: BoxDecoration(
  //         color: AppColorsController().containerPrimaryColor,
  //         border: Border.all(
  //           color: AppColorsController().borderColor.withOpacity(0.2),
  //           width: 0.3,
  //         ),
  //         borderRadius:
  //         BorderRadius.all(Radius.circular(Dimens.dialogBorderRadius))),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         SingleChildScrollView(
  //           scrollDirection: Axis.horizontal,
  //           controller: ScrollController(keepScrollOffset: false),
  //           child: Row(
  //             children: [
  //               SizedBox(width: 10.sp),
  //               ImageProfileWidget(
  //                 url: data?.user?.profile_pic ?? "",
  //               ),
  //               SizedBox(width: 20.sp),
  //               Row(
  //                 children: [
  //                   SizedBox(width: 20.sp),
  //                   InkWell(
  //                     child: Column(
  //                       children: [
  //                         Text(
  //                           data?.user?.following?.toString() ?? '',
  //                           style: AppStyle.lightSubtitle.copyWith(
  //                               color: AppColorsController().black,
  //                               fontWeight: FontWeight.w400,
  //                               fontSize: AppFontSize.fontSize_14),
  //                           maxLines: 2,
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                         Text(
  //                           translate("following"),
  //                           style: AppStyle.lightSubtitle.copyWith(
  //                               color: AppColorsController().black,
  //                               fontWeight: FontWeight.w400,
  //                               fontSize: 14),
  //                           maxLines: 2,
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                       ],
  //                     ),
  //                     onTap: () {
  //                       DIManager.findNavigator().pushNamed(
  //                         FollowFollowerBlockUser.routeName,
  //                         arguments: 1,
  //                       );
  //                     },
  //                   ),
  //                   SizedBox(width: 30.sp),
  //                   InkWell(
  //                     onTap: () {
  //                       if (currentUserId == widget.userId) {
  //                         DIManager.findNavigator().pushNamed(
  //                           FollowFollowerBlockUser.routeName,
  //                           arguments: 0,
  //                         );
  //                       }
  //                     },
  //                     child: Column(
  //                       children: [
  //                         Text(
  //                           data?.user?.followers?.toString() ?? '',
  //                           style: AppStyle.lightSubtitle.copyWith(
  //                               color: AppColorsController().black,
  //                               fontWeight: FontWeight.w400,
  //                               fontSize: AppFontSize.fontSize_14),
  //                           maxLines: 2,
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                         Text(
  //                           translate("followers"),
  //                           style: AppStyle.lightSubtitle.copyWith(
  //                               color: AppColorsController().black,
  //                               fontWeight: FontWeight.w400,
  //                               fontSize: AppFontSize.fontSize_14),
  //                           maxLines: 2,
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(width: 20.sp),
  //                   InkWell(
  //                     onTap: () {
  //                       // DIManager.findNavigator().pushNamed(
  //                       //   FollowFollowerBlockUser.routeName,
  //                       //   arguments: 1,
  //                       // );
  //                     },
  //                     child: Column(
  //                       children: [
  //                         Text(
  //                           '0',
  //                           style: AppStyle.lightSubtitle.copyWith(
  //                               color: AppColorsController().black,
  //                               fontWeight: FontWeight.w400,
  //                               fontSize: 14),
  //                           maxLines: 2,
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                         Text(
  //                           translate("number_of_ads"),
  //                           style: AppStyle.lightSubtitle.copyWith(
  //                               color: AppColorsController().black,
  //                               fontWeight: FontWeight.w400,
  //                               fontSize: 14),
  //                           maxLines: 2,
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           height: 10.sp,
  //         ),
  //         Text(
  //           translate("user_id") + " : " + (data?.user?.id?.toString() ?? ''),
  //           style: AppStyle.verySmallTitleStyle.copyWith(
  //             color: AppColorsController().black,
  //             fontWeight: AppFontWeight.midLight,
  //           ),
  //           maxLines: 2,
  //           overflow: TextOverflow.ellipsis,
  //         ),
  //         SizedBox(
  //           height: 4.sp,
  //         ),
  //         Row( mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             currentUserId != widget.userId
  //                 ? EvaluateUserButtonWidget(
  //               userId: widget.userId,
  //               onChanged: _onChanged,
  //             )
  //                 : Container(),
  //             SizedBox(
  //               width: 8.sp,
  //             ),
  //             Container(
  //               child: RatingBarIndicator(
  //                 rating: data?.user?.ratings_average?.toDouble() ?? 0,
  //                 itemCount: 5,
  //                 itemSize: 22,
  //                 unratedColor: AppColorsController().darkGreyTextColor,
  //                 direction: Axis.horizontal,
  //                 itemBuilder: (context, _) => Icon(
  //                   Icons.star,
  //                   size: 18,
  //                   color: Colors.amber,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(
  //           height: 4.sp,
  //         ),
  //         Text(
  //           translate("joined_on") + " " + data!.user!.created_at.toString(),
  //           style: AppStyle.lightSubtitle.copyWith(
  //               color: AppColorsController().textPrimaryColor,
  //               fontWeight: FontWeight.w400,
  //               fontSize: 15),
  //           maxLines: 2,
  //           overflow: TextOverflow.ellipsis,
  //         ),
  //         SizedBox(
  //           height: 4.sp,
  //         ),
  //         currentUserId != widget.userId
  //             ? FollowButtonWidget(
  //           isFollow: data?.is_follow??false,
  //           userId: widget.userId,
  //           onChanged: _onChanged,
  //         )
  //             : Container(),
  //       ],
  //     ),
  //   );
  // }



}
