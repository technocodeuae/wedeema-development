import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/app_font.dart';

import '../../../../core/utils/localization/app_localizations.dart';

class TextFieldWidget extends StatefulWidget {
  final Widget? icon;
  final Widget? suffix;
  final String? label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool isRequired;
  final bool autoFocus;
  final int? maxLength;
  final BuildContext? context;
  final ValueChanged<String>? onFieldSubmitted;
  final GestureTapCallback? onTap;
  final String? hint;
  final Color? hintColor;
  final double? width,height;
  final bool? readOnly;
  final bool obscureText;
  final Widget? prefixIcon;
  final Color? colorText;
  final double? fontSizeText;
  final TextDirection? textDirection;
  final TextEditingController? controllerText;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChangeText;


  final Function(String)? onTextChanged;

  TextFieldWidget(
      {Key? key,
      this.context,
      this.icon,
      this.onChangeText,
      this.readOnly = false,
      this.label,
      this.controller,
      this.focusNode,
      this.nextFocusNode,
      this.onFieldSubmitted,
      this.controllerText,
      this.inputFormatters,
      this.obscureText = false,
      this.isRequired = false,
      this.autoFocus = false,
      this.hint,
      this.hintColor,
      this.width,
      this.height,
      this.suffix,
      this.onTap,
      this.maxLength,
      this.prefixIcon,
      this.textDirection =TextDirection.ltr,
      this.keyboardType,
      this.textInputAction,
      this.fontSizeText,
      this.colorText = Colors.black,
      this.onTextChanged})
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool _showError = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 7.sp,right: 12.sp),
          child: widget.icon ?? Container(),
        ),
        Expanded(
          // width: widget.width ?? 300.sp,
          child: Padding(
            padding: EdgeInsets.only(top: widget.prefixIcon == null ? 0 : 4.0,left: 22),
            child: TextFormField(

              controller: widget.controllerText,
              inputFormatters: widget.inputFormatters,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              focusNode: widget.focusNode,
              autofocus: widget.autoFocus,
              onFieldSubmitted: (s){
                if(widget.nextFocusNode != null) {
                  FocusScope.of(widget.context ?? context).requestFocus(widget.nextFocusNode);
                }

                if (widget.onFieldSubmitted != null) widget.onFieldSubmitted!(s);
              },
              onTap: widget.onTap,
              maxLength: widget.maxLength,
              // showCursor: !_showError,
              cursorColor: AppColorsController().scaffoldBGColor,
              validator: (String? value){
                if (value?.isEmpty ?? true) return translate('this_field_is_required');
                return null;
              },
              onChanged: (value) {
                if (value.toString().isNotEmpty) {
                  setState(() {
                    _showError = false;
                  });
                }
                if (widget.isRequired == true && value.toString().isEmpty) {
                  setState(() {
                    _showError = true;
                  });
                }

                if(widget.onTextChanged != null) {
                  widget.onTextChanged!(value.toString());
                }

                widget.onChangeText;
              },
              onSaved: (value) {
                if (widget.isRequired == true && value.toString().isEmpty) {
                  // Show error
                  setState(() {
                    _showError = true;
                  });
                } else {
                  setState(() {
                    _showError = false;
                  });
                }
              },
              maxLines: widget.obscureText ? 1 : null,
              minLines: 1,
              readOnly: widget.readOnly ?? false,
              enabled: !(widget.readOnly ?? false),
              initialValue: widget.controller?.text,
              style: TextStyle(
                color: widget.colorText, // Set the text color to blue
                fontSize: widget.fontSizeText,
              ),textDirection: widget.textDirection,
              decoration: InputDecoration(
                counterText: '',
                prefixIcon: widget.prefixIcon,
                hintText:widget.hint ,
                // errorText: widget.isRequired == true
                //     ? (_showError == true
                //         ? translate('this_field_is_required')
                //         : null)
                //     : null,
                // errorStyle: TextStyle(height: 0,fontSize: 1),
                contentPadding: EdgeInsets.only(bottom: 10.sp , top: 10.sp),
                border: InputBorder.none,
                suffixIcon: widget.suffix,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                //errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                labelStyle: AppFontStyle.formFieldStyle.copyWith(
                  color:
                      widget.hintColor ?? AppColorsController().textPrimaryColor,
                ),
                hintStyle: AppFontStyle.formFieldStyle.copyWith(
                  color:
                      widget.hintColor ?? AppColorsController().greyTextColor,
                  fontWeight: AppFontWeight.semiBold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
