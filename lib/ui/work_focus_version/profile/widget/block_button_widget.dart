import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/utils/app_general_utils.dart';

import '../../../../blocs/profile/profile_bloc.dart';
import '../../../../blocs/profile/states/profile_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/utils/localization/app_localizations.dart';

class BlockButtonWidget extends StatefulWidget {
  bool? isBlock;
  final Function(bool)? onChanged;
  final int? userId;
  final Color? colorText;

  BlockButtonWidget({Key? key, this.isBlock, this.onChanged, this.userId,this.colorText =Colors.black})
      : super(key: key);

  @override
  State<BlockButtonWidget> createState() => _BlockButtonWidgetState();
}

class _BlockButtonWidgetState extends State<BlockButtonWidget> {
  bool block = false;

  final profileBloc = DIManager.findDep<ProfileCubit>();

  @override
  void initState() {
    super.initState();
    block = widget.isBlock!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocListener<ProfileCubit, ProfileState>(
          bloc: profileBloc,
          child: Container(),
          listener: (_, state) {
            final blockState =
                widget.isBlock! ? state.unBlockUserState : state.blockUserState;

            if (blockState is BaseFailState) {
              String massage = blockState!.error!.message.toString();
              final snackBar = SnackBar(
                content: Text("${massage}"),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 1),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }

            if (widget.isBlock! && blockState is UnBlockUserSuccessState) {
              setState(() {
                widget.isBlock = false;
              });
            }

            if (!widget.isBlock! && blockState is BlockUserSuccessState) {
              setState(() {
                widget.isBlock = true;
              });
            }
          },
        ),
        SizedBox(
          height: 18.sp,
        ),
        InkWell(
          onTap: () async {
            if (!AppUtils.checkIfGuest(context)) {
              if (widget.isBlock == true) {
                await profileBloc.userUnBlock(widget.userId!);
              } else {
                await profileBloc.userBlock(widget.userId!);
              }
              widget.onChanged!(widget.isBlock!);
            }
          },
          child: Text(
            widget.isBlock == true ? translate("un_block") : translate("block"),
            style: AppStyle.defaultStyle.copyWith(
              color:widget.colorText,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
