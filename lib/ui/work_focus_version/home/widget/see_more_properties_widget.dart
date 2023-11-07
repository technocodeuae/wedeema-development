import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../data/models/ads_details/entity/ads_details_entity.dart';
class SeeMorePropertiesWidget extends StatelessWidget {
     final bool? isSeeMore;
     final List<CategoryAdsDetailsEntity>? properties;
     final bool? haveContainer;

  const SeeMorePropertiesWidget({Key? key,this.properties,this.isSeeMore,this.haveContainer = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      child:  (isSeeMore== false ||
          properties!.length == 0)
          ? Container()
          : Column(
        children: [
          SizedBox(
            height: 8.sp,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 20.sp, vertical: 10.sp),
            decoration: haveContainer == true? BoxDecoration(
              color: AppColorsController()
                  .containerPrimaryColor,
              border: Border.all(
                color: AppColorsController()
                    .borderGrayColor,
                width: 0.2,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                    Dimens.defaultBorderRadius),
              ),
            ):BoxDecoration(
              color: Colors.transparent
            ),
            child: ListView.separated(
              itemBuilder: (BuildContext context,
                  int index) {
                return Row(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      children: [
                        Text(
                          "${properties![index].title}:",
                          style: AppStyle
                              .smallTitleStyle
                              .copyWith(
                            color:
                            AppColorsController()
                                .textPrimaryColor,
                            fontSize: AppFontSize.fontSize_12,
                            fontWeight:
                            AppFontWeight
                                .midLight,overflow: TextOverflow.ellipsis,
                          ),maxLines: 1,
                        ),
                        SizedBox(
                          width: 8.sp,
                        ),
                        Text(
                          properties![index]
                              .description
                              .toString(),
                          style: AppStyle
                              .smallTitleStyle
                              .copyWith(
                            color:
                            AppColorsController()
                                .black, fontSize: AppFontSize.fontSize_13,
                            fontWeight:
                            AppFontWeight
                                .midLight,overflow: TextOverflow.ellipsis,
                          ),maxLines: 1,
                        ),
                      ],
                    ),
                  ],
                );
              },
              separatorBuilder:
                  (BuildContext context,
                  int index) {
                return SizedBox(height: 4.sp);
              },
              itemCount: properties!.length!,
              physics:
              NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            ),
          ),
        ],
      )
    );
  }
}
