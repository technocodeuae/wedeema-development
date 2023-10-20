import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../blocs/evaluate/evaluate_bloc.dart';
import '../../../../blocs/evaluate/states/evaluate_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/di/di_manager.dart';
import '../../general/icons/rate_icon.dart';

class EvaluateButtonWidget extends StatefulWidget {
  final Function(bool)? onChanged;
  final int? userId;

  EvaluateButtonWidget({Key? key, this.onChanged, this.userId})
      : super(key: key);

  @override
  State<EvaluateButtonWidget> createState() => _EvaluateButtonWidgetState();
}

class _EvaluateButtonWidgetState extends State<EvaluateButtonWidget> {
  bool evaluate = false;
  int value = 0;
  String comment = "";

  final evaluateBloc = DIManager.findDep<EvaluateCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 72.sp),
      child: Column(
        children: [
          BlocListener<EvaluateCubit, EvaluateState>(
            bloc: evaluateBloc,
            child: Container(),
            listener: (_, state) {
              final evaluateAdState = state.evaluateAdsState;

              if (evaluateAdState is BaseFailState) {
                String massage = evaluateAdState!.error!.message.toString();
                final snackBar = SnackBar(
                  content: Text("${massage}"),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 1),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

              if (evaluateAdState is EvaluateAdSuccessState) {
                setState(() {
                  evaluate = true;
                });
              }
            },
          ),
          SizedBox(
            height: 18.sp,
          ),
          InkWell(
            child: RateIcon(
              height: 21.sp,
              width: 21.sp,
            ),
            onTap: () async {


              showDialog(
                context: context,
                builder: (BuildContext context) {
                  double rating = 0.0;
                  return AlertDialog(
                    title: Text('Rate this app'),
                    content: RatingBar(
                      initialRating: rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(
                          horizontal: 4.0),

                      onRatingUpdate: (value) {
                        rating = value;
                      },
                      ratingWidget: RatingWidget(
                        full: Icon(Icons.star, color: Colors.amber),
                        half: Icon(
                            Icons.star_half, color: Colors.amber),
                        empty: Icon(
                            Icons.star_border, color: Colors.amber),

                      ),
                    ),

                    actions: [
                      TextButton(
                        child: Text('CANCEL'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('OK'),
                        onPressed: () async{
                          // Save the rating                        // and close the dialog box
                          Navigator.of(context).pop();

                          await evaluateBloc.evaluateAd(widget.userId!,comment ,rating);

                          widget.onChanged!(evaluate!);
                        },
                      )
                      ,
                    ]
                    ,
                  );
                },
              );

            },
          ),
          SizedBox(
            height: 16.sp,
          ),
        ],
      ),
    );
  }
}
