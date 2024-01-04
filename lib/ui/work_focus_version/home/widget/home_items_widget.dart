import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wadeema/blocs/application/application_bloc.dart';
import 'package:wadeema/core/di/di_manager.dart';
import 'package:wadeema/core/utils/app_general_utils.dart';
import 'package:wadeema/core/utils/localization/app_localizations.dart';
import 'package:wadeema/ui/work_focus_version/app.dart';
import 'package:wadeema/ui/work_focus_version/chat/pages/chat_messages_page.dart';
import 'package:wadeema/ui/work_focus_version/general/icons/chat_icon.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_consts.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../data/models/ads/entity/ads_entity.dart';
import '../../chat/args/argument_message.dart';
import '../../general/icons/account_icon.dart';
import 'build_circular_image_user.dart';

class HomeItemsWidget extends StatelessWidget {
  final ItemsAdsEntity? data;
  final double? height;
  final Function() onPress;
  final double? width;
  final bool weNeedJustImage;
  final bool weDontHaveImage;

  const HomeItemsWidget({Key? key,
    this.data,
    this.width,
    this.height,
    required this.onPress,
    this.weNeedJustImage = false,
    this.weDontHaveImage = false,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 190.sp,
      width: width ?? (376 / 2).sp,
      decoration: BoxDecoration(
        border: Border.all(
            color: AppColorsController().black, width: 0.2.sp),
        color: AppColorsController().card,
        borderRadius: BorderRadius.all(
          Radius.circular(16.sp),
        ),
      ),
      child: TextButton(
        onPressed: onPress,
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            foregroundColor: AppColorsController().dropdown,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)))),
        child:
        data?.image_name.toString() ==
            '/img/ad/default.png'
                || data?.featured_image?.toString() ==
            '/img/ad/default.png'?
        // ((data!.ad_images != null &&
        //     (data?.ad_images?.length ?? 0) > 0) &&
        //     data?.image_name.toString() ==
        //         '/img/ad/default.png')
        //         || data?.featured_image?.toString() ==
        //     '/img/ad/default.png' ?


        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Column(

                            children: [
                              SizedBox(height: 4.sp,),
                              Container(
                                width: 150.sp,
                                height: 95.sp,
                                child: SvgPicture.asset(
                                  "assets/images/trace.svg",
                                  width: 50.sp,
                                  height: 101.sp, fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(height: 6.sp,),


                              // SizedBox(height: 4.sp,),
                              // SvgPicture.asset(
                              //   "assets/images/trace0.svg",
                              //   width: 50.sp,
                              //   height: 101.sp,
                              // ),
                              // SizedBox(height: 6.sp,),


                            ],
                          ),
                        ),
                        // Center(
                        //   child: Image.asset( "assets/images/logo.png",  width: 150.sp,
                        //     height: 101.sp,),
                        // ),
                        Container(width: 400.sp,
                          height: 1.sp,
                          color: AppColorsController().defaultPrimaryColor,),
                        SizedBox(height: 6.sp,),
                      ],
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Column(
                        children: [
                          SizedBox(height: 20.sp,),

                          Padding(
                            padding: EdgeInsets.only(
                                top: 0.0, left: 4.sp, right: 4.sp),
                            child: weNeedJustImage ?
                            data?.profile_pic != null && data?.profile_pic != ''
                                ?
                            ClipOval(
                              child: Image.network(
                                AppConsts.IMAGE_URL + '${data?.profile_pic}',
                                width: 32.sp,
                                height: 32.sp,
                                fit: BoxFit.fill,
                              ),)
                                :
                            AccountIcon(
                              height: 32.sp,
                              width: 32.sp,
                            ) :
                            BuildCircularImageUser(
                              url: data?.profile_pic,
                              id: data?.user_id,
                            ),
                          ),


                          // Padding(
                          //   padding: const EdgeInsets.only(top:0.0,left: 4,right: 4),
                          //   child: BuildCircularImageUser(
                          //     url: data?.profile_pic,
                          //     id: data?.user_id,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _priceAndDateWidget(),
                      _titleWidget(),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Text(
                      data?.city ?? '',
                      style: AppStyle.lightSubtitle.copyWith(
                          color: AppColorsController().black,
                          fontWeight: AppFontWeight.midLight,
                          fontSize: AppFontSize.fontSize_12,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                    ),
                  ),
                ),

                if(DIManager.findDep<SharedPrefs>()
                    .getToken()?.isEmpty == false)...[
                  DIManager.findDep<SharedPrefs>().getUserID()! == data!.user_id.toString()? Container():
                  _chatButton(context)
                ] else ...[
                  _chatButton(context)
                ],

              ],
            ),

          ],
        ) : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Column(
                      children: [
                        _imageWidget(),
                        SizedBox(height: 10.sp,),
                      ],
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Column(
                        children: [
                          SizedBox(height: 20.sp,),

                          Padding(
                            padding: EdgeInsets.only(
                                top: 0.0, left: 4.sp, right: 4.sp),
                            child: weNeedJustImage ?
                            data?.profile_pic != null && data?.profile_pic != ''
                                ?
                            ClipOval(
                              child: Image.network(
                                AppConsts.IMAGE_URL + '${data?.profile_pic}',
                                width: 32.sp,
                                height: 32.sp,
                                fit: BoxFit.fill,
                              ),)
                                :
                            AccountIcon(
                              height: 32.sp,
                              width: 32.sp,
                            ) :
                            BuildCircularImageUser(
                              url: data?.profile_pic,
                              id: data?.user_id,
                            ),
                          ),


                          // Padding(
                          //   padding: const EdgeInsets.only(top:0.0,left: 4,right: 4),
                          //   child: BuildCircularImageUser(
                          //     url: data?.profile_pic,
                          //     id: data?.user_id,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _priceAndDateWidget(),
                      _titleWidget(),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Text(
                      data?.city ?? '',
                      style: AppStyle.lightSubtitle.copyWith(
                          color: AppColorsController().black,
                          fontWeight: AppFontWeight.midLight,
                          fontSize: AppFontSize.fontSize_12,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                    ),
                  ),
                ),

                if(DIManager.findDep<SharedPrefs>()
                    .getToken()?.isEmpty == false)...[
                  DIManager.findDep<SharedPrefs>().getUserID()! == data!.user_id.toString()? Container():
                  _chatButton(context)
                ] else ...[
                  _chatButton(context)
                ],
                // data.user_id

              ],
            ),

          ],
        ),
      ),
    );
  }


  /*
  Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Column(
              children: [
Image.asset( "assets/images/logo.png",height: 95.h,width: 130.w,),
                Padding(
                  padding:  EdgeInsets.all(5.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _titleWidgetDontHaveImage(),
                      weNeedJustImage?
                      data?.profile_pic!=null &&data?.profile_pic != ''?
                      ClipOval(
                        child: Image.network(
                          AppConsts.IMAGE_URL+'${data?.profile_pic}',
                          width: 32.sp,
                          height: 32.sp,
                          fit: BoxFit.fill,
                        ),):
                      AccountIcon(
                        height: 32.sp,
                        width: 32.sp,
                      ):
                      BuildCircularImageUser(
                        url: data?.profile_pic,
                        id: data?.user_id,
                      ),
                    ],
                  ),
                ),

              ],
            ),

            _priceAndDateWidgetDontHaveImage(),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Text(
                      data?.city ?? '',
                      style: AppStyle.lightSubtitle.copyWith(
                          color: AppColorsController().black,
                          fontWeight: AppFontWeight.midLight,fontSize: AppFontSize.fontSize_12,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                    ),
                  ),
                ),
                _chatButton(context)
              ],
            ),

          ],
        )
  * */
  // Widget _priceAndDateWidgetDontHaveImage() {
  //   return Padding(
  //     padding: EdgeInsets.only(left: 4.sp, right: 4.sp),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         // Text(
  //         //   data?.short_description ??'',maxLines: 1,overflow: TextOverflow.ellipsis,
  //         //   style: AppStyle.lightSubtitle.copyWith(
  //         //       color: AppColorsController().black,
  //         //       fontWeight: AppFontWeight.midLight,fontSize: AppFontSize.fontSize_10
  //         //   ),
  //         // ),
  //
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               data?.date_ad != null ? getComparedTime(
  //                   data?.date_ad ?? DateTime.now()).toString() : "",
  //               style: AppStyle.lightSubtitle.copyWith(
  //                   color: AppColorsController().black,
  //                   fontWeight: AppFontWeight.midLight,
  //                   fontSize: AppFontSize.fontSize_10
  //               ),
  //             ),
  //
  //             Text(
  //               (data?.price ?? 0) > 0
  //                   ? '${data?.price?.toString() ?? ''} ${data?.currency ?? ''}'
  //                   : '${translate('price_not_announced')}',
  //               style: AppStyle.lightSubtitle.copyWith(
  //                   color: AppColorsController().selectIconColor,
  //                   fontWeight: AppFontWeight.midLight,
  //                   fontSize: AppFontSize.fontSize_10
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _titleWidgetDontHaveImage() {
  //   return Text(
  //     data?.title ?? '',
  //     style: AppStyle.defaultStyle.copyWith(
  //         color: AppColorsController().black,
  //         fontWeight: AppFontWeight.bold,
  //         overflow: TextOverflow.ellipsis, fontSize: AppFontSize.fontSize_14
  //     ),
  //     maxLines: 1,
  //   );
  // }


  Widget _priceAndDateWidget() {
    // print(data?.properties![0].description);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          data?.date_ad != null ? getComparedTime(
              data?.date_ad ?? DateTime.now()).toString() : "",
          style: AppStyle.lightSubtitle.copyWith(
              color: AppColorsController().black,
              fontWeight: AppFontWeight.midLight,
              fontSize: AppFontSize.fontSize_12
          ),
        ),

        // if(data!.properties != null && data!.properties!.isNotEmpty == true)...[
        //   for(int i = 0; i < data!.properties!.length; i ++)...[
        //     if(data!.properties![i].title!.contains('السعر من') &&
        //         data!.properties![i].title == 'السعر من')...[
        //       Text(
        //         '${data!.properties![i]
        //             .description
        //             .toString()} ${data?.currency ?? ''}',
        //         style: AppStyle.lightSubtitle.copyWith(
        //             color: AppColorsController().selectIconColor,
        //             fontWeight: AppFontWeight.midLight,
        //             fontSize: AppFontSize.fontSize_10
        //         ),
        //         maxLines: 1,
        //       ),
        //     ],
        //   ]
        // ] else
        //   ...[
            Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.sp),
                child: Text(

                  (data?.price ?? 0) > 0
                      ? '${data?.price?.toString() ?? ''} ${data?.currency ??
                      ''}'
                      : '${translate('price_not_announced')}',
                  style: AppStyle.lightSubtitle.copyWith(
                      color: AppColorsController().selectIconColor,
                      fontWeight: AppFontWeight.midLight,
                      fontSize: AppFontSize.fontSize_10
                  ),
                ),
              ),
            ),
          // ],

      ],
    );
  }

  checkPrice(List myList) {
    for (int i = 0; i < myList.length; i++) {

    }
  }

  Widget _imageWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      child: Container(
        width: width ?? ((376 / 2)).sp,
        height: 102.sp,
        child: (data!.image_name != null )
            ? Image.network(
          AppConsts.IMAGE_URL + (data?.image_name.toString() ?? ''),
          width: width ?? 200.sp,
          height: 102.sp,
          fit: BoxFit.cover,
        )
            : Image.network(
          AppConsts.IMAGE_URL + (data?.featured_image?.toString() ?? ''),
          width: width ?? 200.sp,
          height: 102.sp,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return Text(
      data?.title ?? '',
      style: AppStyle.defaultStyle.copyWith(
          color: AppColorsController().black,
          fontWeight: AppFontWeight.bold,
          overflow: TextOverflow.ellipsis, fontSize: AppFontSize.fontSize_12
      ),
      maxLines: 1,
    );
  }

  Widget _chatButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print( DIManager.findDep<SharedPrefs>().getUserNamePerson().toString());

        if (!AppUtils.checkIfGuest(context)) {
          DIManager.findNavigator().pushNamed(ChatMessagesPage.routeName,
              arguments: ArgumentMessage(
                user_id_2: data?.user_id,
                ad_id: data?.ad_id,
                imageAds: data?.image_name.toString(),
                nameAds: data?.title?? '',
                nameOwnerAds: data?.user_name?? '',
                user_name_person_sender: DIManager.findDep<SharedPrefs>().getUserNamePerson().toString(),
                user_id: DIManager.findDep<SharedPrefs>().getUserID().toString(),
              ));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          // color: AppColorsController().white,
            color: Colors.white,
            border: Border.all(
                color: AppColorsController().dropdown, width: 0.5.sp),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(
                    DIManager
                        .findDep<ApplicationCubit>()
                        .appLanguage
                        .languageCode == AppConsts.LANG_AR ? 0 : 16.sp),
                topLeft: Radius.circular(
                    DIManager
                        .findDep<ApplicationCubit>()
                        .appLanguage
                        .languageCode == AppConsts.LANG_AR ? 0 : 16.sp),
                topRight: Radius.circular(
                    DIManager
                        .findDep<ApplicationCubit>()
                        .appLanguage
                        .languageCode == AppConsts.LANG_AR ? 16.sp : 0),
                bottomLeft: Radius.circular(
                    DIManager
                        .findDep<ApplicationCubit>()
                        .appLanguage
                        .languageCode == AppConsts.LANG_AR ? 16.sp : 0))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 2.sp),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(start: 8.sp, end: 4.sp),
                child: Text(
                    translate("chat"), style: AppStyle.lightSubtitle.copyWith(
                    color: AppColorsController().dropdown,
                    fontWeight: AppFontWeight.midLight,
                    fontSize: AppFontSize.fontSize_14,
                    overflow: TextOverflow.ellipsis)),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 4.sp, end: 8.sp),
                child: ChatIcon(
                  width: 18.sp,
                  height: 18.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String getComparedTime(DateTime dateTime) {
  Duration difference = DateTime.now().difference(dateTime);
  final List prefix = [
    translate("just now"),
    translate("second(s)"),
    translate("minute(s)"),
    translate("hour(s)"),
    translate("day(s)"),
    translate("month(s)"),
    translate("year(s)")
  ];
  if (difference.inDays == 0) {
    if (difference.inMinutes == 0) {
      if (difference.inSeconds < 20) {
        return (prefix[0]);
      } else {
        return ("${difference.inSeconds} ${prefix[1]}");
      }
    } else {
      if (difference.inMinutes > 59) {
        return ("${(difference.inMinutes / 60).floor()} ${prefix[3]}");
      } else {
        return ("${difference.inMinutes} ${prefix[2]}");
      }
    }
  } else {
    if (difference.inDays > 30) {
      if (((difference.inDays) / 30).floor() > 12) {
        return ("${((difference.inDays / 30) / 12).floor()} ${prefix[6]}");
      } else {
        return ("${(difference.inDays / 30).floor()} ${prefix[5]}");
      }
    } else {
      return ("${difference.inDays} ${prefix[4]}");
    }
  }
}
