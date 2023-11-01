import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/constants/app_font.dart';
import 'package:wadeema/core/utils/app_general_utils.dart';
import 'package:wadeema/ui/work_focus_version/app.dart';

import '../../../../blocs/ads/ads_bloc.dart';
import '../../../../blocs/ads/states/ads_state.dart';
import '../../../../blocs/profile/profile_bloc.dart';
import '../../../../blocs/profile/states/profile_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../general/buttons/app_button.dart';
import '../../general/icons/favourites_icon.dart';

class FavouritesButtonWidget extends StatefulWidget {
  final bool? isFavourite;
  final bool? isFromPageFavourite;
  final Function(bool, int)? onChanged;
  final Function(bool)? onChangedLoader;
  final int? adsId;
  final int? index;


  FavouritesButtonWidget(
      {Key? key, this.isFavourite, this.onChanged, this.adsId, this.index,this.onChangedLoader, required this.isFromPageFavourite})
      : super(key: key);

  @override
  State<FavouritesButtonWidget> createState() => _FavouritesButtonWidgetState();
}

class _FavouritesButtonWidgetState extends State<FavouritesButtonWidget> {
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
          listener: (_, state) {

            widget.onChangedLoader!(false);

            final favouriteState = widget.isFavourite == true
                ? state.unFavouriteAdState
                : state.favouriteAdState;

            if (loading && favouriteState is BaseFailState) {
              String massage = favouriteState!.error!.message.toString();
              loading = false;
              final snackBar = SnackBar(
                content: Text("${massage}"),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 1),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }

            if (loading &&
                widget.isFavourite == true &&
                favouriteState is UnFavouriteAdSuccessState) {
              loading = false;

              widget.onChanged!(false, widget.index!);

              final snackBar = SnackBar(
                content: Center(child: Text("تم حذف الإعلان من المفضلة ",style: TextStyle(color: AppColorsController().black,fontSize: AppFontSize.fontSize_14,fontWeight: AppFontWeight.midBold),)),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 1),
                clipBehavior: Clip.hardEdge,
                backgroundColor: AppColorsController().defaultPrimaryColor,

              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }

            if (loading &&
                widget.isFavourite == false &&
                favouriteState is FavouriteAdSuccessState) {
              loading = false;
              widget.onChanged!(true, widget.index!);
              final snackBar = SnackBar(
                content: Center(child: Text("تم إضافة الإعلان إلى المفضلة ",style: TextStyle(color: AppColorsController().black,fontSize: AppFontSize.fontSize_14,fontWeight: AppFontWeight.midBold),)),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 1),
                clipBehavior: Clip.hardEdge,
                backgroundColor: AppColorsController().defaultPrimaryColor,

              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: Column(
            children: [
              widget.isFromPageFavourite == true ? SizedBox(
          height: 8.sp,
          ):   SizedBox(
                height: 18.sp,
              ),
              InkWell(
                onTap: () async {
                  widget.onChangedLoader!(true);
                  if (!AppUtils.checkIfGuest(context)) {
                    loading = true;
                    if (widget.isFavourite == true) {
                      await adsBloc.unFavouriteAd(widget.adsId!);
                    } else {
                      await adsBloc.favouriteAd(widget.adsId!);
                    }
                  }
                },
                child: widget.isFavourite == false
                    ? FavouritesIcon(
                        height: 21.sp,
                        width: 21.sp,
                      )
                    : FavouritesIcon(
                        height: 21.sp,
                        width: 21.sp,
                        color: AppColorsController().selectIconColor,
                      ),
              ),
              SizedBox(
                height: 4.sp,
              ),
            ],
          ),

        ),
      ],
    );
  }
}
