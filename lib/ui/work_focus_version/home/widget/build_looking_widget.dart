import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../data/models/categories/entity/categories_entity.dart';
import '../arg/items_args.dart';
import '../pages/looking_for_details_page.dart';
import '../pages/view_all_page.dart';
import 'looking_for_widget.dart';

class BuildLookingWidget extends StatefulWidget {
  final String name;

  List<CategoriesEntity> lookingList;

  BuildLookingWidget({Key? key, required this.name, required this.lookingList})
      : super(key: key);

  @override
  State<BuildLookingWidget> createState() => _BuildLookingWidgetState();
}

class _BuildLookingWidgetState extends State<BuildLookingWidget> {

  List<CategoriesEntity> firstList = [];
  List<CategoriesEntity> secondList = [];


  @override
  Widget build(BuildContext context) {

    firstList = widget.lookingList.sublist(0, widget.lookingList.length ~/ 2);
    secondList = widget.lookingList.sublist(widget.lookingList.length ~/ 2);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.name,
              style: AppStyle.verySmallTitleStyle.copyWith(
                color: AppColorsController().textPrimaryColor,
                fontWeight: AppFontWeight.midLight,fontSize: AppFontSize.fontSize_14
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0.sp),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 72.sp,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return LookingForWidget(
                      onPressed: () {
                        if(firstList[index].hasChild !=0) {
                          DIManager.findNavigator().pushNamed(
                            LookingForDetailsPage.routeName,
                            arguments:
                            ItemsArgs(title: firstList[index].title,
                                id: firstList[index].category_id,
                                childCount: firstList[index].hasChild),
                          );
                        }
                      },
                      data: firstList[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 16.sp,
                    );
                  },
                  itemCount: firstList.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(height: 12.sp,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 72.sp,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return LookingForWidget(
                      onPressed: () {
                        if(secondList[index].hasChild !=0) {
                          DIManager.findNavigator().pushNamed(
                            LookingForDetailsPage.routeName,
                            arguments:
                            ItemsArgs(title: secondList[index].title,
                                id: secondList[index].category_id,
                                childCount: secondList[index].hasChild),
                          );
                        }
                      },
                      data: secondList[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 16.sp,
                    );
                  },
                  itemCount: secondList.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
