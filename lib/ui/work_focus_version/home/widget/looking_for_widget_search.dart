import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wadeema/core/constants/app_colors.dart';

import '../../../../core/constants/app_consts.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../data/models/categories/entity/categories_entity.dart';
import '../models/looking_model.dart';

class LookingForWidgetSearch extends StatefulWidget {
  final CategoriesEntity? data;
  final double? height;
  final Function()? onPressed;
  final double? width;

  final bool isSelectAll;
  final int currentSelect;


  LookingForWidgetSearch({Key? key, this.data, this.width, this.height, required this.onPressed,required this.currentSelect,this.isSelectAll =false}) : super(key: key);

  @override
  State<LookingForWidgetSearch> createState() => _LookingForWidgetSearchState();
}

class _LookingForWidgetSearchState extends State<LookingForWidgetSearch> {
 int? currentSelect = 0;
 bool isCurrentSelect =false ;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 71.sp,
      width: widget.width ?? 90.sp,
      decoration: BoxDecoration(
        border: Border.all(color: AppColorsController().borderColor, width: 0.3.sp),
        color: widget.currentSelect == widget.data!.category_id ||widget.isSelectAll ? AppColorsController().buttonRedColor: AppColorsController().card,
        borderRadius: BorderRadius.all(
          Radius.circular(18.sp),
        ),
      ),
      child: TextButton(
         onPressed:  widget.onPressed,
        style: TextButton.styleFrom(
            foregroundColor: AppColorsController().scaffoldBGColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.sp))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Text(
                widget.data?.title.toString() ?? '',
                style: AppStyle.verySmallTitleStyle.copyWith(
                  color: widget.currentSelect == widget.data!.category_id ||widget.isSelectAll ?  AppColorsController().white : AppColorsController().black,
                  fontWeight: AppFontWeight.bold,fontSize: AppFontSize.fontSize_12
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
