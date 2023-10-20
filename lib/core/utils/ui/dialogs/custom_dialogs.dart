import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/shared_prefs/data_store.dart';
import 'package:wadeema/ui/work_focus_version/ads/widget/post_ad_button.dart';
import '../../../../core/di/di_manager.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/screen_utils/device_utils.dart';
import '../../../../core/utils/ui/widgets/rounded_animated_button.dart';
import '../../../../core/utils/ui/widgets/utils/horizontal_padding.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
// import 'package:syncfusion_flutter_core/theme.dart';

import '../../app_general_utils.dart';

class CustomDialogs {
  static const String addNewTaskDialogRouteName =
      'CustomDialogs/showAddNewTaskDialog';

  static showShareBottomSheet() {
    Get.bottomSheet(AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(translate('share_confirm'),
              style: AppStyle.defaultStyle
                  .copyWith(fontSize: ScreenHelper.scaleText(40))),
          VerticalPadding(4),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  DIManager.findNavigator().pop();
                },
                child: Text(
                  translate('cancel'),
                  style: AppStyle.defaultStyle
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              RoundedAnimatedButton(
                text: translate('continue'),
                onPressed: () {
                  DIManager.findNavigator().pop();
                },
              )
            ],
          ),
        ],
      ),
    ));
  }

  static showInvalidSession([BuildContext? context]) {
    Get.dialog(
      WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 25.w),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.dialogBorderRadius)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                translate('invalid_session'),
                style: AppStyle.defaultStyle,
              ),
              SizedBox(
                height: ScreenHelper.fromHeight55(3),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '',
                    style: TextStyle(
                        fontSize: AppFontSize.fontSize_16,
                        fontWeight: AppFontWeight.semiBold,
                        color: DIManager.findDep<
                                AppColorsController>()
                            .black),
                  ),
                  RoundedAnimatedButton(
                    text: translate('logout'),
                    onPressed: (){
                      DIManager.findNavigator().pop();
                      dataStore.clearCache();
                      // DIManager.findDep<AuthCubit>().logoutLocally();
                    },//DIManager.findDep<AuthCubit>().logoutLocally,
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static showEvaluationDialog({
    required BuildContext context,
    required void Function()? onSubmit,
    void Function()? onCancel,
    void Function(String value)? onChangedTextField,
  }) {
    Get.dialog(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 333.w,
                // height: 260.h,
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.w)),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      24.w,
                      20.w,
                      24.w,
                      16.w,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              translate('tell_us_more') +
                                  ' ' +
                                  '(${translate('optional')})',
                              style: AppStyle.smallTitleStyle.copyWith(
                                color: DIManager.findDep<
                                        AppColorsController>()
                                    .black,
                                fontWeight: AppFontWeight.regular,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.w),
                        Container(
                          width: 286.w,
                          height: 140.h,
                          child: TextField(
                            // minLines: 6,
                            // maxLines: 6,
                            maxLines: null,
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.top,
                            expands: true,
                            onChanged: onChangedTextField,
                            textInputAction: TextInputAction.done,
                            decoration: AppStyle.inputDecorationOutlined(
                              labelText: translate('your_feedback'),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.w),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: onCancel ??
                                  () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                              child: Text(
                                translate('cancel'),
                                style: AppStyle.titleStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      DIManager.findCC().black,
                                ),
                              ),
                            ),
                            RoundedAnimatedButton(
                              // text: translate('submit'),
                              child: Text(
                                translate('submit'),
                                style: AppStyle.titleStyle.copyWith(
                                  color: DIManager.findDep<
                                          AppColorsController>()
                                      .white,
                                  fontWeight: AppFontWeight.semiBold,
                                ),
                              ),
                              onPressed: onSubmit,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static showAddNewTaskListTitleDialog({
    required BuildContext context,
    required void Function()? onSubmit,
    void Function()? onCancel,
    void Function(String value)? onChangedTextField,
  }) {
    Get.dialog(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 333.w,
                // height: 260.h,
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.w)),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      24.w,
                      20.w,
                      24.w,
                      16.w,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              translate('create_new_task_list_name'),
                              style: AppStyle.smallTitleStyle.copyWith(
                                color: DIManager.findDep<
                                        AppColorsController>()
                                    .black,
                                fontWeight: AppFontWeight.regular,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.w),
                        Container(
                          width: 286.w,
                          height: 140.h,
                          child: TextField(
                            // minLines: 6,
                            // maxLines: 6,
                            maxLines: null,
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.top,
                            expands: true,
                            onChanged: onChangedTextField,
                            textInputAction: TextInputAction.done,
                            decoration: AppStyle.inputDecorationOutlined(
                              labelText: translate('list_name'),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.w),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: onCancel ??
                                  () {
                                    DIManager.findNavigator()
                                        .pop();
                                  },
                              child: Text(
                                translate('cancel'),
                                style: AppStyle.titleStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      DIManager.findCC().black,
                                ),
                              ),
                            ),
                            RoundedAnimatedButton(
                              // text: translate('submit'),
                              child: Text(
                                translate('create'),
                                style: AppStyle.titleStyle.copyWith(
                                  color: DIManager.findDep<
                                          AppColorsController>()
                                      .white,
                                  fontWeight: AppFontWeight.semiBold,
                                ),
                              ),
                              onPressed: onSubmit,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      routeSettings:
          RouteSettings(name: CustomDialogs.addNewTaskDialogRouteName),
      barrierDismissible: false,
    );
  }

  static showUpdateProgressPriority({
    int? initProgressValue,
    int? initPriorityValue,
    required void Function() onSave,
    void Function()? onCancel,
    required BuildContext context,
    required void Function(int) onPriorityChanged,
    required void Function(int) onProgressChanged,
  }) {
    Get.dialog(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 333.w,
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.w),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              translate('update_task_progress_and_priority'),
                              style: AppStyle.smallTitleStyle.copyWith(
                                color: DIManager.findDep<
                                        AppColorsController>()
                                    .black,
                                fontWeight: AppFontWeight.semiBold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Text(
                              translate('progress'),
                              style: AppStyle.smallTitleStyle.copyWith(
                                color: DIManager.findDep<
                                        AppColorsController>()
                                    .greyTextColor,
                                fontWeight: AppFontWeight.semiBold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),

                        SizedBox(height: 24),
                        Row(
                          children: [
                            Text(
                              translate('priority'),
                              style: AppStyle.smallTitleStyle.copyWith(
                                color: DIManager.findDep<
                                        AppColorsController>()
                                    .greyTextColor,
                                fontWeight: AppFontWeight.semiBold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  translate('low'),
                                  style: AppStyle.defaultStyle.copyWith(
                                    color: DIManager.findCC()
                                        .black,
                                    fontWeight: AppFontWeight.semiBold,
                                  ),
                                ),
                                Text(
                                  translate('mid'),
                                  style: AppStyle.defaultStyle.copyWith(
                                    color: DIManager.findCC()
                                        .black,
                                    fontWeight: AppFontWeight.semiBold,
                                  ),
                                ),
                                Text(
                                  translate('high'),
                                  style: AppStyle.defaultStyle.copyWith(
                                    color: DIManager.findCC()
                                        .black,
                                    fontWeight: AppFontWeight.semiBold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 45),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                DIManager.findNavigator()
                                    .pop();
                              },
                              child: Text(
                                translate('cancel'),
                                style: AppStyle.smallTitleStyle.copyWith(
                                  fontWeight: AppFontWeight.semiBold,
                                  color:
                                      DIManager.findCC().black,
                                ),
                              ),
                            ),
                            RoundedAnimatedButton(
                              child: Text(
                                translate('save'),
                                style: AppStyle.smallTitleStyle.copyWith(
                                  color: DIManager.findDep<
                                          AppColorsController>()
                                      .white,
                                  fontWeight: AppFontWeight.semiBold,
                                ),
                              ),
                              onPressed: onSave,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      routeSettings:
          RouteSettings(name: CustomDialogs.addNewTaskDialogRouteName),
      barrierDismissible: false,
    );
  }

  // static showUpdateDateTime({
  //   void Function()? onCancel,
  //   DateTime? initDateTimeValue,
  //   required BuildContext context,
  //   required void Function() onSave,
  //   required void Function(DateRangePickerSelectionChangedArgs)
  //       onDateTimeChanged,
  // }) {
  //   Get.dialog(
  //     Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Container(
  //               width: 333.w,
  //               child: Card(
  //                 margin: EdgeInsets.zero,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(15.w),
  //                 ),
  //                 child: Padding(
  //                   padding: EdgeInsets.all(20),
  //                   child: Column(
  //                     children: [
  //                       Row(
  //                         children: [
  //                           Text(
  //                             translate('reset_due_date'),
  //                             style: AppStyle.smallTitleStyle.copyWith(
  //                               color: DIManager.findDep<
  //                                       AppColorsController>()
  //                                   .black,
  //                               fontWeight: AppFontWeight.semiBold,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       SizedBox(height: 24),
  //                       Row(
  //                         children: [
  //                           Expanded(
  //                             child: Container(
  //                               decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(10),
  //                                 border: Border.all(
  //                                   color: Color(0xffBFBFBF),
  //                                 ),
  //                               ),
  //                               padding: EdgeInsets.all(14),
  //                               child: Text(
  //                                 DateTimeHelper.formatDateddMMMyyyy(
  //                                     initDateTimeValue),
  //                                 style: AppStyle.smallTitleStyle.copyWith(
  //                                   color: DIManager.findCC()
  //                                       .black,
  //                                   fontWeight: AppFontWeight.regular,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       SizedBox(height: 20),
  //                       SfDateRangePickerTheme(
  //                         data: SfDateRangePickerThemeData(
  //                           backgroundColor: Colors.white,
  //                           selectionColor: DIManager.findCC()
  //                               .primaryColor,
  //                           todayHighlightColor:
  //                               DIManager.findCC()
  //                                   .primaryColor,
  //                           weekNumberBackgroundColor:
  //                               DIManager.findCC()
  //                                   .primaryColor,
  //                           todayTextStyle: AppStyle.defaultStyle.copyWith(
  //                             color: DIManager.findCC()
  //                                 .primaryColor,
  //                             fontWeight: AppFontWeight.regular,
  //                           ),
  //                         ),
  //                         child: SfDateRangePicker(
  //                           initialSelectedDate: initDateTimeValue,
  //                           onSelectionChanged: onDateTimeChanged,
  //                           view: DateRangePickerView.month,
  //                           monthCellStyle: DateRangePickerMonthCellStyle(
  //                             todayTextStyle: AppStyle.defaultStyle.copyWith(
  //                               color: DIManager.findCC()
  //                                   .primaryColor,
  //                               fontWeight: AppFontWeight.regular,
  //                             ),
  //                           ),
  //                           monthViewSettings: DateRangePickerMonthViewSettings(
  //                             firstDayOfWeek: 1,
  //                             showTrailingAndLeadingDates: true,
  //                           ),
  //                           headerStyle: DateRangePickerHeaderStyle(
  //                             textStyle: AppStyle.smallTitleStyle.copyWith(
  //                               color: Color(0xff454F63),
  //                               fontWeight: AppFontWeight.regular,
  //                             ),
  //                           ),
  //                           enablePastDates: false,
  //                           allowViewNavigation: true,
  //                           selectionTextStyle: AppStyle.defaultStyle.copyWith(
  //                             color: DIManager.findCC().white,
  //                             fontWeight: AppFontWeight.regular,
  //                           ),
  //                           yearCellStyle: DateRangePickerYearCellStyle(
  //                             textStyle: AppStyle.defaultStyle.copyWith(
  //                               color: Color(0xff454F63),
  //                               fontWeight: AppFontWeight.regular,
  //                             ),
  //                             todayTextStyle: AppStyle.defaultStyle.copyWith(
  //                               color: Color(0xff454F63),
  //                               fontWeight: AppFontWeight.regular,
  //                             ),
  //                             disabledDatesTextStyle:
  //                                 AppStyle.defaultStyle.copyWith(
  //                               // color: Color(0xff454F63),
  //                               fontWeight: AppFontWeight.regular,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       SizedBox(height: 24),
  //                       Row(
  //                         mainAxisSize: MainAxisSize.max,
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           TextButton(
  //                             onPressed: () {
  //                               DIManager.findNavigator()
  //                                   .pop();
  //                             },
  //                             child: Text(
  //                               translate('cancel'),
  //                               style: AppStyle.smallTitleStyle.copyWith(
  //                                 fontWeight: AppFontWeight.semiBold,
  //                                 color:
  //                                     DIManager.findCC().black,
  //                               ),
  //                             ),
  //                           ),
  //                           RoundedAnimatedButton(
  //                             child: Text(
  //                               translate('save'),
  //                               style: AppStyle.smallTitleStyle.copyWith(
  //                                 color: DIManager.findDep<
  //                                         AppColorsController>()
  //                                     .white,
  //                                 fontWeight: AppFontWeight.semiBold,
  //                               ),
  //                             ),
  //                             onPressed: onSave,
  //                           )
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //     routeSettings:
  //         RouteSettings(name: CustomDialogs.addNewTaskDialogRouteName),
  //     barrierDismissible: false,
  //   );
  // }

  static showLinkDialog(BuildContext context, String? link) {
    return Get.dialog(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 0.8773.sw,
            child: AlertDialog(
              insetPadding: EdgeInsets.zero,
              contentTextStyle: AppStyle.defaultStyle,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.w)),
              title: Text(
                translate('open_following_url'),
                style: AppStyle.smallTitleStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: DIManager.findCC().black,
                ),
              ),
              content: Builder(
                builder: (context) {
                  return InkWell(
                    onTap: () {
                      AppUtils.launchURL(link ?? '');
                      Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 0.02.sw,
                      ),
                      child: Text(
                        link ?? '',
                        style: AppStyle.smallTitleStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: DIManager.findDep<
                                    AppColorsController>()
                                .red,
                            fontSize: AppFontSize.fontSize_16,
                            decoration: TextDecoration.underline),
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                }
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Builder(
                      builder: (context) {
                        return TextButton(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                            child: Text(
                              translate('cancel'),
                              style: AppStyle.smallTitleStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                color: DIManager.findCC().black,
                                fontSize: AppFontSize.fontSize_16,
                              ),
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: DIManager.findDep<AppColorsController>()
                                .textButtonBackground,
                            // This is a custom color variable
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {
                            Navigator.of(
                              context,
                              rootNavigator: true,
                            ).pop();
                          },
                        );
                      }
                    ),
                    HorizontalPadding(2),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static showSortBottomSheet(List<String> items,
      {required String value,
      required Function(String value) onChange,
      String? title}) {
    return Get.bottomSheet<String>(
        Container(
          width: ScreenHelper.width55,
          color: AppColorsController().white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              VerticalPadding(2.0),
              Padding(
                padding: Dimens.defaultPageHorizontalPaddingSmall,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title ?? translate('sorted_by'),
                      style: AppStyle.smallTitleStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColorsController().black
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        DIManager.findNavigator().pop();
                      },
                      child: Text(
                        translate('done'),
                        style: AppStyle.smallTitleStyle.copyWith(
                            color: DIManager.findDep<
                                    AppColorsController>()
                                .black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              VerticalPadding(2.0),
              Divider(
                thickness: ScreenHelper.fromHeight55(0.15),
                color: DIManager.findDep<AppColorsController>()
                    .red
                    .withOpacity(0.7),
                height: 0.0,
              ),
              VerticalPadding(2.0),
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: items
                    .map((e) => ListTile(
                          onTap: () {
                            onChange(e);
                            DIManager.findNavigator().pop();
                          },
                          title: Text(
                            translate(e),
                            style: AppStyle.defaultStyle,
                          ),
                          trailing: e == value
                              ? Icon(
                                  Icons.check,
                                  color: DIManager.findDep<
                                          AppColorsController>()
                                      .primaryColor,
                                )
                              : Container(
                                  width: 1,
                                  height: 1,
                                ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
        backgroundColor: AppColorsController().white,
        enableDrag: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(ScreenHelper.fromWidth55(6.0)))));
  }

  static Future showTowButtonsDialog({
  required BuildContext context,required String title,required String buttonText,required VoidCallback onPrssed}
  ) async {
    return await Get.dialog(
      Dialog(
        backgroundColor: AppColorsController().dialog,
        insetPadding: EdgeInsets.symmetric(horizontal: 25.w),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.dialogBorderRadius)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              title,
              style: AppStyle.smallTitleStyle.copyWith(
                fontWeight: AppFontWeight.bold,
                color: DIManager.findCC().black,
              ),
            ),
            SizedBox(
              height: 16.sp,
            ),
            NewButton(
                text: buttonText,
                textStyle: AppStyle.titleStyle.copyWith(
                    color: AppColorsController().white,
                    fontWeight: AppFontWeight.bold,
                    overflow: TextOverflow.ellipsis),
                textPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 6),
                onPressed: onPrssed)
          ]),
        ),
      ),
    );
  }

}
