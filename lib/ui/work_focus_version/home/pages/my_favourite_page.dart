import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wadeema/ui/work_focus_version/home/widget/home_items_favourite.dart';
import '../../../../blocs/ads/ads_bloc.dart';
import '../../../../blocs/ads/states/ads_state.dart';
import '../../../../blocs/categories/categories_bloc.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/widgets/general_error_widget.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
import '../../../../data/models/ads/entity/ads_entity.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '../../general/icons/back_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../arg/items_args.dart';
import '../widget/build_circular_image_user.dart';
import '../widget/details_body_filter_widget.dart';
import '../widget/job_ad_card.dart';
import 'items_details_page.dart';

class MyFavouritePage extends StatefulWidget {
  static const routeName = '/MyFavouritePage';

  MyFavouritePage({Key? key}) : super(key: key);

  @override
  State<MyFavouritePage> createState() => _MyFavouritePageState();
}

class _MyFavouritePageState extends State<MyFavouritePage> {
  final adsBloc = DIManager.findDep<AdsCubit>();
  final categoriesBloc = DIManager.findDep<CategoriesCubit>();
  int page = 1;
  List<ItemsAdsEntity> items = [];
 late AdsEntity data;
  bool loading = false;
  bool loadingLodar = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    page = 1;
    loading = true;
    loadingLodar = true;

    items = [];
    adsBloc.getMyFavouriteAds(page);
    setState(() {});
    _refreshController.refreshCompleted();
  }



  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 30));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    page++;

    adsBloc.getMyFavouriteAds(page);
    loading = true;

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  void _makeFavouriteChanged(bool newValue, int index) {
    setState(() {
      items![index]?.is_favorite = (newValue == false ? 0 : 1);
    });
  }

  void _makeLikeChanged(bool newValue, int index) {
    setState(() {
      items![index]?.is_liked = (newValue == false ? 0 : 1);
      if (newValue == true)
        items![index]?.likes++;
      else
        items![index]?.likes--;
    });
  }
  void _makeLoaderChanged(bool newValue) {
    setState(() {
      print("NOOOw"+newValue.toString());
      loadingLodar =newValue;
    });
  }

  @override
  void initState() {
    super.initState();

    adsBloc.getMyFavouriteAds(page);
    loading = true;
    loadingLodar = true;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(

      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SafeArea(
            child: LoadingColumnOverlay(
              isLoading: loadingLodar,
              child: SafeArea(
                child: BackLongPress(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppBarWidget(
                        name: translate("my_favourite"),
                        child: InkWell(
                          onTap: () {
                            DIManager.findNavigator().pop();
                          },
child: Container(
  width: 35.sp,height: 35.sp,
),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: SmartRefresher(
                            enablePullDown: true,
                            enablePullUp: true,
                            scrollDirection: Axis.vertical,
                            controller: _refreshController,
                            onRefresh: _onRefresh,
                            header: ClassicHeader(
                              refreshingIcon: Container(
                                  width: 20.sp,height: 20.sp,child: CircularProgressIndicator(color: AppColorsController().buttonRedColor,strokeWidth: 1.5,)),
                              idleIcon: Center(child: Icon(Icons.arrow_downward,color: AppColorsController().buttonRedColor,),),
                              completeIcon: Center(child: Icon(Icons.check,color: AppColorsController().buttonRedColor,size: 30.sp,),),
                              releaseIcon: Center(child: Icon(Icons.change_circle_sharp,color: AppColorsController().buttonRedColor,size: 30.sp,),),
                              completeText: "",
                              refreshingText: "",
                              textStyle: TextStyle(color: AppColorsController().white),
                            ),
                            footer: ClassicFooter(
                              height: 80,
                              noMoreIcon: Center(child: Icon(Icons.arrow_upward,color: AppColorsController().buttonRedColor,),),
                              idleIcon: Center(child: Icon(Icons.arrow_upward,color: AppColorsController().buttonRedColor,),),
                              loadingIcon:  Container(
                                  width: 20.sp,height: 20.sp,child: CircularProgressIndicator(color: AppColorsController().buttonRedColor,strokeWidth: 1.5,)),
                              canLoadingIcon: Center(child: Icon(Icons.change_circle_sharp,color: AppColorsController().buttonRedColor,size: 30.sp,),),
                              canLoadingText: "",
                              loadingText: "",
                              textStyle: TextStyle(color: AppColorsController().white),
                            ),
                            onLoading: _onLoading,
                            child: BlocConsumer<AdsCubit, AdsState>(
                                bloc: adsBloc,
                                listener: (context, state) {
                                  setState(() {
                                    loadingLodar = false;
                                  });
                                },
                                builder: (context, state) {
                                  print("Here" + state.toString());

                                  final adsState = state.getMyFavouriteAdsState;

                                  print("Here" + adsState.toString());
                                  if (adsState is BaseFailState) {
                                    return Column(
                                      children: [
                                        VerticalPadding(3.0),
                                        GeneralErrorWidget(
                                          error: adsState.error,
                                          callback: adsState.callback,
                                        ),
                                      ],
                                    );
                                  }

                                  if (loading == true &&
                                      (adsState
                                          is GetAllMyFavouriteAdsSuccessState)) {
                                     data = (state.getMyFavouriteAdsState
                                            as GetAllMyFavouriteAdsSuccessState)
                                        .ads;
                                    items.addAll(data.data!);
                                    loading = false;
                                    return items.isNotEmpty && loading ==false? _buildWithGridViewBody():  loading ==true?Container():Center(child: Container(child: Text('لايوجد إعلانات في المفضلة'),),);
                                  }
                                  return items.isNotEmpty && loading ==false? _buildWithGridViewBody(): loading ==true?Container():Center(child: Container(child: Text('لايوجد إعلانات في المفضلة'),),);
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBarWidget(indexPage: 3),
        ],
      ),
      // bottomSheet: bottomNavigationBarWidget(),
    );
  }
  //
  // _buildBody() {
  //   return ListView.separated(
  //     primary: false,
  //     shrinkWrap: true,
  //     physics: NeverScrollableScrollPhysics(),
  //     itemBuilder: (context, index) {
  //       return Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 16.sp),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     BuildCircularImageUser(
  //                       size: 48.sp,
  //                       url: items![index]?.profile_pic,
  //                       id: items![index]?.user_id,
  //                     ),
  //                     SizedBox(
  //                       width: 4.sp,
  //                     ),
  //                     Text(
  //                       "${items![index]!.user_name} , ",
  //                       style: AppStyle.smallTitleStyle.copyWith(
  //                         color: AppColorsController().black,
  //                         fontWeight: AppFontWeight.midLight,
  //                       ),
  //                     ),
  //                     Text(
  //                       items![index]!.date_ad != null
  //                           ? getComparedTime(items![index]!.date_ad!)
  //                               .toString()!
  //                           : "",
  //                       style: AppStyle.smallTitleStyle.copyWith(
  //                         color: AppColorsController().black,
  //                         fontWeight: AppFontWeight.midLight,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 Container(
  //                   child: RatingBarIndicator(
  //                     rating: items![index]!.average?.toDouble() ?? 0,
  //                     itemCount: 5,
  //                     itemSize: 17.sp,
  //                     unratedColor: AppColorsController().darkGreyTextColor,
  //                     direction: Axis.horizontal,
  //                     itemBuilder: (context, _) => Icon(
  //                       Icons.star,
  //                       size: 13.sp,
  //                       color: Colors.amber,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           SizedBox(
  //             height: 18.sp,
  //           ),
  //           DetailsBodyFilterWidget(
  //             onPressedLike: _makeLikeChanged,
  //             onPressedFavourite: _makeFavouriteChanged,
  //             onPressedLoader: _makeLoaderChanged,
  //             id: items![index]?.id!,
  //             data: items![index],
  //             index: index,
  //           ),
  //           SizedBox(
  //             height: 16.sp,
  //           ),
  //           Container(
  //             height: 1.sp,
  //             width: MediaQuery.of(context).size.width,
  //             color: AppColorsController().black,
  //           ),
  //         ],
  //       );
  //     },
  //     itemCount: items!.length!,
  //     separatorBuilder: (BuildContext context, int index) {
  //       return SizedBox(
  //         height: 8.sp,
  //       );
  //     },
  //   );
  // }

  _buildWithGridViewBody() {
    return Padding(
      padding:  EdgeInsets.all(12.sp),
      child:  GridView.builder(
        itemCount:  items.length,
        shrinkWrap: true,

        itemBuilder: (context, index) {
          // if (categoriesBloc.isJobs(data?.?[index].category_title ?? '')) {
          //
          //   return JobAdCard(
          //     weNeedJustImage: true,
          //     // height: MediaQuery.sizeOf(context).height * 0.23,
          //     // height: 250.sp,
          //     width: MediaQuery.sizeOf(context).width * 0.85,
          //     data: data?.active_ads?[index],
          //     onPress: () {
          //       DIManager.findNavigator().pushNamed(
          //         ItemsDetailsPage.routeName,
          //         arguments: ItemsArgs(id: data?.active_ads?[index].ad_id ?? 0),
          //       );
          //     },
          //   );
          // }     // if (categoriesBloc.isJobs(data?.?[index].category_title ?? '')) {
          //
          //   return JobAdCard(
          //     weNeedJustImage: true,
          //     // height: MediaQuery.sizeOf(context).height * 0.23,
          //     // height: 250.sp,
          //     width: MediaQuery.sizeOf(context).width * 0.85,
          //     data: data?.active_ads?[index],
          //     onPress: () {
          //       DIManager.findNavigator().pushNamed(
          //         ItemsDetailsPage.routeName,
          //         arguments: ItemsArgs(id: data?.active_ads?[index].ad_id ?? 0),
          //       );
          //     },
          //   );
          // }
        return HomeItemsFavorite(
onChangedLoaderFavourite: _makeLoaderChanged,
            adsIdFavourite: items[index].id!,
            onChangedFavourite:_makeFavouriteChanged ,
            indexFavourite: index,

            onPress: () {
              DIManager.findNavigator()
                  .pushNamed(ItemsDetailsPage.routeName,
                  arguments: ItemsArgs(
                    id: items[index].ad_id??0,
                  ));
            },
            data: items[index],
          );
        },
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 210.sp,
          crossAxisSpacing: 6.sp,
          mainAxisSpacing: 18.sp,
        ),
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }


}
