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
import 'looking_for_widget_search.dart';

class BuildLookingSearch extends StatefulWidget {
  final String name;

  List<CategoriesEntity> lookingList;

  BuildLookingSearch({Key? key, required this.name, required this.lookingList})
      : super(key: key);

  @override
  State<BuildLookingSearch> createState() => _BuildLookingSearchState();
}

class _BuildLookingSearchState extends State<BuildLookingSearch> {
  List<CategoriesEntity> firstList = [];

  bool isSelectAll = true;
  int currentSelect = 100;

  @override
  Widget build(BuildContext context) {
    firstList = widget.lookingList;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0.sp),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40.sp,
                // child: ListView.separated(
                //   physics: BouncingScrollPhysics(),
                //   itemBuilder: (context, index) {
                //     return LookingForWidgetSearch(
                //       onPressed: () {
                //         if(firstList[index].hasChild !=0) {
                //           DIManager.findNavigator().pushNamed(
                //             LookingForDetailsPage.routeName,
                //             arguments:
                //             ItemsArgs(title: firstList[index].title,
                //                 id: firstList[index].category_id,
                //                 childCount: firstList[index].hasChild,indexPage: 0),
                //           );
                //         }
                //       },
                //       data: firstList[index],
                //     );
                //   },
                //   separatorBuilder: (context, index) {
                //     return SizedBox(
                //       width: 5.sp,
                //     );
                //   },
                //   itemCount: firstList.length,
                //   scrollDirection: Axis.horizontal,
                // ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      LookingForWidgetSearch(
                        currentSelect: currentSelect,
                        isSelectAll: isSelectAll,
                        onPressed: () {
                          setState(() {
                            currentSelect = 0;
                            isSelectAll = true;
                          });
                          print(currentSelect);
                        },
                        data: CategoriesEntity(title: "الجميع"),
                      ),
                      SizedBox(
                        width: 7.sp,
                      ),
                      for (int index = 0;
                          index < firstList.length;
                          index++) ...[
                        LookingForWidgetSearch(
                          currentSelect: currentSelect,
                          onPressed: () {
                            setState(() {
                              currentSelect = firstList[index].category_id!;
                              isSelectAll = false;
                            });
                            print(currentSelect);
                          },
                          data: firstList[index],
                        ),
                        SizedBox(
                          width: 7.sp,
                        ),
                      ]
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
