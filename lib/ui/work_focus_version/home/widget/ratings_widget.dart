import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../data/models/ads_details/entity/ads_details_entity.dart';
import '../../general/icons/account_icon.dart';
import '../../profile/args/other_args.dart';
import '../../profile/pages/client_account_page.dart';
import 'build_circular_image_user.dart';
class RatingsWidget extends StatelessWidget {
  final List<RatingAdsDetailsEntity>? ratings;
  final bool? haveContainer;

  const RatingsWidget({Key? key,this.ratings,this.haveContainer = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ratings!.length!=0?Column(
        children: [
          SizedBox(
            height: 8.sp,
          ),
          Container(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {


                    print("evaluator_id" + ratings![index].evaluator_id.toString());
                    DIManager.findNavigator().pushNamed(
                        ClientAccountPage.routeName,
                        arguments: ratings![index].evaluator_id
                    );


                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width-40),

                    padding: EdgeInsets.symmetric(
                        horizontal: 20.sp, vertical: 10.sp),
                    decoration: haveContainer == true?BoxDecoration(
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
                    ):BoxDecoration(
                      color: Colors.transparent
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: [

                            BuildCircularImageUser(
                              url: ratings![index].user_profile_pic,
                              id: ratings![index].evaluator_id,
                              size: 38.sp,
                            ),

                            SizedBox(
                              width: 12.sp,
                            ),
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ratings![index].user_name.toString(),
                                  style: AppStyle
                                      .smallTitleStyle
                                      .copyWith(
                                    color:
                                    AppColorsController()
                                        .black,
                                    fontWeight: AppFontWeight
                                        .midLight,
                                  ),
                                ),
                                SizedBox(
                                  width: 12.sp,
                                ),
                                Container(
                                  child: RatingBarIndicator(
                                    rating: ratings![index]!.value!.toDouble(),
                                    itemCount: 5,
                                    itemSize: 18.sp,
                                    unratedColor:
                                    AppColorsController()
                                        .darkGreyTextColor,
                                    direction:
                                    Axis.horizontal,
                                    itemBuilder:
                                        (context, _) => Icon(
                                      Icons.star,
                                      size: 13.sp,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        Text(
                          ratings![index].comment.toString(),
                          style: AppStyle.smallTitleStyle
                              .copyWith(
                            color:
                            AppColorsController().black,
                            fontWeight:
                            AppFontWeight.midLight,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 4.sp,
                );
              },
              itemCount: ratings!.length!,
              scrollDirection: Axis.horizontal,
            ),
            width: MediaQuery.of(context).size.width,
            height: 100.sp,
          ),

        ],
      ):Container(),
    );
  }
}
