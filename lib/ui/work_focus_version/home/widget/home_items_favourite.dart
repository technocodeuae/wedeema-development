import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wadeema/blocs/ads/ads_bloc.dart';
import 'package:wadeema/blocs/ads/states/ads_state.dart';
import 'package:wadeema/blocs/application/application_bloc.dart';
import 'package:wadeema/core/di/di_manager.dart';
import 'package:wadeema/core/utils/app_general_utils.dart';
import 'package:wadeema/core/utils/localization/app_localizations.dart';
import 'package:wadeema/ui/work_focus_version/chat/pages/chat_messages_page.dart';
import 'package:wadeema/ui/work_focus_version/general/icons/chat_icon.dart';

import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_consts.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../data/models/ads/entity/ads_entity.dart';
import '../../ads/widget/favourites_button_widget.dart';
import '../../chat/args/argument_message.dart';
import '../../general/icons/account_icon.dart';
import '../../general/icons/favourites_icon.dart';
import 'build_circular_image_user.dart';

class HomeItemsFavorite extends StatefulWidget {
  final ItemsAdsEntity? data;
  final double? height;
  final Function() onPress;
  final double? width;
  final bool weNeedJustImage;
  final Function(bool, int)? onChangedFavourite;
  final Function(bool)? onChangedLoaderFavourite;
  final int? adsIdFavourite;
  final int? indexFavourite;

  const HomeItemsFavorite(
      {Key? key, this.data,
        this.width,
        this.height,
        required this.onPress,
        this.weNeedJustImage = false,
        this.onChangedFavourite,
        this.onChangedLoaderFavourite,
        this.adsIdFavourite,
        this.indexFavourite,


      })
      : super(key: key);

  @override
  State<HomeItemsFavorite> createState() => _HomeItemsFavoriteState();
}

class _HomeItemsFavoriteState extends State<HomeItemsFavorite> {
  @override
  Widget build(BuildContext context) {
    // String? image = data?.ad_images?[0].name?.toString();
    return  Container(
      height: widget.height ?? 190.sp,
      width: widget.width ?? (376 / 2).sp,
      decoration: BoxDecoration(
        border: Border.all(
            color: AppColorsController().black, width: 0.2.sp),
        color: AppColorsController().card,
        borderRadius: BorderRadius.all(
          Radius.circular(16.sp),
        ),
      ),
      child: TextButton(
        onPressed: widget.onPress,
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            foregroundColor: AppColorsController().dropdown,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [

                 // image == '/img/ad/default.png'?Container():

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
                            padding: EdgeInsets.only(top: 0.0,
                                left: 4.sp,
                                right: 4.sp),
                            child: widget.weNeedJustImage ?
                            widget.data?.profile_pic != null && widget.data?.profile_pic != ''
                                ?
                            ClipOval(
                              child: Image.network(
                                AppConsts.IMAGE_URL + '${widget.data?.profile_pic}',
                                width: 32.sp,
                                height: 32.sp,
                                fit: BoxFit.fill,
                              ),)
                                :
                           Container() :
                            BuildCircularImageUser(
                              url: widget.data?.profile_pic,
                              id: widget.data?.user_id,
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
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        children: [
                          SizedBox(width: 4.sp,),
                          Container(
                            width: 35.sp,
                            height: 35.sp,
                            decoration: BoxDecoration(
                                color: AppColorsController().white,
                                borderRadius:
                                BorderRadius.circular(30.sp),
                                boxShadow: [AppStyle.normalShadow]),
                            child: Center(
                              child: FavouritesButtonWidget(
                                isFavourite: true,
                                isFromPageFavourite: true,
                                index: widget.indexFavourite,
                                onChanged: widget.onChangedFavourite,
                                adsId: widget.adsIdFavourite,
                                onChangedLoader: widget.onChangedLoaderFavourite,
                              ),
                            ),
                          ),
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
                      widget.data?.city ?? '',
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
                  DIManager.findDep<SharedPrefs>().getUserID()! == widget.data!.user_id.toString()? Container():
                  _chatButton(context)
                ] else ...[
                  _chatButton(context)
                ],

                // ElevatedButton(onPressed: (){
                //   print(image);
                //
                // }, child: Text('tt')),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget _priceAndDateWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.data?.date_ad != null ? getComparedTime(
              widget.data?.date_ad ?? DateTime.now()).toString() : "",
          style: AppStyle.lightSubtitle.copyWith(
              color: AppColorsController().black,
              fontWeight: AppFontWeight.midLight,
              fontSize: AppFontSize.fontSize_12
          ),
        ),
         Flexible(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.sp),
            child: Text(
              (widget.data?.price ?? 0) > 0
                  ? '${widget.data?.price?.toString() ?? ''} ${widget.data?.currency ?? ''}'
                  : '${translate('price_not_announced')}',
              style: AppStyle.lightSubtitle.copyWith(
                  color: AppColorsController().selectIconColor,
                  fontWeight: AppFontWeight.midLight,
                  fontSize: AppFontSize.fontSize_10
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _imageWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      child: Container(
        width: widget.width ?? ((376 / 2)).sp,
        height: 102.sp,
        // child: (data!.ad_images != null && (data?.ad_images?.length ?? 0) > 0 && (data?.ad_images?[0].name?.toString() != '/img/ad/default.png') )
        child:  widget.data?.image_name.toString() =='/img/ad/default.png'  ?  Container(
          width: 150.sp,
          height: 95.sp,
          child: SvgPicture.asset(
            "assets/images/trace.svg",
            width: 50.sp,
            height: 101.sp, fit: BoxFit.fill,
          ),
        ): Image.network(
          AppConsts.IMAGE_URL + (widget.data?.image_name.toString() ?? ''),
          width: widget.width ?? 200.sp,
          height: 102.sp,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return Text(
      widget.data?.title ?? '',
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


        if (!AppUtils.checkIfGuest(context)) {
          DIManager.findNavigator().pushNamed(ChatMessagesPage.routeName,
              arguments: ArgumentMessage(
                user_id_2: widget.data?.user_id,
                ad_id: widget.data?.ad_id,
                imageAds: widget.data?.image_name.toString(),
                nameAds: widget.data?.title?? '',
                nameOwnerAds: widget.data?.user_name?? '',
                user_name_person_sender: DIManager.findDep<SharedPrefs>().getUserNamePerson().toString(),
                user_id: DIManager.findDep<SharedPrefs>().getUserID().toString(),
              ));
        }

        // if (!AppUtils.checkIfGuest(context)) {
        //   DIManager.findNavigator().pushNamed(ChatMessagesPage.routeName,
        //       arguments: ArgumentMessage(
        //           user_id_2: widget.data?.user_id, ad_id: widget.data?.ad_id));
        // }
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
