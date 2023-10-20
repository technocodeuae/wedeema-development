import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/bloc/states/base_wait_state.dart';
import 'package:wadeema/core/constants/app_font.dart';
import 'package:wadeema/core/utils/app_general_utils.dart';

import '../../../../blocs/profile/profile_bloc.dart';
import '../../../../blocs/profile/states/profile_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../general/buttons/app_button.dart';

class FollowButtonWidget extends StatefulWidget {
  bool? isFollow;
  final Function(bool)? onChanged;
  final int? userId;

  FollowButtonWidget({Key? key, this.isFollow, this.onChanged, this.userId})
      : super(key: key);

  @override
  State<FollowButtonWidget> createState() => _FollowButtonWidgetState();
}

class _FollowButtonWidgetState extends State<FollowButtonWidget> {
  bool follow = false;

  final profileBloc = DIManager.findDep<ProfileCubit>();

  @override
  void initState() {
    super.initState();
    follow = widget.isFollow!;
    print(widget.isFollow);
  }
bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      child: Column(
        children: [
          BlocListener<ProfileCubit, ProfileState>(
            bloc: profileBloc,
            child: Container(),
            listener: (_, state) {
              final followState = widget.isFollow!
                  ? state.unfollowUserState
                  : state.followUserState;


              if (followState is BaseFailState) {
                String massage = followState!.error!.message.toString();
                final snackBar = SnackBar(
                  content: Text("${massage}"),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 1),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }


              if(widget.isFollow! && followState is BaseLoadingState){
                print('----------------------');
                print('----------------------');
                print('----------------------');
              }
              if (widget.isFollow! && followState is UnFollowUserSuccessState) {
                setState(() {
                  widget.isFollow = false;
                });
              }

              if (!widget.isFollow! && followState is FollowUserSuccessState) {
                setState(() {
                  widget.isFollow = true;
                });
              }
            },
          ),
          SizedBox(
            height: 18.sp,
          ),
          AppButton(
             width: 800,borderRadiusCircular: 18.sp,height: 50.sp,
            buttonColor: AppColorsController().buttonRedColor,
            child: Text(
              widget.isFollow == true
                  ? translate("un_follow")
                  : translate("follow"),
              style: AppStyle.lightSubtitle.copyWith(
                color: AppColorsController().white,
                fontWeight: FontWeight.w800,fontSize: AppFontSize.fontSize_16
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onPressed: () async {
              if (!AppUtils.checkIfGuest(context)) {
                print(widget.isFollow);
                if (widget.isFollow == true) {
                  await profileBloc.userUnFollow(widget.userId!);
                } else {
                  await profileBloc.userFollow(widget.userId!);
                }
                widget.onChanged!(widget.isFollow!);
              }
            },
          ),
          // SizedBox(
          //   height: 16.sp,
          // ),
        ],
      ),
    );
  }
}
