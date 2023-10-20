import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/string_utils/string_utils.dart';
import '../../../../core/utils/ui/icons/back_button_icon_widget.dart';

class BackButtonWrapperWidget extends StatelessWidget {
  final Widget child;

  final Function onPressed;

  const BackButtonWrapperWidget(
      {Key? key, required this.child, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: child,
        ),
        PositionedDirectional(
          top: 0.06.sh,
          start: 0.03.sw,
          child: Row(
            children: [
              BackButtonIconWidget(
                onPressed: onPressed,
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: Row(
                  children: [
                    LimitedBox(
                      maxWidth: 0.68.sw,
                      child: Text(
                        translate('please_sign_in').toTitleCase(),
                        maxLines: 1,
                        style: AppStyle.titleStyle.copyWith(color: Colors.white,),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
