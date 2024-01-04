import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share/share.dart';
import 'package:wadeema/core/utils/app_general_utils.dart';
import 'package:wadeema/ui/work_focus_version/home/widget/ratings_widget.dart';
import 'package:wadeema/ui/work_focus_version/home/widget/see_more_properties_widget.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../data/models/ads_details/entity/ads_details_entity.dart';
import '../../ads/widget/favourites_button_widget.dart';
import '../../ads/widget/like_button_widget.dart';
import '../../chat/args/argument_message.dart';
import '../../chat/pages/chat_messages_page.dart';
import '../../general/buttons/app_button.dart';
import '../../general/icons/chat_icon.dart';
import '../../general/icons/share_icon.dart';
import '../../profile/widget/evaluate_user_button_widget.dart';
import 'home_items_widget.dart';
import 'image_slider_show_widget.dart';

class DetailsBodyWidget extends StatefulWidget {
  final AdsDetailsEntity? data;
  final int? id;
  final int categoryId;
  final int? index;
  final String? typeAds;
  final Function(bool, int)? onPressedLike;
  final Function(bool, int)? onPressedFavourite;
  final Function(bool)? onPressedLoader;
  final Function(bool)? onPressedAddComment;

  const DetailsBodyWidget({
    Key? key,
    this.onPressedLike,
    this.onPressedFavourite,
    this.onPressedLoader,
    this.data,
    this.id,
    required this.categoryId,
    this.index,
    this.onPressedAddComment,
    this.typeAds,
  }) : super(key: key);

  @override
  State<DetailsBodyWidget> createState() => _DetailsBodyWidgetState();
}

class _DetailsBodyWidgetState extends State<DetailsBodyWidget> {
  bool _isSeeMore = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('widget.typeAds :${widget.typeAds}');
    return Column(
      children: [
        widget.typeAds == 'jobAds' ||
                widget.typeAds == 'adsWithoutImage' ||
                widget.categoryId == 27
            ? Container()
            : ImageSliderShowWidget(
                images: widget.data?.images,
                is_favorite: widget.data?.ad?.is_favorite,
                ad_id: widget.data?.ad?.ad_id,
                onChanged: widget.onPressedFavourite,
                index: widget.index,
                onChangedLoader: widget.onPressedLoader,
                adsUrlShare: widget.data?.sharing_link,
              ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 20.sp,
              vertical: widget.typeAds == 'jobAds' ||
                      widget.typeAds == 'adsWithoutImage' ||
                      widget.categoryId == 27
                  ? 40.sp
                  : 0.sp),
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.sp, vertical: 4.sp),
                decoration: BoxDecoration(
                  color: AppColorsController().containerPrimaryColor,
                  border: Border.all(
                    color: AppColorsController().borderGrayColor,
                    width: 0.2.sp,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimens.defaultBorderRadius),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.data!.ad!.title.toString(),
                          style: AppStyle.smallTitleStyle.copyWith(
                              color: AppColorsController().black,
                              fontWeight: AppFontWeight.midLight,
                              fontSize: AppFontSize.fontSize_14),
                        ),
                        // if (widget.typeAds == 'jobAds' ||
                        //     widget.categoryId == 27) ...[
                        //   Container()
                        // ]

                        // else if (widget.data!.properties != null &&
                        //     widget.data!.properties!.isNotEmpty == true) ...[
                        //   for (int i = 0;
                        //       i < widget.data!.properties!.length ;
                        //       i++) ...[
                        //     if (widget.data!.properties![i].title ==
                        //         'السعر من' &&
                        //         widget.data!.properties![i].title!
                        //             .contains('السعر من')) ...[
                        //       widget.typeAds == 'jobAds' ||
                        //               widget.categoryId == 27
                        //           ? Container()
                        //           : Text(
                        //               '${widget.data!.properties![i].description.toString()} درهم',
                        //               style: AppStyle.smallTitleStyle.copyWith(
                        //                   color: AppColorsController()
                        //                       .textPrimaryColor,
                        //                   fontWeight: AppFontWeight.midLight,
                        //                   fontSize: AppFontSize.fontSize_12),
                        //               maxLines: 1,
                        //             ),
                        //     ] else ...[
                        //       // Container()
                        //     ]
                        //   ]
                        // ]
                        //
                        // else if (widget.typeAds == 'ads') ...[
                        //   Text(
                        //     (widget.data?.ad!.price ?? 0) > 0
                        //         ? '${widget.data?.ad!.price?.toString() ?? ''} ${widget.data?.ad!.currency ?? ''}'
                        //         : '${translate('price_not_announced')}',
                        //     style: AppStyle.smallTitleStyle.copyWith(
                        //       color: AppColorsController().textPrimaryColor,
                        //       fontWeight: AppFontWeight.midLight,
                        //     ),
                        //   ),
                        // ],
                        // if (
                        // // widget.data!.properties != null &&
                        //     widget.typeAds == 'ads1') ...[
                        //   SizedBox(
                        //     width: 100.w,
                        //   ),
                        //   Text(
                        //     (widget.data?.ad!.price ?? 0) > 0
                        //         ? '${widget.data?.ad!.price?.toString() ?? ''} ${widget.data?.ad!.currency ?? ''}'
                        //         : '${translate('price_not_announced')}',
                        //     style: AppStyle.smallTitleStyle.copyWith(
                        //       color: AppColorsController().textPrimaryColor,
                        //       fontWeight: AppFontWeight.midLight,
                        //     ),
                        //   ),
                        // ],
                        // if ((widget.typeAds == 'ads' &&
                        //         // widget.data!.properties == null &&
                        //         widget.categoryId != 27) ||
                        //     (
                        //
                        //         // widget.data!.ad!.properties == null &&
                        //         widget.typeAds != 'ads' &&
                        //         widget.categoryId != 27)) ...[
                        //   widget.typeAds == 'jobAds' ||
                        //           widget.typeAds == 'ads1' ||
                        //           widget.categoryId == 27
                        //       ? Container()
                        //       : Text(
                        //           (widget.data?.ad!.price ?? 0) > 0
                        //               ? '${widget.data?.ad!.price?.toString() ?? ''} ${widget.data?.ad!.currency ?? ''}'
                        //               : '${translate('price_not_announced')}',
                        //           style: AppStyle.smallTitleStyle.copyWith(
                        //             color:
                        //                 AppColorsController().textPrimaryColor,
                        //             fontWeight: AppFontWeight.midLight,
                        //           ),
                        //         ),
                        // ],



                         widget.typeAds == 'jobAds' || widget.categoryId == 27
                              ? Container()
                              :
                          Text(
                            (widget.data?.ad!.price ?? 0) > 0
                                ? '${widget.data?.ad!.price?.toString() ?? ''} ${widget.data?.ad!.currency ?? ''}'
                                : '${translate('price_not_announced')}',
                            style: AppStyle.smallTitleStyle.copyWith(
                              color:
                              AppColorsController().textPrimaryColor,
                              fontWeight: AppFontWeight.midLight,
                            ),
                          ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LikeButtonWidget(
                          isLike: widget.data?.ad?.is_liked == 0 ? false : true,
                          adsId: widget.data?.ad?.ad_id,
                          index: widget.index,
                          likes: widget.data?.ad!.likes,
                          onChanged: widget.onPressedLike,
                          onChangedLoader: widget.onPressedLoader,
                        ),
                        Row(
                          children: [
                            Text(
                              translate("evaluate") + " :",
                              style: AppStyle.smallTitleStyle.copyWith(
                                color: AppColorsController().textPrimaryColor,
                                fontWeight: AppFontWeight.midLight,
                              ),
                            ),
                            SizedBox(
                              width: 8.sp,
                            ),
                            EvaluateUserButtonWidget(
                              onChanged: widget.onPressedAddComment,
                              adId: widget.id,
                              isAds: true,
                              onChangedLoader: widget.onPressedLoader,
                            ),
                          ],
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 8.sp,
                    // ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          translate("status") + ":",
                          style: AppStyle.smallTitleStyle.copyWith(
                            color: AppColorsController().textPrimaryColor,
                            fontWeight: AppFontWeight.midLight,
                          ),
                        ),
                        SizedBox(
                          width: 8.sp,
                        ),
                        Text(
                          widget.data!.ad!.availability_status.toString() ==
                                  null
                              ? "متاح"
                              : "متاح",
                          style: AppStyle.smallTitleStyle.copyWith(
                            color: AppColorsController().black,
                            fontWeight: AppFontWeight.midLight,
                          ),
                        ),
                        Spacer(),
                        widget.typeAds == 'jobAds' ||
                                widget.typeAds == 'adsWithoutImage' ||
                                widget.categoryId == 27
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FavouritesButtonWidget(
                                    isFromPageFavourite: true,
                                    onChanged: widget.onPressedFavourite,
                                    onChangedLoader: widget.onPressedLoader,
                                    adsId: widget.data?.ad?.ad_id,
                                    isFavourite:
                                        widget.data?.ad?.is_favorite == 0
                                            ? false
                                            : true,
                                    index: widget.index,
                                  ),
                                  SizedBox(
                                    width: 4.sp,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.sp),
                                    child: InkWell(
                                      onTap: () {
                                        Share.share(
                                            widget.data!.sharing_link ?? '');
                                      },
                                      child: ShareIcon(
                                        height: 21.sp,
                                        width: 21.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),

                    // Row(
                    //   children: [
                    //     Text(
                    //       translate("evaluate") + " :",
                    //       style: AppStyle.smallTitleStyle.copyWith(
                    //         color: AppColorsController().textPrimaryColor,
                    //         fontWeight: AppFontWeight.midLight,
                    //       ),
                    //     ),
                    //
                    //     SizedBox(
                    //       width: 8.sp,
                    //     ),
                    //     EvaluateUserButtonWidget(
                    //       onChanged: widget.onPressedAddComment,
                    //       adId: widget.id,
                    //       isAds: true,
                    //       onChangedLoader: widget.onPressedLoader,
                    //     ),
                    //   ],
                    // ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          translate("posted_on") + " :",
                          style: AppStyle.smallTitleStyle.copyWith(
                            color: AppColorsController().textPrimaryColor,
                            fontWeight: AppFontWeight.midLight,
                          ),
                        ),
                        SizedBox(
                          width: 8.sp,
                        ),
                        Text(
                          widget.data?.ad!.created_at != null
                              ? translate("since") +
                                  " " +
                                  getComparedTime(widget.data!.ad!.created_at!)
                                      .toString()
                              : "",
                          style: AppStyle.smallTitleStyle.copyWith(
                            color: AppColorsController().black,
                            fontWeight: AppFontWeight.midLight,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 2.sp,
                    ),
                    (widget.data?.properties?.length ?? 0) == 0 ||
                            widget.typeAds == 'jobAds' ||
                            widget.typeAds == 'adsWithoutImage' ||
                            widget.categoryId == 27
                        ? Container()
                        : _isSeeMore == false
                            ? InkWell(
                                child: Center(
                                  child: Container(
                                    width: 100.sp,
                                    decoration: BoxDecoration(
                                      color: AppColorsController()
                                          .containerPrimaryColor,
                                      border: Border.all(
                                        color: AppColorsController()
                                            .borderGrayColor,
                                        width: 0.2.sp,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            Dimens.defaultBorderRadius),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        translate("see_more"),
                                        style: AppStyle.verySmallTitleStyle
                                            .copyWith(
                                          color: AppColorsController().black,
                                          fontWeight: AppFontWeight.midLight,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    _isSeeMore = !_isSeeMore;
                                  });
                                },
                              )
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    _isSeeMore = !_isSeeMore;
                                  });
                                },
                                child: Center(
                                  child: Container(
                                    width: 100.sp,
                                    decoration: BoxDecoration(
                                      color: AppColorsController()
                                          .containerPrimaryColor,
                                      border: Border.all(
                                        color: AppColorsController()
                                            .borderGrayColor,
                                        width: 0.2.sp,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            Dimens.defaultBorderRadius),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        translate("see_less"),
                                        style: AppStyle.verySmallTitleStyle
                                            .copyWith(
                                          color: AppColorsController().black,
                                          fontWeight: AppFontWeight.midLight,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                    SizedBox(
                      height: 2.sp,
                    ),
                  ],
                ),
              ),

              //see_less

              widget.typeAds == 'jobAds' ||
                      widget.typeAds == 'adsWithoutImage' ||
                      widget.categoryId == 27
                  ? SeeMorePropertiesWidget(
                      isSeeMore: true,
                      properties: widget.data?.properties,
                    )
                  : SeeMorePropertiesWidget(
                      isSeeMore: _isSeeMore,
                      properties: widget.data?.properties,
                    ),
              SizedBox(
                height: 8.sp,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
                decoration: BoxDecoration(
                  color: AppColorsController().containerPrimaryColor,
                  border: Border.all(
                    color: AppColorsController().borderGrayColor,
                    width: 0.2.sp,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimens.defaultBorderRadius),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translate("product_description") + ":",
                      style: AppStyle.smallTitleStyle.copyWith(
                        color: AppColorsController().textPrimaryColor,
                        fontWeight: AppFontWeight.midLight,
                      ),
                    ),
                    SizedBox(
                      height: 4.sp,
                    ),
                    Text(
                      widget.data?.ad!.short_description ?? "",
                      style: AppStyle.smallTitleStyle.copyWith(
                        color: AppColorsController().black,
                        fontWeight: AppFontWeight.midLight,
                      ),
                    ),
                  ],
                ),
              ),
              RatingsWidget(
                ratings: widget.data?.ratings,
              ),
              SizedBox(
                height: 20.sp,
              ),

              if (DIManager.findDep<SharedPrefs>().getToken()?.isEmpty ==
                  false) ...[
                DIManager.findDep<SharedPrefs>().getUserID()! ==
                        widget.data!.ad!.user_id.toString()
                    ? Container()
                    : Center(
                        child: AppButton(
                          height: 48.sp,
                          width: 240.sp,
                          borderRadiusCircular: 16.sp,
                          childPadding: EdgeInsets.symmetric(horizontal: 24.sp),
                          onPressed: () {
                            if (!AppUtils.checkIfGuest(context)) {
                              DIManager.findNavigator().pushNamed(
                                  ChatMessagesPage.routeName,
                                  arguments: ArgumentMessage(
                                    user_id_2: widget.data?.ad!.user_id,
                                    ad_id: widget.data?.ad!.ad_id,
                                    imageAds: widget.typeAds == 'jobAds' ||
                                            widget.typeAds ==
                                                'adsWithoutImage' ||
                                            widget.categoryId == 27
                                        ? widget.data?.ad!.image_name
                                            ?.toString()
                                        : widget.data?.ad!.featured_image
                                            ?.toString(),
                                    nameAds: widget.data?.ad!.title ?? '',
                                    nameOwnerAds:
                                        widget.data?.ad!.user_name ?? '',
                                    adsIsJob: widget.typeAds == 'jobAds' ||
                                            widget.typeAds ==
                                                'adsWithoutImage' ||
                                            widget.categoryId == 27
                                        ? true
                                        : false,
                                    user_name_person_sender:
                                        DIManager.findDep<SharedPrefs>()
                                            .getUserNamePerson()
                                            .toString(),
                                    user_id: DIManager.findDep<SharedPrefs>()
                                        .getUserID()
                                        .toString(),
                                  ));
                            }

                            // if (!AppUtils.checkIfGuest(context)) {
                            //   DIManager.findNavigator().pushNamed(
                            //       ChatMessagesPage.routeName,
                            //       arguments: ArgumentMessage(
                            //           user_id_2: widget.data?.ad?.user_id,
                            //           ad_id: widget.data?.ad?.ad_id));
                            // }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 70.sp,
                              ),
                              Text(
                                translate("chat"),
                                style: AppStyle.smallTitleStyle.copyWith(
                                  color: AppColorsController().textPrimaryColor,
                                  fontWeight: AppFontWeight.midLight,
                                ),
                              ),
                              SizedBox(
                                width: 25.sp,
                              ),
                              ChatIcon(),
                            ],
                          ),
                        ),
                      ),
              ] else ...[
                Center(
                  child: AppButton(
                    height: 48.sp,
                    width: 240.sp,
                    borderRadiusCircular: 16.sp,
                    childPadding: EdgeInsets.symmetric(horizontal: 24.sp),
                    onPressed: () {
                      if (!AppUtils.checkIfGuest(context)) {
                        DIManager.findNavigator().pushNamed(
                            ChatMessagesPage.routeName,
                            arguments: ArgumentMessage(
                              user_id_2: widget.data?.ad!.user_id,
                              ad_id: widget.data?.ad!.ad_id,
                              imageAds: widget.typeAds == 'jobAds' ||
                                      widget.typeAds == 'adsWithoutImage' ||
                                      widget.categoryId == 27
                                  ? widget.data?.ad!.image_name?.toString()
                                  : widget.data?.ad!.featured_image?.toString(),
                              nameAds: widget.data?.ad!.title ?? '',
                              nameOwnerAds: widget.data?.ad!.user_name ?? '',
                              adsIsJob: widget.typeAds == 'jobAds' ||
                                      widget.typeAds == 'adsWithoutImage' ||
                                      widget.categoryId == 27
                                  ? true
                                  : false,
                              user_name_person_sender:
                                  DIManager.findDep<SharedPrefs>()
                                      .getUserNamePerson()
                                      .toString(),
                              user_id: DIManager.findDep<SharedPrefs>()
                                  .getUserID()
                                  .toString(),
                            ));
                      }

                      // if (!AppUtils.checkIfGuest(context)) {
                      //   DIManager.findNavigator().pushNamed(
                      //       ChatMessagesPage.routeName,
                      //       arguments: ArgumentMessage(
                      //           user_id_2: widget.data?.ad?.user_id,
                      //           ad_id: widget.data?.ad?.ad_id));
                      // }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 70.sp,
                        ),
                        Text(
                          translate("chat"),
                          style: AppStyle.smallTitleStyle.copyWith(
                            color: AppColorsController().textPrimaryColor,
                            fontWeight: AppFontWeight.midLight,
                          ),
                        ),
                        SizedBox(
                          width: 25.sp,
                        ),
                        ChatIcon(),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
