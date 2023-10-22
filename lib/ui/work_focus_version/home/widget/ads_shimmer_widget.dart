import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../arg/view_all_args.dart';
import '../pages/view_all_page.dart';

class AdsShimmerWidget extends StatelessWidget {
  final String name;
  final int type;
  final bool? is_category;

  const AdsShimmerWidget(
      {Key? key, required this.name, this.is_category, required this.type})
      : super(key: key);


  /*

  GridView.builder(
                    itemCount: 4,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            ),
                        height: 180.sp,
                        width: 400.sp,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColorsController().black, width: 0.2),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Shimmer.fromColors(
                                      baseColor: Color(0x99FED0D3),
                                      highlightColor: Color(0x99DE0F17),
                                      child: Container(
                                        child: ClipOval(
                                          child: Container(
                                            color: AppColorsController()
                                                .containerPrimaryColor,
                                            width: 32.sp,
                                            height: 32.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4.sp,
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.sp),
                                      height: 2.sp,
                                      width: 12.sp,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColorsController()
                                                .containerPrimaryColor,
                                            width: 0.2),
                                        color: AppColorsController()
                                            .containerPrimaryColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2.sp),
                                    height: 2.sp,
                                    width: 40.sp,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColorsController()
                                              .containerPrimaryColor,
                                          width: 0.2),
                                      color: AppColorsController()
                                          .containerPrimaryColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12.sp),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.sp,
                              ),
                              Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    child: Container(
                                      width: 154.sp,
                                      height: 102.sp,
                                      color: AppColorsController()
                                          .containerPrimaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.sp,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.sp),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.sp),
                                            height: 2.sp,
                                            width: 40.sp,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColorsController()
                                                      .containerPrimaryColor,
                                                  width: 0.2),
                                              color: AppColorsController()
                                                  .containerPrimaryColor,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12.sp),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.sp),
                                            height: 2.sp,
                                            width: 40.sp,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColorsController()
                                                      .containerPrimaryColor,
                                                  width: 0.2),
                                              color: AppColorsController()
                                                  .containerPrimaryColor,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12.sp),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.sp,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.sp),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.sp),
                                      height: 2.sp,
                                      width: 40.sp,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColorsController()
                                                .containerPrimaryColor,
                                            width: 0.2),
                                        color: AppColorsController()
                                            .containerPrimaryColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 210.sp,
                      crossAxisSpacing: 6.sp,
                      mainAxisSpacing: 18.sp,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                  )
   */
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          is_category == true
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name.toString(),
                      style: AppStyle.verySmallTitleStyle.copyWith(
                          color: AppColorsController().textPrimaryColor,
                          fontWeight: AppFontWeight.midLight,
                          fontSize: AppFontSize.fontSize_14),
                    ),
                    InkWell(
                      onTap: () {
                        DIManager.findNavigator().pushNamed(
                          ViewAllPage.routeName,
                          arguments: ViewAllArgs(
                            type: type,
                          ),
                        );
                      },
                      child: Text(
                        translate("view_all"),
                        style: AppStyle.verySmallTitleStyle.copyWith(
                            color: AppColorsController().textPrimaryColor,
                            fontWeight: AppFontWeight.midLight,
                            fontSize: AppFontSize.fontSize_14),
                      ),
                    ),
                  ],
                ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.sp),
            child: name == translate('ads')
                ? GridView.builder(
              itemCount: 4,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(
                  ),
                  height: 180.sp,
                  width: 400.sp,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColorsController().black, width: 0.2),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Shimmer.fromColors(
                                baseColor: Color(0x99FED0D3),
                                highlightColor: Color(0x99DE0F17),
                                child: Container(
                                  child: ClipOval(
                                    child: Container(
                                      color: AppColorsController()
                                          .containerPrimaryColor,
                                      width: 32.sp,
                                      height: 32.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 4.sp,
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.sp),
                                height: 2.sp,
                                width: 12.sp,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColorsController()
                                          .containerPrimaryColor,
                                      width: 0.2),
                                  color: AppColorsController()
                                      .containerPrimaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.sp),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding:
                              EdgeInsets.symmetric(horizontal: 2.sp),
                              height: 2.sp,
                              width: 40.sp,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColorsController()
                                        .containerPrimaryColor,
                                    width: 0.2),
                                color: AppColorsController()
                                    .containerPrimaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.sp,
                        ),
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              child: Container(
                                width: 154.sp,
                                height: 102.sp,
                                color: AppColorsController()
                                    .containerPrimaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 4.sp,
                            ),
                            Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: 16.sp),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.sp),
                                      height: 2.sp,
                                      width: 40.sp,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColorsController()
                                                .containerPrimaryColor,
                                            width: 0.2),
                                        color: AppColorsController()
                                            .containerPrimaryColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.sp),
                                      height: 2.sp,
                                      width: 40.sp,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColorsController()
                                                .containerPrimaryColor,
                                            width: 0.2),
                                        color: AppColorsController()
                                            .containerPrimaryColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 4.sp,
                            ),
                            Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: 16.sp),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.sp),
                                height: 2.sp,
                                width: 40.sp,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColorsController()
                                          .containerPrimaryColor,
                                      width: 0.2),
                                  color: AppColorsController()
                                      .containerPrimaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.sp),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 210.sp,
                crossAxisSpacing: 6.sp,
                mainAxisSpacing: 18.sp,
              ),
              physics: NeverScrollableScrollPhysics(),
            )
                : name == translate('adsJob')
                    ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: 4,
                shrinkWrap: true,

                itemBuilder: (context, index) {

                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                        ),
                        height: 180.sp,
                        width: 400.sp,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColorsController().black, width: 0.2),
                          color: AppColorsController().containerPrimaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.sp),
                          ),
                        ),
                        child: Shimmer.fromColors(
                          baseColor: Color(0x99FED0D3),
                          highlightColor: Color(0x99DE0F17),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.sp),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.,
                                  children: [

                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 2.sp),
                                      height: 3.sp,
                                      width: 80.sp,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColorsController()
                                                .containerPrimaryColor,
                                            width: 0.2),
                                        color: AppColorsController()
                                            .containerPrimaryColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12.sp),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30.sp,
                                    ),
                                    Shimmer.fromColors(
                                      baseColor: Color(0x99FED0D3),
                                      highlightColor: Color(0x99DE0F17),
                                      child: Container(
                                        child: ClipOval(
                                          child: Container(
                                            color: AppColorsController()
                                                .containerPrimaryColor,
                                            width: 32.sp,
                                            height: 32.sp,
                                          ),
                                        ),
                                      ),
                                    ),


                                    // Container(
                                    //   padding:
                                    //       EdgeInsets.symmetric(horizontal: 2.sp),
                                    //   height: 2.sp,
                                    //   width: 40.sp,
                                    //   decoration: BoxDecoration(
                                    //     border: Border.all(
                                    //         color: AppColorsController()
                                    //             .containerPrimaryColor,
                                    //         width: 0.2),
                                    //     color: AppColorsController()
                                    //         .containerPrimaryColor,
                                    //     borderRadius: BorderRadius.all(
                                    //       Radius.circular(12.sp),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 4.sp,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 2.sp),
                                      height: 3.sp,
                                      width: 300.sp,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColorsController()
                                                .containerPrimaryColor,
                                            width: 0.2),
                                        color: AppColorsController()
                                            .containerPrimaryColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12.sp),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 2.sp),
                                      height: 3.sp,
                                      width: 200.sp,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColorsController()
                                                .containerPrimaryColor,
                                            width: 0.2),
                                        color: AppColorsController()
                                            .containerPrimaryColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12.sp),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 2.sp),
                                      height: 3.sp,
                                      width: 100.sp,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColorsController()
                                                .containerPrimaryColor,
                                            width: 0.2),
                                        color: AppColorsController()
                                            .containerPrimaryColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12.sp),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.sp,
                                    ),
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8.sp),
                                          ),
                                          child: Container(
                                            width: 32.sp,
                                            height: 32.sp,
                                            color: AppColorsController()
                                                .containerPrimaryColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4.sp,
                                        ),
                                        Container(
                                          padding:
                                          EdgeInsets.symmetric(horizontal: 2.sp),
                                          height: 2.sp,
                                          width: 50.sp,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColorsController()
                                                    .containerPrimaryColor,
                                                width: 0.2),
                                            color: AppColorsController()
                                                .containerPrimaryColor,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12.sp),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4.sp,
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8.sp),
                                          ),
                                          child: Container(
                                            width: 32.sp,
                                            height: 32.sp,
                                            color: AppColorsController()
                                                .containerPrimaryColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4.sp,
                                        ),
                                        Container(
                                          padding:
                                          EdgeInsets.symmetric(horizontal: 2.sp),
                                          height: 2.sp,
                                          width: 50.sp,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColorsController()
                                                    .containerPrimaryColor,
                                                width: 0.2),
                                            color: AppColorsController()
                                                .containerPrimaryColor,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12.sp),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.sp,)
                    ],
                  );
                },

                physics: NeverScrollableScrollPhysics(),
              ),
            )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 190.sp,
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2.sp, horizontal: 10.sp),
                              height: 180.sp,
                              width: 190.sp,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColorsController().black,
                                    width: 0.2),
                                color:
                                    AppColorsController().containerPrimaryColor,
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Shimmer.fromColors(
                                            baseColor: Color(0x99FED0D3),
                                            highlightColor: Color(0x99DE0F17),
                                            child: Container(
                                              child: ClipOval(
                                                child: Container(
                                                  color: AppColorsController()
                                                      .containerPrimaryColor,
                                                  width: 32.sp,
                                                  height: 32.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4.sp,
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.sp),
                                            height: 2.sp,
                                            width: 12.sp,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColorsController()
                                                      .containerPrimaryColor,
                                                  width: 0.2),
                                              color: AppColorsController()
                                                  .containerPrimaryColor,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12.sp),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.sp),
                                          height: 2.sp,
                                          width: 40.sp,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColorsController()
                                                    .containerPrimaryColor,
                                                width: 0.2),
                                            color: AppColorsController()
                                                .containerPrimaryColor,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12.sp),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4.sp,
                                    ),
                                    Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          child: Container(
                                            width: 154.sp,
                                            height: 102.sp,
                                            color: AppColorsController()
                                                .containerPrimaryColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.sp,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.sp),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 2.sp),
                                                  height: 2.sp,
                                                  width: 40.sp,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColorsController()
                                                            .containerPrimaryColor,
                                                        width: 0.2),
                                                    color: AppColorsController()
                                                        .containerPrimaryColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(12.sp),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 2.sp),
                                                  height: 2.sp,
                                                  width: 40.sp,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColorsController()
                                                            .containerPrimaryColor,
                                                        width: 0.2),
                                                    color: AppColorsController()
                                                        .containerPrimaryColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(12.sp),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4.sp,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16.sp),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.sp),
                                            height: 2.sp,
                                            width: 40.sp,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColorsController()
                                                      .containerPrimaryColor,
                                                  width: 0.2),
                                              color: AppColorsController()
                                                  .containerPrimaryColor,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(12.sp),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
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
          ),
        ],
      ),
    );
  }
}
