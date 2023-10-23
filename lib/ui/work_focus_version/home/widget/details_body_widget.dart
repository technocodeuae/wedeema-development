import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/utils/app_general_utils.dart';
import 'package:wadeema/ui/work_focus_version/home/widget/ratings_widget.dart';
import 'package:wadeema/ui/work_focus_version/home/widget/see_more_properties_widget.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../data/models/ads_details/entity/ads_details_entity.dart';
import '../../ads/widget/like_button_widget.dart';
import '../../chat/args/argument_message.dart';
import '../../chat/pages/chat_messages_page.dart';
import '../../general/buttons/app_button.dart';
import '../../general/icons/chat_icon.dart';
import '../../profile/widget/evaluate_user_button_widget.dart';
import 'home_items_widget.dart';
import 'image_slider_show_widget.dart';

class DetailsBodyWidget extends StatefulWidget {
  final AdsDetailsEntity? data;
  final int? id;
  final int? index;
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
    this.index,
    this.onPressedAddComment,
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
    return Column(
      children: [
        ImageSliderShowWidget(
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
          ),
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
                            fontWeight: AppFontWeight.midLight,fontSize: AppFontSize.fontSize_14
                          ),
                        ),
                        Text(
                          widget.data!.ad!.price.toString() + " درهم إماراتي",
                          style: AppStyle.smallTitleStyle.copyWith(
                            color: AppColorsController().textPrimaryColor,
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
                              widget.data!.ad!.availability_status.toString() == null ?"متاح":"متاح",
                              style: AppStyle.smallTitleStyle.copyWith(
                                color: AppColorsController().black,
                                fontWeight: AppFontWeight.midLight,
                              ),
                            ),
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
                              ? translate("since") +" "+ getComparedTime(widget.data!.ad!.created_at!)
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
                    (widget.data?.properties?.length??0) == 0
                        ? Container()
                        : _isSeeMore == false
                        ? InkWell(
                      child: Center(
                        child: Container(
                          width: 100.sp,
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
                          child: Center(
                            child: Text(
                              translate("see_more"),
                              style:
                              AppStyle.verySmallTitleStyle.copyWith(
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
                            color: AppColorsController().containerPrimaryColor,
                            border: Border.all(
                              color: AppColorsController().borderGrayColor,
                              width: 0.2.sp,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(Dimens.defaultBorderRadius),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              translate("see_less"),
                              style:
                              AppStyle.verySmallTitleStyle.copyWith(
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

              SeeMorePropertiesWidget(
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
              SizedBox(height: 20.sp,),
              Center(
                child: AppButton(
                  height: 48.sp,
                  width: 240.sp,borderRadiusCircular: 16.sp,
                  childPadding: EdgeInsets.symmetric(horizontal: 24.sp),
                  onPressed: () {
                    if (!AppUtils.checkIfGuest(context)) {
                      DIManager.findNavigator().pushNamed(
                          ChatMessagesPage.routeName,
                          arguments: ArgumentMessage(
                              user_id_2: widget.data?.ad?.user_id,
                              ad_id: widget.data?.ad?.ad_id));
                    }
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
                      ChatIcon(
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
