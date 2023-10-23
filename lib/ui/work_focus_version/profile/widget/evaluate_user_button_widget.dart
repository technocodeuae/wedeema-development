import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/app_font.dart';
import 'package:wadeema/core/constants/app_style.dart';
import 'package:wadeema/core/utils/app_general_utils.dart';

import '../../../../blocs/evaluate/evaluate_bloc.dart';
import '../../../../blocs/evaluate/states/evaluate_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/button_build.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../general/icons/rate_icon.dart';
import '../../general/text_fields/build_text_field_widget.dart';

class EvaluateUserButtonWidget extends StatefulWidget {
  final Function(bool)? onChanged;
  final Function(bool)? onChangedLoader;
  final int? userId;
  final int? adId;
  final bool? isAds;

  EvaluateUserButtonWidget(
      {Key? key,
      this.onChanged,
      this.userId,
      this.adId,
      this.isAds = false,
      this.onChangedLoader})
      : super(key: key);

  @override
  State<EvaluateUserButtonWidget> createState() =>
      _EvaluateUserButtonWidgetState();
}

class _EvaluateUserButtonWidgetState extends State<EvaluateUserButtonWidget> {
  bool evaluate = false;
  int value = 0;
  String comment = "";
  TextEditingController commentController = TextEditingController();

  final evaluateBloc = DIManager.findDep<EvaluateCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocListener<EvaluateCubit, EvaluateState>(
          bloc: evaluateBloc,
          child: Container(),
          listener: (_, state) {
            widget.onChangedLoader!(false);
            final evaluateAdState = widget.isAds == true
                ? state.evaluateAdsState
                : state.evaluateUserState;

            if (evaluateAdState is BaseFailState) {
              String massage = evaluateAdState!.error!.message.toString();
              final snackBar = SnackBar(
                content: Text("${massage}"),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 1),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }

            if (widget.isAds == true &&
                evaluateAdState is EvaluateAdSuccessState) {
              setState(() {
                evaluate = true;
              });
            }

            if (widget.isAds == false &&
                evaluateAdState is EvaluateUserSuccessState) {
              setState(() {
                evaluate = true;
              });
            }
          },
        ),
        InkWell(
          child: RateIcon(
            height: 21.sp,
            width: 21.sp,
          ),
          onTap: () async {
            // widget.onChangedLoader!(true);
            if (!AppUtils.checkIfGuest(context)) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  double rating = 0.0;
                  comment = "";
                  return AlertDialog(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25.sp, vertical: 5.sp),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.sp),
                      side: BorderSide(
                        color: AppColorsController().buttonRedColor,
                        width: 1.sp,
                      ),
                    ),
                    title: Text(
                      widget.isAds == true
                          ? translate("rate_ads") + ":"
                          : translate("rate_user") + ":",
                      style: AppStyle.smallTextStyle,
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RatingBar(
                          itemSize: 32.sp,
                          initialRating: rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          // itemPadding: EdgeInsets.symmetric(horizontal: 0.5),
                          onRatingUpdate: (value) {
                            rating = value;
                          },
                          ratingWidget: RatingWidget(
                            full: Icon(Icons.star, color: Colors.amber),
                            half: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()..rotateZ(186),
                                child:
                                    Icon(Icons.star_half, color: Colors.amber)),
                            empty: Icon(Icons.star_border, color: Colors.amber),
                          ),
                        ),
                        SizedBox(
                          height: 8.sp,
                        ),
                        widget.isAds == true
                            ? BuildTextField(
                                width: 250.sp,
                                label: translate("comment"),
                                isRequired: false,
                                textDirection: TextDirection.rtl,
                                controller: commentController,
                                onTextChanged: (value) {
                                  setState(() {
                                    comment = value;
                                  });
                                },
                              )
                            : Container()
                      ],
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buttonBuild(
                            fontSize: AppFontSize.fontSize_14,
                            text: 'cancel',
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Navigator.of(context).pop();
                            },
                          ),
                          buttonBuild(      fontSize: AppFontSize.fontSize_14,
                            text: 'ok',
                            onPressed: () async {
                              // Save the rating                        // and close the dialog box
                              Navigator.of(context).pop();

                              if (widget.isAds == false)
                                await evaluateBloc.evaluateUser(
                                    widget.userId!, rating);
                              else
                                await evaluateBloc.evaluateAd(
                                    widget.adId!, comment, rating);

                              widget.onChanged!(evaluate);
                            },
                          ),
                        ],
                      ),
                      // TextButton(
                      //   child: Text(translate('cancel')),
                      //   onPressed: () {
                      //     Navigator.of(context).pop();
                      //   },
                      // ),
                      // TextButton(
                      //   child: Text(translate('ok')),
                      //   onPressed: () async {
                      //     // Save the rating                        // and close the dialog box
                      //     Navigator.of(context).pop();
                      //
                      //     if (widget.isAds == false)
                      //       await evaluateBloc.evaluateUser(
                      //           widget.userId!, rating);
                      //     else
                      //       await evaluateBloc.evaluateAd(
                      //           widget.adId!, comment, rating);
                      //
                      //     widget.onChanged!(evaluate!);
                      //   },
                      // ),
                    ],
                    backgroundColor: AppColorsController().pobColor,
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
