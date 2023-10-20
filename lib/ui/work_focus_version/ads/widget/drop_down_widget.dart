import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/app_consts.dart';
import 'package:wadeema/core/constants/app_font.dart';
import 'package:wadeema/core/constants/app_style.dart';
import 'package:wadeema/core/constants/dimens.dart';
import 'package:wadeema/data/models/properties/entity/properties_entity.dart';

import '../../../../blocs/application/application_bloc.dart';
import '../../../../core/di/di_manager.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({required this.child,required this.subProperties,required this.onSelected,this.selectedProperties});

  final Widget child;
  final List<ItemsSubPropertiesEntity> subProperties;
  final Function(ItemsSubPropertiesEntity?) onSelected;
  final String? selectedProperties;

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ItemsSubPropertiesEntity>(
      offset: Offset(
          20 * (DIManager.findDep<ApplicationCubit>().appLanguage.languageCode == AppConsts.LANG_AR ? -1 : 1), 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.dialogBorderRadius)),
      color: AppColorsController().dropdown.withOpacity(0.9),
      itemBuilder: (BuildContext context) {
        return List.generate(
            widget.subProperties.length,
                (index) => PopupMenuItem(
              value: widget.subProperties[index],
              padding: EdgeInsets.zero,
              height: 24.sp,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.sp,vertical: 2.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Opacity(
                            opacity: widget.subProperties[index].title == widget.selectedProperties  ? 1 : 0,
                            child: Icon(
                              Icons.check_box,
                              color: Colors.white,
                              size: 15.sp,
                            )),
                        SizedBox(width: 4,),
                        Expanded(
                          child: Text(
                            '  ${widget.subProperties[index].title}  ',
                            style: AppStyle.verySmallTitleStyle.copyWith(
                              color: Colors.white,
                              fontWeight: AppFontWeight.midLight,
                              height: 1.2
                            ),
                          ),
                        ),
                        SizedBox.shrink()
                      ],
                    ),
                  ),
                  if (index < (widget.subProperties.length - 1)) ...[
                    Divider(
                      color: AppColorsController().white,
                      height: 0,
                    )
                  ]
                ],
              ),
            ));
      },
      onSelected: (newValue) {
        HapticFeedback.lightImpact();
        widget.onSelected(newValue);

      },
      child: widget.child,
    );
  }
}
