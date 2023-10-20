import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/dimens.dart';

import '../../../../blocs/application/application_bloc.dart';
import '../../../../blocs/upload_ads/states/upload_ads_state.dart';
import '../../../../blocs/upload_ads/upload_ads_bloc.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/snackbar_and_toast/snackbar_and_toast.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/buttons/app_button.dart';
import '../../general/icons/back_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../../home/pages/home_page.dart';
import '../args/argument_policy.dart';

class SafetyPage extends StatefulWidget {
  static const routeName = '/SafetyPage';
  final ArgumentPolicy? dataMap;

  const SafetyPage({Key? key, this.dataMap}) : super(key: key);

  @override
  State<SafetyPage> createState() => _SafetyPageState();
}

class _SafetyPageState extends State<SafetyPage> {
  List<String> conditionList = [
    "if_activity_that_violates",
    "if_wrong category",
    "if_multiple_times_or_in_multiple_categories",
    "if_with_fraudulent_or_misleading_information",
    "if_located_outside_the_UAE"
  ];
  final ads = DIManager.findDep<UploadAdsCubit>();

  bool _isLoading = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsController().scaffoldBGColor,
      body:  SafeArea(
          child: LoadingColumnOverlay(
            isLoading: _isLoading,
            child: BackLongPress(

              child: Column(
                children: [   SizedBox(height: 10.sp ,),
                  AppBarWidget(
                    name: translate("place_ads"),
                    child: InkWell(
                      onTap: () {
                        DIManager.findNavigator().pop();
                      },
                      child: BackIcon(
                        width: 26.sp,
                        height: 18.sp,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 12.sp,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 60.sp),
                          child: Column(
                            children: [
                              Text(
                                translate("safety_first"),
                                style: AppStyle.verySmallTitleStyle.copyWith(
                                  color: AppColorsController().black,
                                  fontWeight: AppFontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 8.sp,
                              ),
                              Text(
                                translate("we_review_all_ads"),
                                style: AppStyle.verySmallTitleStyle.copyWith(
                                  color: AppColorsController().black,
                                  fontWeight: AppFontWeight.midLight,
                                ),
                              ),
                              SizedBox(
                                height: 8.sp,
                              ),
                              Text(
                                translate("your_ad_will_not_go_live_if"),
                                style: AppStyle.verySmallTitleStyle.copyWith(
                                  color: AppColorsController().black,
                                  fontWeight: AppFontWeight.midLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40.sp,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 32.sp),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColorsController().borderColor,
                              width: 0.2,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(Dimens.containerBorderRadius),
                            ),
                            color: AppColorsController().containerPrimaryColor,
                          ),
                          child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 60.sp, vertical: 16.sp),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {});
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            (index + 1).toString() +
                                                "- " +
                                                translate(conditionList[index]),
                                            style:
                                                AppStyle.verySmallTitleStyle.copyWith(
                                              color: AppColorsController()
                                                  .textPrimaryColor,
                                              fontWeight: AppFontWeight.midLight,
                                            ),
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Container(
                                  height: 1.sp,
                                  width: MediaQuery.of(context).size.width,
                                  color: AppColorsController().borderColor,
                                );
                              },
                              itemCount: conditionList.length),
                        ),
                        SizedBox(
                          height: 40.sp,
                        ),
                        Text(
                          translate("for_more_information_read_our"),
                          style: AppStyle.verySmallTitleStyle.copyWith(
                            color: AppColorsController().black,
                            fontWeight: AppFontWeight.midLight,
                          ),
                        ),
                        SizedBox(
                          height: 16.sp,
                        ),
                        Text(
                          translate("terms"),
                          style: AppStyle.verySmallTitleStyle.copyWith(
                            color: AppColorsController().black,
                            fontWeight: AppFontWeight.bold,
                          ),
                        ),
                        BlocConsumer<UploadAdsCubit, UploadAdsState>(
                            bloc: ads,
                            listener: (_, state) {



                              final storeAdsState = state.storeAdsState;
                              if (_isLoading == true &&storeAdsState is BaseFailState) {
                                CustomSnackbar.showErrorSnackbar(
                                  storeAdsState.error!,
                                );
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                              if (_isLoading == true && storeAdsState is StoreAdsSuccessState) {
                                setState(() {
                                  _isLoading = false;
                                });
                                var snackBar = SnackBar(
                                  content:
                                      Text(translate('add_advertisement_success')),
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(seconds: 1),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                DIManager.findNavigator().pushNamedAndRemoveUntil(
                                  HomePage.routeName,
                                );
                              }
                            },
                            builder: (_, state) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 22.sp,
                                  ),
                                  AppButton(
                                    width: 152.sp,
                                    height: 44.sp,
                                    childPadding:
                                        EdgeInsets.symmetric(horizontal: 10.sp),
                                    onPressed: () {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      ads.storeAds(widget.dataMap!);
                                    },
                                    child: Text(
                                      translate("yes_i_agree"),
                                      style: AppStyle.verySmallTitleStyle.copyWith(
                                        color: AppColorsController().textPrimaryColor,
                                        fontWeight: AppFontWeight.midLight,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
