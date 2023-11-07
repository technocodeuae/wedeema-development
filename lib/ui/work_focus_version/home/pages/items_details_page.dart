import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/constants/app_colors.dart';

import '../../../../blocs/ads/ads_bloc.dart';
import '../../../../blocs/ads/states/ads_state.dart';
import '../../../../blocs/application/application_bloc.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/widgets/general_error_widget.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/icons/back_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../arg/items_args.dart';
import '../widget/details_body_widget.dart';

class ItemsDetailsPage extends StatefulWidget {
  static const routeName = '/ItemsDetailsPage';

  final ItemsArgs? args;

  const ItemsDetailsPage({Key? key, this.args}) : super(key: key);

  @override
  State<ItemsDetailsPage> createState() => _ItemsDetailsPageState();
}

class _ItemsDetailsPageState extends State<ItemsDetailsPage> {
  final adsBloc = DIManager.findDep<AdsCubit>();

  dynamic data;

  bool Loading = false;
  bool LoadingLoader = false;

  void _makeChanged(bool newValue) {
    setState(() {
      Loading = true;
      adsBloc.getAds(widget.args!.id!);
    });
  }

  void _makeFavouriteChanged(bool newValue, int index) {
    setState(() {
      data?.ad?.is_favorite = (newValue == false ? 0 : 1);
    });
  }

  void _makeLoaderChanged(bool newValue) {
    setState(() {
      print("NOOOw"+newValue.toString());
      LoadingLoader =newValue;
    });
  }

  void _makeLikeChanged(bool newValue, int index) {
    setState(() {
      data?.ad?.is_liked = (newValue == false ? 0 : 1);
      if (newValue == true)
        data?.ad?.likes++;
      else
        data?.ad?.likes--;
    });
  }

  @override
  void initState() {
    Loading = true;
    LoadingLoader = true;

    adsBloc.getAds(widget.args!.id!);
  }



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print('widget.typeAds :${widget.args!.type}');
    print('widget.title :${widget.args!.title}');
    return Scaffold(

        backgroundColor: AppColorsController().scaffoldBGColorAdds,
        body: SafeArea(
          child: LoadingColumnOverlay(
            isLoading: LoadingLoader,
            child: BackLongPress(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppBarWidget(
                      name: translate("ads"),
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
                    BlocConsumer<AdsCubit, AdsState>(
                      bloc: adsBloc,
                      listener: (context, state) {
                        setState(() {
                          LoadingLoader = false;
                        });
                      },
                      builder: (context, state) {
                        final adsState = state.getAdsDetailsState;

                        if (Loading == true && adsState is BaseFailState) {
                          Loading = false;
                          return Column(
                            children: [
                              VerticalPadding(3.sp),
                              GeneralErrorWidget(
                                error: adsState.error,
                                callback: adsState.callback,
                              ),
                            ],
                          );
                        }
                        if (Loading == true &&
                            adsState is AdsDetailsSuccessState) {
                          data =
                              (state.getAdsDetailsState as AdsDetailsSuccessState)
                                  .ads;
                          Loading = false;
                          return _buildBody(typeAds: widget.args!.type ??'',categoryId: widget.args!.categoryId??0);
                        }
                        return data == null ? Container() : _buildBody(typeAds: widget.args!.type ??'',categoryId: widget.args!.categoryId??0);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  _buildBody({String? typeAds,required int categoryId}) {
    return DetailsBodyWidget(
      onPressedAddComment: _makeChanged,
      onPressedLike: _makeLikeChanged,
      onPressedFavourite: _makeFavouriteChanged,
      onPressedLoader: _makeLoaderChanged,
      id: widget.args?.id!,
      data: data,
      index: -1,
      categoryId:categoryId,
      typeAds: typeAds,
    );
  }
}
