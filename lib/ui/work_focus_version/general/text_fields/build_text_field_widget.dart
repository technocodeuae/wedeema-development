import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/ui/work_focus_version/general/text_fields/text_field_decorator.dart';
import 'package:wadeema/ui/work_focus_version/general/text_fields/text_field_widget.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_style.dart';

class BuildTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final double? width;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final Function(String)? onTextChanged;
  final bool isRequired;
  final Widget? icon;
  final Widget? suffix;
  final bool? readOnly;
  final Color? colorText;
  final double? fontSizeText;
  final TextDirection? textDirection;


  BuildTextField({
    Key? key,
    required this.label,
    this.hint = "",
    this.width,
    required this.controller,
    this.onTextChanged,
    this.prefixIcon,
    this.fontSizeText,
    this.icon,
    this.readOnly,
    this.colorText,
    this.textDirection = TextDirection.ltr,
    this.suffix,
    required this.isRequired, this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(6.0.sp),
          child: Text(
            label + (isRequired == true ? "*" : "") + " :",
            style: AppStyle.verySmallTitleStyle.copyWith(
              color: AppColorsController().textPrimaryColor,fontSize: 15.sp,
            ),
          ),
        ),
        keyboardType == TextInputType.phone
            ? Directionality(
                textDirection: TextDirection.ltr,
                child: fieldWidget(),
              )
            : fieldWidget(),
      ],
    );
  }

  Widget fieldWidget(){
    return TextFieldDecorator(
      width: width ?? 350.sp,
      child: TextFieldWidget(
        width: width,icon:icon ,
        prefixIcon: prefixIcon,
        keyboardType: keyboardType,
        onTextChanged: onTextChanged,
        controller: controller,
        isRequired: isRequired,colorText: colorText,fontSizeText: fontSizeText,
        hint: hint,readOnly:readOnly ,suffix: suffix,textDirection:textDirection ,
      ),
    );
  }
}
