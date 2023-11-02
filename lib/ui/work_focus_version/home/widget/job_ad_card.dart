import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wadeema/blocs/application/application_bloc.dart';
import 'package:wadeema/core/di/di_manager.dart';
import 'package:wadeema/core/enums/prop_enum.dart';
import 'package:wadeema/core/utils/app_general_utils.dart';
import 'package:wadeema/core/utils/localization/app_localizations.dart';
import 'package:wadeema/data/models/ads_details/entity/ads_details_entity.dart';
import 'package:wadeema/ui/work_focus_version/chat/pages/chat_messages_page.dart';
import 'package:wadeema/ui/work_focus_version/general/icons/chat_icon.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_consts.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../data/models/ads/entity/ads_entity.dart';
import '../../ads/widget/favourites_button_widget.dart';
import '../../chat/args/argument_message.dart';
import '../../general/icons/account_icon.dart';
import 'build_circular_image_user.dart';

class JobAdCard extends StatefulWidget {
  final ItemsAdsEntity? data;
  final double? height;
  final Function() onPress;
  final double? width;
  final bool weNeedJustImage;
  final bool isUseGridView;
  final bool isFromFavoritePage;
  final Function(bool, int)? onChangedFavourite;
  final Function(bool)? onChangedLoaderFavourite;
  final int? adsIdFavourite;
  final int? indexFavourite;

  const JobAdCard(
      {Key? key,
        this.data,
        this.width,
        this.height,
        required this.onPress,
        this.weNeedJustImage = false,
        this.isUseGridView = false,
        this.isFromFavoritePage = false,
        this.onChangedFavourite,
        this.onChangedLoaderFavourite,
        this.adsIdFavourite,
        this.indexFavourite,
      })
      : super(key: key);

  @override
  State<JobAdCard> createState() => _JobAdCardState();
}


class _JobAdCardState extends State<JobAdCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        border: Border.all(
            color: AppColorsController().buttonRedColor, width: 0.2.sp),
        color: AppColorsController().card,
        borderRadius: BorderRadius.all(
          Radius.circular(16.sp),
        ),
      ),
      margin: EdgeInsets.all(widget.width == null ? 12.sp : 0),
      child: TextButton(
        onPressed: widget.onPress,
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            foregroundColor: AppColorsController().dropdown,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.sp)))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.sp),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _titleWidget()),
                        Padding(
                          padding: EdgeInsets.only(top: 0.0,
                              left: 4.sp,
                              right: 4.sp),
                          child: widget.weNeedJustImage ? widget.data
                              ?.profile_pic != null && widget.data
                              ?.profile_pic != '' ? ClipOval(
                            child: Image.network(
                              AppConsts.IMAGE_URL +
                                  '${widget.data?.profile_pic}',
                              width: 32.sp,
                              height: 32.sp,
                              fit: BoxFit.fill,
                            ),) : AccountIcon(
                            height: 32.sp,
                            width: 32.sp,
                          ) : BuildCircularImageUser(
                            url: widget.data?.profile_pic,
                            id: widget.data?.user_id,
                            size: 25.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _descriptionWidget(),

                  _priceAndDateWidget(),
                  SizedBox(height: 4.sp,),
                ],
              ),
            ),
       widget.isFromFavoritePage? Align(
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
            ):Container(),

            widget.isUseGridView ? Spacer() : Container(),
            // Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Expanded(
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 10.sp),
                //     child: Text(
                //       data?.city ?? '',
                //       style: AppStyle.lightSubtitle.copyWith(
                //           color: AppColorsController().black,
                //           fontWeight: AppFontWeight.midLight,
                //           overflow: TextOverflow.ellipsis),
                //       maxLines: 1,
                //     ),
                //   ),
                // ),
                _chatButton(context)
              ],
            ),

          ],
        ),
      ),
    );
  }

  Widget _propWidget({required String image, required String title}) {
    return Row(
      children: [
        title == '' ? Container() : SvgPicture.asset(
            image, height: 18.sp, width: 18.sp),
        SizedBox(width: 6,),
        Text(title, style: AppStyle.lightSubtitle.copyWith(
            color: AppColorsController().black,
            fontWeight: AppFontWeight.midLight,
            fontSize: AppFontSize.fontSize_12
        ),)
      ],
    );
  }

  Widget _priceAndDateWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.sp,),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getTitle(PropType.SALARY, withTitle: true) ??
                        'الراتب: غير معلن',
                    style: AppStyle.lightSubtitle.copyWith(
                        color: AppColorsController().black,
                        fontWeight: AppFontWeight.midLight,
                        fontSize: AppFontSize.fontSize_12
                    ),
                  ),
                  SizedBox(height: 2.sp,),
                  Text(
                    ("نوع الدوام: " +
                        "${ _getTitle(PropType.EMP_TYPE) ?? "  غير معلن"}"),
                    style: AppStyle.lightSubtitle.copyWith(
                        color: AppColorsController().black,
                        fontWeight: AppFontWeight.midLight,
                        fontSize: AppFontSize.fontSize_12
                    ),
                  ),
                ],
              ),

              Container(
                margin: EdgeInsets.only(bottom: 4.sp),
                child: Text(
                  widget.data?.created_at != null
                      ? getComparedTime(
                      widget.data?.created_at ?? DateTime.now()).toString()
                      : "",
                  style: AppStyle.lightSubtitle.copyWith(
                      color: AppColorsController().greyTextColor,
                      fontWeight: AppFontWeight.midLight,
                      fontSize: AppFontSize.fontSize_12
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              _propWidget(
                  image: 'assets/icons/ic_job.svg',
                  title: _getTitle(PropType.EXPERIENCE) ?? ''),
              SizedBox(width: 8.sp,),
              _propWidget(
                  image: 'assets/icons/ic_graduation.svg',
                  title: _getTitle(PropType.EDUCATION) ?? ''),
            ],
          ),
        ],
      ),
    );
  }

  String? _getTitle(PropType propType, {bool withTitle = false}) {
    for (CategoryAdsDetailsEntity element in widget.data?.properties ?? []) {
      switch (propType) {
        case PropType.EMP_TYPE:
          if ((element.title?.contains('نوع') ?? false) ||
              (element.title?.toLowerCase().contains('type') ?? false)) {
            return withTitle
                ? '${element.title}: ${element.description}'
                : element.description;
          }
          break;
        case PropType.EXPERIENCE:
          if ((element.title?.contains('خبرة') ?? false) ||
              (element.title?.toLowerCase().contains('experience') ?? false)) {
            return withTitle
                ? '${element.title}: ${element.description}'
                : element.description;
          }
          break;
        case PropType.EDUCATION:
          if ((element.title?.contains('تعليم') ?? false) ||
              (element.title?.toLowerCase().contains('education') ?? false)) {
            return withTitle
                ? '${element.title}: ${element.description}'
                : element.description;
          }
          break;

        case PropType.SALARY:
          if ((element.title?.contains('راتب') ?? false) ||
              (element.title?.toLowerCase().contains('salary') ?? false)) {
            return withTitle
                ? '${element.title}: ${element.description}'
                : element.description;
          }
          break;
      }
    }
    return null;
  }

  Widget _titleWidget() {
    return Text(
      widget.data?.title ?? '',
      style: AppStyle.defaultStyle.copyWith(
          color: AppColorsController().black,
          fontWeight: AppFontWeight.bold,
          overflow: TextOverflow.ellipsis, fontSize: AppFontSize.fontSize_14
      ),
      maxLines: 1,
    );
  }

  Widget _descriptionWidget() {
    return Text(
      widget.data?.short_description ?? '',
      style: AppStyle.verySmallTitleStyle.copyWith(
          color: AppColorsController().black,
          overflow: TextOverflow.ellipsis, fontSize: AppFontSize.fontSize_12
      ),
      maxLines: 1, overflow: TextOverflow.ellipsis,
    );
  }

  Widget _chatButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!AppUtils.checkIfGuest(context)) {
          DIManager.findNavigator().pushNamed(ChatMessagesPage.routeName,
              arguments: ArgumentMessage(
                  user_id_2: widget.data?.user_id, ad_id: widget.data?.ad_id));
        }
      },
      child: Container(
        width: 100.sp,
        height: 30.sp,
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
                  width: 18.w,
                  height: 18.h,
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
