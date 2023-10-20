import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:wadeema/blocs/categories/categories_bloc.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/app_font.dart';
import 'package:wadeema/core/constants/dimens.dart';
import 'package:wadeema/data/models/other_profile/entity/other_profile_entity.dart';
import 'package:wadeema/ui/work_focus_version/home/pages/items_details_page.dart';
import 'package:wadeema/ui/work_focus_version/home/widget/job_ad_card.dart';

import '../../../../blocs/application/application_bloc.dart';
import '../../../../blocs/profile/profile_bloc.dart';
import '../../../../blocs/profile/states/profile_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/widgets/general_error_widget.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '../../general/icons/back_icon.dart';
import '../../general/icons/list_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../../home/arg/items_args.dart';
import '../../home/widget/home_items_widget.dart';
import '../widget/block_button_widget.dart';
import '../widget/evaluate_user_button_widget.dart';
import '../widget/follow_button_widget.dart';
import '../widget/image_profile_widget.dart';
import 'follow_follower_block_user_page.dart';

class ClientAccountPage extends StatefulWidget {
  static const routeName = '/ClientAccountPage';

  final int? userId;

  const ClientAccountPage({Key? key, this.userId}) : super(key: key);

  @override
  State<ClientAccountPage> createState() => _ClientAccountPageState();
}

class _ClientAccountPageState extends State<ClientAccountPage> {
  final profileBloc = DIManager.findDep<ProfileCubit>();
  final categoriesBloc = DIManager.findDep<CategoriesCubit>();

  OtherProfileEntity? data;
  int currentUserId = -1;
  bool _isLoader = false;

  @override
  void initState() {
    super.initState();
    _isLoader = true;
    print("widget.userId" + widget.userId.toString());
    if (DIManager.findDep<SharedPrefs>().getUserID() != null &&
        DIManager.findDep<SharedPrefs>().getUserID()!.isNotEmpty) {
      currentUserId =
          int.parse(DIManager.findDep<SharedPrefs>().getUserID().toString());
    }
    profileBloc.getOtherProfile(widget.userId!);
  }

  void _onChanged(bool newValue) {
    profileBloc.getOtherProfile(widget.userId!);
    setState(() {
      _isLoader = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsController().card.withOpacity(0.8),
      body: SafeArea(
        child: LoadingColumnOverlay(
          isLoading: _isLoader,
          child: BackLongPress(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarWidget(
                  name: translate("profile"),
                  child: InkWell(
                    onTap: () {
                      DIManager.findNavigator().pop();
                    },
                    child: BackIcon(
                      width: 26.sp,
                      height: 18.sp,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        BlocConsumer<ProfileCubit, ProfileState>(
                            bloc: profileBloc,
                            listener: (_, state) {
                              setState(() {
                                _isLoader = false;
                              });
                            },
                            builder: (context, state) {
                              final getOtherProfileState =
                                  state.getOtherProfileState;

                              if (getOtherProfileState is BaseFailState) {
                                return Column(
                                  children: [
                                    VerticalPadding(3.0),
                                    GeneralErrorWidget(
                                      error: getOtherProfileState.error,
                                      callback: getOtherProfileState.callback,
                                    ),
                                  ],
                                );
                              }

                              if (getOtherProfileState
                                  is GetOtherProfileSuccessState) {
                                data = (state.getOtherProfileState
                                        as GetOtherProfileSuccessState)
                                    .profile;
                                return _buildBody();
                              }
                              return Container(
                                child:
                                    data == null ? Container() : _buildBody(),
                              );
                            }),
                        SizedBox(
                          height: 30.sp,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: bottomNavigationBarWidget(),
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
  //                               fontSize: 14),
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
  //                         arguments: 0,
  //                       );
  //                     },
  //                   ),
  //                   SizedBox(width: 30.sp),
  //                   InkWell(
  //                     onTap: () {
  //                       DIManager.findNavigator().pushNamed(
  //                         FollowFollowerBlockUser.routeName,
  //                         arguments: 1,
  //                       );
  //                     },
  //                     child: Column(
  //                       children: [
  //                         Text(
  //                           data?.user?.followers?.toString() ?? '',
  //                           style: AppStyle.lightSubtitle.copyWith(
  //                               color: AppColorsController().black,
  //                               fontWeight: FontWeight.w400,
  //                               fontSize: 14),
  //                           maxLines: 2,
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                         Text(
  //                           translate("followers"),
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
  //           data?.user?.user_name.toString() ?? '',
  //           style: AppStyle.smallTitleTextStyle.copyWith(
  //               color: AppColorsController().textPrimaryColor,
  //               fontWeight: FontWeight.bold,
  //               fontSize: 19),
  //           maxLines: 2,
  //           overflow: TextOverflow.ellipsis,
  //         ),
  //         SizedBox(
  //           height: 4.sp,
  //         ),
  //         Container(
  //           child: RatingBarIndicator(
  //             rating: data?.user?.ratings_average?.toDouble() ?? 0,
  //             itemCount: 5,
  //             itemSize: 22,
  //             unratedColor: AppColorsController().darkGreyTextColor,
  //             direction: Axis.horizontal,
  //             itemBuilder: (context, _) => Icon(
  //               Icons.star,
  //               size: 18,
  //               color: Colors.amber,
  //             ),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 4.sp,
  //         ),
  //         Text(
  //           translate("joined_on") + " " + "${parsedDate2}",
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
  //         Text(
  //           translate("user_id") + " : " + (data?.user?.id?.toString() ?? ''),
  //           style: AppStyle.verySmallTitleStyle.copyWith(
  //               color: AppColorsController().black,
  //               fontWeight: AppFontWeight.midLight,
  //               fontSize: 15),
  //           maxLines: 2,
  //           overflow: TextOverflow.ellipsis,
  //         ),
  //         SizedBox(
  //           height: 2.sp,
  //         ),
  //         _buttonBuild(),
  //       ],
  //     ),
  //   );
  // }
  //
  _buildBody() {
    String apiDate = data!.user!.created_at.toString();
    DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(apiDate);
    String parsedDate2 = DateFormat("dd/MM/yyyy").format(parsedDate).toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            // Container(
            //   padding:
            //       EdgeInsets.symmetric(horizontal: 28.sp, vertical: 28.sp),
            //   decoration: BoxDecoration(
            //       color: AppColorsController().containerPrimaryColor,
            //       border: Border.all(
            //         color: AppColorsController().borderColor,
            //         width: 0.2,
            //       ),
            //       borderRadius: BorderRadius.all(
            //           Radius.circular(Dimens.dialogBorderRadius))),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Flexible(
            //             flex: 7,
            //             child: ImageProfileWidget(
            //               url: data?.user?.profile_pic,
            //             ),
            //           ),
            //           Flexible(
            //             flex: 6,
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 InkWell(
            //                   onTap: () {
            //                     if (currentUserId == widget.userId) {
            //                       DIManager.findNavigator().pushNamed(
            //                         FollowFollowerBlockUser.routeName,
            //                         arguments: 1,
            //                       );
            //                     }
            //                   },
            //                   child: Column(
            //                     children: [
            //                       Text(
            //                         data?.user?.following?.toString() ?? '',
            //                         style: AppStyle.lightSubtitle.copyWith(
            //                           color: AppColorsController().black,
            //                           fontWeight: FontWeight.w400,
            //                         ),
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                       ),
            //                       Text(
            //                         translate("following"),
            //                         style: AppStyle.lightSubtitle.copyWith(
            //                           color: AppColorsController().black,
            //                           fontWeight: FontWeight.w400,
            //                         ),
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 InkWell(
            //                   onTap: () {
            //                     if (currentUserId == widget.userId) {
            //                       DIManager.findNavigator().pushNamed(
            //                         FollowFollowerBlockUser.routeName,
            //                         arguments: 0,
            //                       );
            //                     }
            //                   },
            //                   child: Column(
            //                     children: [
            //                       Text(
            //                         data?.user?.followers?.toString() ?? '',
            //                         style: AppStyle.lightSubtitle.copyWith(
            //                           color: AppColorsController().black,
            //                           fontWeight: FontWeight.w400,
            //                         ),
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                       ),
            //                       Text(
            //                         translate("followers"),
            //                         style: AppStyle.lightSubtitle.copyWith(
            //                           color: AppColorsController().black,
            //                           fontWeight: FontWeight.w400,
            //                         ),
            //                         maxLines: 2,
            //                         overflow: TextOverflow.ellipsis,
            //                       ),
            //                     ],
            //                   ),
            //                 )
            //               ],
            //             ),
            //           ),
            //           SizedBox(
            //             width: 20.sp,
            //           )
            //         ],
            //       ),
            //       SizedBox(
            //         height: 10.sp,
            //       ),
            //       Text(
            //         data?.user?.user_name?.toString() ?? '',
            //         style: AppStyle.smallTitleTextStyle.copyWith(
            //           color: AppColorsController().textPrimaryColor,
            //           fontWeight: FontWeight.bold,
            //         ),
            //         maxLines: 2,
            //         overflow: TextOverflow.ellipsis,
            //       ),
            //       SizedBox(
            //         height: 4.sp,
            //       ),
            //       Text(
            //         translate("user_id") + " : " + (data?.user?.id?.toString() ?? ''),
            //         style: AppStyle.verySmallTitleStyle.copyWith(
            //           color: AppColorsController().black,
            //           fontWeight: AppFontWeight.midLight,
            //         ),
            //         maxLines: 2,
            //         overflow: TextOverflow.ellipsis,
            //       ),
            //       SizedBox(
            //         height: 4.sp,
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           currentUserId != widget.userId
            //               ? EvaluateUserButtonWidget(
            //                   userId: widget.userId,
            //                   onChanged: _onChanged,
            //                 )
            //               : Container(),
            //           SizedBox(
            //             width: 8.sp,
            //           ),
            //           Container(
            //             child: RatingBarIndicator(
            //               rating: data?.user?.ratings_average?.toDouble() ?? 0,
            //               itemCount: 5,
            //               itemSize: 15.sp,
            //               unratedColor:
            //                   AppColorsController().darkGreyTextColor,
            //               direction: Axis.horizontal,
            //               itemBuilder: (context, _) => Icon(
            //                 Icons.star,
            //                 size: 13.sp,
            //                 color: Colors.amber,
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //       SizedBox(
            //         height: 4.sp,
            //       ),
            //       Text(
            //         translate("joined_on") +
            //             " " +
            //             data!.user!.created_at.toString(),
            //         style: AppStyle.lightSubtitle.copyWith(
            //           color: AppColorsController().textPrimaryColor,
            //           fontWeight: FontWeight.w400,
            //         ),
            //         maxLines: 2,
            //         overflow: TextOverflow.ellipsis,
            //       ),
            //       currentUserId != widget.userId
            //           ? FollowButtonWidget(
            //               isFollow: data?.is_follow??false,
            //               userId: widget.userId,
            //               onChanged: _onChanged,
            //             )
            //           : Container(),
            //     ],
            //   ),
            // ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
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
                        // SizedBox(width: 14.sp),
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
                                        fontSize: AppFontSize.fontSize_14),
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
                                  arguments: 1,
                                );
                              },
                            ),
                            SizedBox(width: 30.sp),
                            InkWell(
                              onTap: () {
                                if (currentUserId == widget.userId) {
                                  DIManager.findNavigator().pushNamed(
                                    FollowFollowerBlockUser.routeName,
                                    arguments: 0,
                                  );
                                }
                              },
                              child: Column(
                                children: [
                                  Text(
                                    data?.user?.followers?.toString() ?? '',
                                    style: AppStyle.lightSubtitle.copyWith(
                                        color: AppColorsController().black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: AppFontSize.fontSize_14),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    translate("followers"),
                                    style: AppStyle.lightSubtitle.copyWith(
                                        color: AppColorsController().black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: AppFontSize.fontSize_14),
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
                  Text(
                    data?.user?.user_name?.toString() ?? '',
                    style: AppStyle.smallTitleTextStyle.copyWith(
                      color: AppColorsController().textPrimaryColor,
                      fontWeight: FontWeight.bold,fontSize: AppFontSize.fontSize_16
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // SizedBox(
                  //   height: 10.sp,
                  // ),
                  //
                                    Row( mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      currentUserId != widget.userId
                          ? EvaluateUserButtonWidget(
                        userId: widget.userId,
                        onChanged: _onChanged,
                      )
                          : Container(),
                      SizedBox(
                        width: 8.sp,
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
                    ],
                  ),
                  SizedBox(
                    height: 4.sp,
                  ),
                  Text(
                    translate("joined_on") + " " + '${parsedDate2}',
                    style: AppStyle.lightSubtitle.copyWith(
                        color: AppColorsController().textPrimaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: AppFontSize.fontSize_14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    translate("user_id") + " : " + (data?.user?.id?.toString() ?? ''),
                    style: AppStyle.verySmallTitleStyle.copyWith(
                        color: AppColorsController().black,
                        fontWeight: AppFontWeight.midLight,
                        fontSize: AppFontSize.fontSize_16
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // SizedBox(
                  //   height: 4.sp,
                  // ),
                  currentUserId != widget.userId
                      ? FollowButtonWidget(
                    isFollow: data?.is_follow??false,
                    userId: widget.userId,
                    onChanged: _onChanged,
                  )
                      : Container(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Align(
                alignment: DIManager.findDep<ApplicationCubit>().appLanguage.languageCode == "ar"?Alignment.topLeft:Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(16.0.sp),
                  child: PopupMenuButton(
                    padding: EdgeInsets.all(0),
                    color: AppColorsController().buttonRedColor,
                    child: ListIcon(),
                    // Use a specific widget
                    itemBuilder: (BuildContext context) =>
                        currentUserId != widget.userId
                            ? [
                                PopupMenuItem(
                                  enabled: false,
                                  child: BlockButtonWidget(colorText:AppColorsController().white,
                                    isBlock: data?.is_blocked ?? false,
                                userId: widget.userId,
                                onChanged: _onChanged,
                                  ),
                                  value: 'is_blocked',
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    translate("share"),
                                    style: AppStyle.defaultStyle.copyWith(
                                      color: AppColorsController().white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  value: 'share',
                                ),
                              ]
                            : [
                                PopupMenuItem(
                                  child: Text(
                                    translate("share"),
                                    style: AppStyle.defaultStyle.copyWith(
                                      color: AppColorsController().white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  value: 'share',
                                ),
                              ],
                    onSelected: (value) {
                      if (value == "share") {
                        Share.share(data?.sharing_link ?? '');
                      }
                      // Handle menu item selection here
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        // SizedBox(
        //   height: 8.sp,
        // ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          margin: EdgeInsets.symmetric(horizontal: 10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                translate("ads_list") + ":",
                style: AppStyle.smallTitleStyle.copyWith(
                  color: AppColorsController().black,
                  fontWeight: FontWeight.bold,fontSize: AppFontSize.fontSize_14
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.sp,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0.sp),
                child: GridView.builder(
                  itemCount: data?.active_ads?.length ?? 0,
                  itemBuilder: (context, index) {
                    if (categoriesBloc.isJobs(data?.active_ads?[index].category_title ?? '')) {

                      return JobAdCard(
                        weNeedJustImage: true,
                        // height: MediaQuery.sizeOf(context).height * 0.23,
                        // height: 250.sp,
                        width: MediaQuery.sizeOf(context).width * 0.85,
                        data: data?.active_ads?[index],
                        onPress: () {
                          DIManager.findNavigator().pushNamed(
                            ItemsDetailsPage.routeName,
                            arguments: ItemsArgs(id: data?.active_ads?[index].ad_id ?? 0),
                          );
                        },
                      );
                    }
                      return HomeItemsWidget(
                        weNeedJustImage: true,
                          data: data?.active_ads?[index],
                          onPress: () {
                            DIManager.findNavigator().pushNamed(
                              ItemsDetailsPage.routeName,
                              arguments: ItemsArgs(id: data?.active_ads?[index]?.ad_id ?? 0),
                            );
                          });


                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 210.sp,
                    crossAxisSpacing: 6.sp,
                    mainAxisSpacing: 18.sp,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
