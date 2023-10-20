import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/utils/app_general_utils.dart';

import '../../../../blocs/ads/ads_bloc.dart';
import '../../../../blocs/ads/states/ads_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../general/icons/like_icon.dart';

class LikeButtonWidget extends StatefulWidget {
  bool? isLike;

  final Function(bool, int)? onChanged;
  final Function(bool)? onChangedLoader;
  final int? adsId;
  final int? index;
  final int? likes;

  LikeButtonWidget(
      {Key? key,
      this.isLike,
      this.index,
      this.onChanged,
      this.onChangedLoader,
      this.adsId,
      this.likes})
      : super(key: key);

  @override
  State<LikeButtonWidget> createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<LikeButtonWidget> {
  final adsBloc = DIManager.findDep<AdsCubit>();
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        BlocListener<AdsCubit, AdsState>(
          bloc: adsBloc,
          child: Row(
            children: [
              InkWell(
                onTap: () async {
                  if (!AppUtils.checkIfGuest(context)) {
                    loading = true;
                    widget.onChangedLoader!(true);
                    if (widget.isLike == true) {
                      await adsBloc.disLikeAd(widget.adsId!);
                    } else {
                      await adsBloc.likeAd(widget.adsId!);
                    }
                  }
                },
                child: widget.isLike == false
                    ? LikeIcon(
                        height: 21.sp,
                        width: 21.sp,
                      )
                    : LikeIcon(
                        height: 21.sp,
                        width: 21.sp,
                        color: AppColorsController().selectIconColor,
                      ),
              ),
              SizedBox(
                width: 8.sp,
              ),
              Text(
                "${widget.likes} " + translate("likes") ,
                style: AppStyle.verySmallTitleStyle.copyWith(
                  color: AppColorsController().black,
                  fontWeight: AppFontWeight.midLight,fontSize: AppFontSize.fontSize_14
                ),
              ),
            ],
          ),
          listener: (_, state) {
            final likeState =
                widget.isLike! ? state.disLikeAdState : state.likeAdState;

            if (loading == true && likeState is BaseFailState) {
               widget.onChangedLoader!(false);

              loading = false;
              String massage = likeState!.error!.message.toString();
              final snackBar = SnackBar(
                content: Text("${massage}"),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 1),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }

            if (loading == true &&
                widget.isLike == true! &&
                likeState is DisLikeAdSuccessState) {
              loading = false;
              widget.onChanged!(false, widget.index!);
              widget.onChangedLoader!(false);

            }

            if (loading == true &&
                widget.isLike == false! &&
                likeState is LikeAdSuccessState) {
              loading = false;
              widget.onChanged!(true, widget.index!);
            }
          },
        ),
      ],
    );
  }
}
