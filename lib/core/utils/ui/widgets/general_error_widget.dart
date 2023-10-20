import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/errors/base_error.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/screen_utils/device_utils.dart';
import '../../../../core/utils/ui/widgets/rounded_animated_button.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';

class GeneralErrorWidget extends StatefulWidget {
  final VoidCallback? callback;
  final Widget? body;
  final BaseError? error;
  final bool centerContent;
  final String? message;

  const GeneralErrorWidget({
    Key? key,
    this.callback,
    this.message,
    this.body,
    this.error,
    this.centerContent = true,
  }) : super(key: key);

  @override
  _GeneralErrorWidgetState createState() => _GeneralErrorWidgetState();
}

class _GeneralErrorWidgetState extends State<GeneralErrorWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: widget.centerContent
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          this.widget.body ?? Container(),
          VerticalPadding(1.5.sp),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenHelper.fromWidth55(4.sp)),
            child: Text(
              this.widget.message ?? widget.error!.message!,
              style: AppStyle.errorMessageStyle,textAlign: TextAlign.center,
            ),
          ),
          VerticalPadding(1.5.sp),
          RoundedAnimatedButton(
            text: translate('retry'),
            isActive: this.widget.callback != null,
            onPressed: () {
              if (this.widget.callback != null) this.widget.callback!();
            },
          ),
        ],
      ),
    );
  }
}
