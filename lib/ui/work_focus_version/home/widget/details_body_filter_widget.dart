import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/ui/work_focus_version/home/widget/see_more_properties_widget.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/utils/app_general_utils.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../data/models/ads/entity/ads_entity.dart';
import '../../ads/widget/like_button_widget.dart';
import '../../chat/args/argument_message.dart';
import '../../chat/pages/chat_messages_page.dart';
import '../../general/buttons/app_button.dart';
import '../../general/icons/chat_icon.dart';
import '../../profile/widget/evaluate_user_button_widget.dart';
import '../arg/items_args.dart';
import '../pages/items_details_page.dart';
import 'home_items_widget.dart';
import 'image_slider_show_widget.dart';

class DetailsBodyFilterWidget extends StatefulWidget {
  final ItemsAdsEntity? data;
  final int? id;
  final int? index;
  final Function(bool, int)? onPressedLike;
  final Function(bool, int)? onPressedFavourite;
  final Function(bool)? onPressedLoader;
  // final Function(bool)? onPressedCommite;

  const DetailsBodyFilterWidget(
      {Key? key,
      this.data,
      this.id,
      this.index,
      this.onPressedFavourite,
      this.onPressedLoader,
      this.onPressedLike,

        // this.onPressedCommite
      })
      : super(key: key);

  @override
  State<DetailsBodyFilterWidget> createState() => _DetailsBodyFilterWidgetState();
}

class _DetailsBodyFilterWidgetState extends State<DetailsBodyFilterWidget> {
  @override
  Widget build(BuildContext context) {
    bool _isSeeMore = false;




    return InkWell(
      onTap: (){

        DIManager.findNavigator().pushNamed(
          ItemsDetailsPage.routeName,
          arguments: ItemsArgs(
            id: widget.data!.ad_id,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ImageSliderShowWidget(
            imagesList: widget.data?.ad_images,
            onChangedLoader:widget.onPressedLoader,
            isAllDetails: true,
            is_favorite: widget.data?.is_favorite,
            ad_id: widget.data?.ad_id,
            onChanged: widget.onPressedFavourite,
            index: widget.index,
            adsUrlShare: widget.data?.sharing_link,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.sp,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.sp, vertical: 2.sp),
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.data!.title.toString(),
                            style: AppStyle.smallTitleStyle.copyWith(
                              color: AppColorsController().black,
                              fontWeight: AppFontWeight.midLight,
                            ),

                          ),

                          Text(
                            widget.data!.price.toString() + " درهم إماراتي",
                            style: AppStyle.smallTitleStyle.copyWith(
                              color: AppColorsController().textPrimaryColor,
                              fontWeight: AppFontWeight.midLight,
                            ),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 2.sp,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LikeButtonWidget(
                            onChanged: widget.onPressedLike,
                            isLike: widget.data?.is_liked == 0 ? false : true,
                            adsId: widget.data?.ad_id,
                            index: widget.index,
                            likes: widget.data?.likes,
                            onChangedLoader: widget.onPressedLoader,
                          ),

                          // EvaluateUserButtonWidget(
                          //   onChanged: data.onPressedAddComment,
                          //   adId: data?.ad_id,
                          //   isAds: true,
                          //   onChangedLoader: onPressedLoader,
                          // ),


                        ],
                      ),
                      SizedBox(
                        height: 2.sp,
                      ),
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                                    widget.data!.availability_status.toString(),
                                    style: AppStyle.smallTitleStyle.copyWith(
                                      color: AppColorsController().black,
                                      fontWeight: AppFontWeight.midLight,
                                    ),
                                  ),
                                ],
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

                            ],
                          ),
                          SizedBox(
                            height: 4.sp,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                translate("posted_on") + ":",
                                style: AppStyle.smallTitleStyle.copyWith(
                                  color: AppColorsController().textPrimaryColor,
                                  fontWeight: AppFontWeight.midLight,
                                ),
                              ),
                              SizedBox(
                                width: 8.sp,
                              ),
                              Text(
                                widget.data?.created_at != null
                                    ? getComparedTime(widget.data!.created_at!)
                                        .toString()!
                                    : "",
                                style: AppStyle.smallTitleStyle.copyWith(
                                  color: AppColorsController().black,
                                  fontWeight: AppFontWeight.midLight,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.sp,),
                  decoration: BoxDecoration(color: Colors.transparent),
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

                      Text(
                        widget.data?.short_description ?? "",overflow: TextOverflow.ellipsis,maxLines: 2,
                        style: AppStyle.smallTitleStyle.copyWith(
                          color: AppColorsController().black,
                          fontWeight: AppFontWeight.midLight,
                        ),
                      ),
                    ],
                  ),
                ),


                SeeMorePropertiesWidget(
                  isSeeMore: _isSeeMore,
                  properties: widget.data?.properties,
                ),
                SizedBox(
                  height: 4.sp,
                ),
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
                                user_id_2: widget.data?.user_id, ad_id: widget.data?.ad_id));
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
                          width: 40.sp,
                        ),
                        ChatIcon(
                        ),
                      ],
                    ),
                  ),
                ),  SizedBox(
                  height: 4.sp,
                ),
                // Center(
                //   child: AppButton(
                //     height: 48.sp,
                //     width: 230.sp,
                //     childPadding: EdgeInsets.symmetric(horizontal: 24.sp),
                //     onPressed: () {
                //       if (!AppUtils.checkIfGuest(context)) {
                //         DIManager.findNavigator().pushNamed(
                //             ChatMessagesPage.routeName,
                //             arguments: ArgumentMessage(
                //                 user_id_2: data?.user_id, ad_id: data?.ad_id));
                //       }
                //     },
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: [
                //         ChatIcon(
                //           width: 26.sp,
                //         ),
                //         SizedBox(
                //           width: 45.sp,
                //         ),
                //         Text(
                //           translate("chat"),
                //           style: AppStyle.smallTitleStyle.copyWith(
                //             color: AppColorsController().textPrimaryColor,
                //             fontWeight: AppFontWeight.midLight,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
