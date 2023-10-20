import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../general/buttons/app_button.dart';
import '../widgets/page_view_slider_widget.dart';

class OnBoardingPage extends StatefulWidget {
  static const routeName = '/OnBoardingPage';

  const OnBoardingPage() : super();

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: PageViewSliderWidget()),
        SizedBox(
          height: 16.sp,
        ),
        AppButton(
          child: Text(
            translate('let_is_start'),
            style: AppStyle.smallTitleStyle.copyWith(
              color: AppColorsController().white,
              fontWeight: AppFontWeight.midBold,
            ),
          ),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
              return Container(
                height: 385.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30.sp),topRight: Radius.circular(30.sp)),
                  boxShadow: [
                    AppStyle.iconShadow,
                  ],
                  color: AppColorsController().white,
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.share),
                      title: Text('Share'),
                    ),
                    ListTile(
                      leading: Icon(Icons.copy),
                      title: Text('Copy Link'),
                    ),
                    ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Edit'),
                    ),
                  ],
                ),
              );
            },
            );
          },
        ),
        SizedBox(height: 120.0.sp),
      ],
    );
  }
}
