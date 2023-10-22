import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';

class LookingWidgetShimmer extends StatelessWidget {

  final String name;

  const LookingWidgetShimmer({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.sp),
      child: Column(
        children: [
          name == 'ads' ? Container():  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name == 'ads' ? '':name,
                style: AppStyle.verySmallTitleStyle.copyWith(
                  color: AppColorsController().textPrimaryColor,
                  fontWeight: AppFontWeight.midLight,fontSize: AppFontSize.fontSize_14
                ),
              ),
            ],
          ),

          name == 'ads'? Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 95.sp,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.sp),
                      height:  90.sp,
                      width: 100.sp,
                      decoration: BoxDecoration(
                        border:
                        Border.all(color: AppColorsController().black, width: 0.2),
                        color: AppColorsController().containerPrimaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.sp),
                        ),
                      ),
                      child: Shimmer.fromColors(
                        baseColor: Color(0x99FED0D3),
                        highlightColor: Color(0x99DE0F17),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 2.sp),
                              height: 34.sp,
                              width: 34.sp,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColorsController().containerPrimaryColor, width: 0.2),
                                color: AppColorsController().containerPrimaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.sp),
                                ),
                              ),
                            ),
                            SizedBox(height: 8.sp,),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 2.sp),
                              height: 2.sp,
                              width: 30.sp,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColorsController().containerPrimaryColor, width: 0.2),
                                color: AppColorsController().containerPrimaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 16.sp,
                    );
                  },
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(
                height: 12.sp,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 95.sp,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.sp),
                      height:  90.sp,
                      width: 100.sp,
                      decoration: BoxDecoration(
                        border:
                        Border.all(color: AppColorsController().black, width: 0.2),
                        color: AppColorsController().containerPrimaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.sp),
                        ),
                      ),
                      child: Shimmer.fromColors(
                        baseColor: Color(0x99FED0D3),
                        highlightColor: Color(0x99DE0F17),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 2.sp),
                              height: 34.sp,
                              width: 34.sp,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColorsController().containerPrimaryColor, width: 0.2),
                                color: AppColorsController().containerPrimaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.sp),
                                ),
                              ),
                            ),
                            SizedBox(height: 30.sp,),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 2.sp),
                              height: 2.sp,
                              width: 40.sp,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColorsController().containerPrimaryColor, width: 0.2),
                                color: AppColorsController().containerPrimaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 16.sp,
                    );
                  },
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ): Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.sp),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 71.sp,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.sp),
                        height:  71.sp,
                        width: 71.sp,
                        decoration: BoxDecoration(
                          border:
                          Border.all(color: AppColorsController().black, width: 0.2),
                          color: AppColorsController().containerPrimaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.sp),
                          ),
                        ),
                        child: Shimmer.fromColors(
                          baseColor: Color(0x99FED0D3),
                          highlightColor: Color(0x99DE0F17),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 2.sp),
                                height: 34.sp,
                                width: 34.sp,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColorsController().containerPrimaryColor, width: 0.2),
                                  color: AppColorsController().containerPrimaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.sp),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.sp,),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 2.sp),
                                height: 2.sp,
                                width: 30.sp,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColorsController().containerPrimaryColor, width: 0.2),
                                  color: AppColorsController().containerPrimaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 16.sp,
                      );
                    },
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                SizedBox(
                  height: 12.sp,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 71.sp,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.sp),
                        height:  71.sp,
                        width: 71.sp,
                        decoration: BoxDecoration(
                          border:
                          Border.all(color: AppColorsController().black, width: 0.2),
                          color: AppColorsController().containerPrimaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.sp),
                          ),
                        ),
                        child: Shimmer.fromColors(
                          baseColor: Color(0x99FED0D3),
                          highlightColor: Color(0x99DE0F17),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 2.sp),
                                height: 34.sp,
                                width: 34.sp,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColorsController().containerPrimaryColor, width: 0.2),
                                  color: AppColorsController().containerPrimaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.sp),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.sp,),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 2.sp),
                                height: 2.sp,
                                width: 40.sp,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColorsController().containerPrimaryColor, width: 0.2),
                                  color: AppColorsController().containerPrimaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 16.sp,
                      );
                    },
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
