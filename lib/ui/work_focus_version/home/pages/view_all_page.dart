import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wadeema/blocs/categories/categories_bloc.dart';
import 'package:wadeema/ui/work_focus_version/ads/pages/add_main_details_page.dart';
import 'package:wadeema/ui/work_focus_version/app.dart';
import 'package:wadeema/ui/work_focus_version/home/pages/search_page.dart';
import 'package:wadeema/ui/work_focus_version/home/widget/job_ad_card.dart' as card;
import '../../../../blocs/ads/ads_bloc.dart';
import '../../../../blocs/ads/states/ads_state.dart';
import '../../../../blocs/application/application_bloc.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/widgets/general_error_widget.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
import '../../../../data/models/ads/entity/ads_entity.dart';
import '../../ads/args/argument_category.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '../../general/icons/back_icon.dart';
import '../../general/icons/filter_icon.dart';
import '../../general/icons/search_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../arg/items_args.dart';
import '../arg/view_all_args.dart';
import '../widget/build_circular_image_user.dart';
import '../widget/details_body_filter_widget.dart';
import '../widget/home_items_widget.dart';
import 'items_details_page.dart';

// type 0 for recent, 1 most rate, 2 for popular, 3 search, 4 filter
class ViewAllPage extends StatefulWidget {
  static const routeName = '/ViewAllPage';
  final ViewAllArgs arg;

  ViewAllPage({Key? key, required this.arg}) : super(key: key);

  @override
  State<ViewAllPage> createState() => _ViewAllPageState();
}

class _ViewAllPageState extends State<ViewAllPage> {
  final adsBloc = DIManager.findDep<AdsCubit>();
  final categoriesBloc = DIManager.findDep<CategoriesCubit>();

  int page = 1;
  List<ItemsAdsEntity> items = [];

  bool loading = false;
  bool loadingLoader = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);


  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    loadingLoader = true;
    // if failed,use refreshFailed()
    page = 1;
    loading = true;
    items = [];
    // items.clear();
    if (widget.arg.type == 0) {
      adsBloc.getAllRecentAds(page);
      loading = true;
    } else if (widget.arg.type == 1) {
      adsBloc.getAllMostRatedAds(page);
      loading = true;
    } else if(widget.arg.type == 2){
      adsBloc.getAllPopularAds(page);
      loading = true;
    }
    // else if(widget.arg.type == 3){
    //   adsBloc.getSearchFilterAds(page,widget.arg.title!,widget.arg.category_id!);
    //   loading = true;
    // }
    //
    // else if(widget.arg.type == 4){
    //   adsBloc.getAllFilterAds(page,widget.arg.formData!,widget.arg.category_id!);
    //   loading = true;
    // }



    else if(widget.arg.type == 3){
      adsBloc.getCategoryAds(page,widget.arg.category_id!);
      loading = true;
    }

    setState(() {});
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 30));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    page++;
    if (widget.arg.type == 0) {
      adsBloc.getAllRecentAds(page);
      loading = true;
    } else if (widget.arg.type == 1) {
      adsBloc.getAllMostRatedAds(page);
      loading = true;
    } else if(widget.arg.type == 2){
      adsBloc.getAllPopularAds(page);
      loading = true;
    }
    // else if(widget.arg.type == 3){
    //   adsBloc.getSearchFilterAds(page, widget.arg.title ?? '', widget.arg.category_id ?? -1);
    //   loading = true;
    // }
    //
    // else if(widget.arg.type == 4){
    //   adsBloc.getAllFilterAds(page, widget.arg.formData ?? {}, widget.arg.category_id ?? -1);
    //   loading = true;
    // }

    else if(widget.arg.type == 3){
      adsBloc.getCategoryAds(page, widget.arg.category_id ?? -1);
      loading = true;
    }


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

  //
  // void _makeChanged(bool newValue) {
  //   setState(() {
  //     // Loading = true;
  //     adsBloc.getAds(i.id!);
  //   });
  // }


  @override
  void initState() {
    super.initState();
    loadingLoader = true;
    if (widget.arg.type == 0) {
      adsBloc.getAllRecentAds(page);
      loading = true;
    } else if (widget.arg.type == 1) {
      adsBloc.getAllMostRatedAds(page);
      loading = true;
    } else if(widget.arg.type == 2){
      adsBloc.getAllPopularAds(page);
      loading = true;
    }
    // else if(widget.arg.type == 3){
    //   adsBloc.getSearchFilterAds(page, widget.arg.title ?? '', widget.arg.category_id ?? -1);
    //   loading = true;
    // }
    //
    // else if(widget.arg.type == 4){
    //   adsBloc.getAllFilterAds(page, widget.arg.formData??{}, widget.arg.category_id ?? -1);
    //   loading = true;
    // }

    else if(widget.arg.type == 3){
      adsBloc.getCategoryAds(page, widget.arg.category_id ?? -1);
      loading = true;
    }

  }

  void _makeLoaderChanged(bool newValue) {
    setState(() {
      print("NOOOw"+newValue.toString());
      loadingLoader =newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: LoadingColumnOverlay(
          isLoading: loadingLoader,
          child: BackLongPress(

          child: Column(
            children: [
              Container(
                height: 170.sp,
                decoration:  ThemeProvider().appMode == "light"?BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppAssets.appBarBackgroundImage),
                      fit: BoxFit.fill),
                ):BoxDecoration(
                  color: AppColorsController().white
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 10.sp),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            InkWell(
                              onTap: () {
                                DIManager.findNavigator().pop();
                              },
                              child: BackIcon(
                                width: 26.sp,
                                height: 18.sp,
                              ),
                            ),
SizedBox(
  width: MediaQuery.of(context).size.width/4.8,
),
                            Center(
                              child: Text(
                                translate("view_all"),
                                style: AppStyle.midTitleStyle.copyWith(
                                  color: AppColorsController().black,
                                  fontWeight: FontWeight.bold,fontSize: AppFontSize.fontSize_22,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [


                          Container(),

                          SizedBox(width: 12.sp,),
                          InkWell(
                            onTap: (){
                              DIManager.findNavigator().pushNamed(
                                SearchPage.routeName,
                              );
                            },
                            child: Container(
                              width: 286.sp,
                              height: 50.sp,
                              padding: EdgeInsets.symmetric(horizontal: 16.sp),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20.sp),),
                                border: Border.all(
                                    color: AppColorsController().borderColor,
                                    width: 0.2.sp
                                ),
                                color: Color.fromRGBO(255,255,255,0.1),

                              ),
                              child: Row(
                                children: [
                                  SearchIcon(
                                    height: 26.sp,
                                    width: 26.sp,
                                  ),
                                  SizedBox(width: 8.sp,),
                                    Text(
                                      widget.arg.title ?? translate("search"),
                                      style: AppStyle.verySmallTitleStyle.copyWith(
                                          color: widget.arg.title != null
                                              ? AppColorsController().black
                                              : AppColorsController().greyTextColor,
                                          fontWeight: AppFontWeight.regular,
                                  ),)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 12.sp,),

                          InkWell(
                            onTap: (){
                              final Map<String, dynamic>? dataMap = {
                                "filter":true
                              };
                              // DIManager.findNavigator().pushNamed(
                              //     SelectListingPage.routeName,
                              //     arguments: dataMap);
                                DIManager.findNavigator().pushNamed(AddMainDetailsPage.routeName,
                                    arguments: ArgumentCategory(dataMap: dataMap));
                              },
                            child: Container(
                              width: 50.sp,
                              height: 52.sp,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColorsController().black.withOpacity(0.5), width: 0.2),
                                color: AppColorsController().containerPrimaryColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.sp),
                                ),
                              ),
                              child: Center(
                                child: FilterIcon(
                                  width: 32.sp,
                                  height: 32.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: SmartRefresher(
                    enablePullDown: false,
                    enablePullUp: true,
                    scrollDirection: Axis.vertical,

                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    physics: BouncingScrollPhysics(),

                    // header: ClassicHeader(
                    //   refreshingIcon: Container(
                    //       width: 20.sp,height: 20.sp,child: CircularProgressIndicator(color: AppColorsController().buttonRedColor,strokeWidth: 1.5,)),
                    //   idleIcon: Center(child: Icon(Icons.arrow_downward,color: AppColorsController().buttonRedColor,),),
                    //   completeIcon: Center(child: Icon(Icons.check,color: AppColorsController().buttonRedColor,size: 30.sp,),),
                    //   releaseIcon: Center(child: Icon(Icons.change_circle_sharp,color: AppColorsController().buttonRedColor,size: 30.sp,),),
                    //   completeText: "",
                    //   refreshingText: "",
                    //   textStyle: TextStyle(color: AppColorsController().white),
                    // ),
                    footer: ClassicFooter(
                      height: 80,
                      noMoreIcon: Container(
                          width: 20.sp,height: 20.sp,child: CircularProgressIndicator(color: AppColorsController().buttonRedColor,strokeWidth: 1.5,)),
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
                          loadingLoader = false;
                        });
                      },
                      builder: (context, state) {

                        print("Here"+state.toString());

                        final adsState = widget.arg.type == 0
                            ? state.getAllRecentAdsState
                            : widget.arg.type == 1
                                ? state.getAllMostRatedAdsState : widget.arg.type == 2?
                                 // state.getAllPopularAdsState:widget.arg.type  == 3?state.getAllSearchAdsState:state.getAllFilterAdsState;
                                 state.getAllPopularAdsState:widget.arg.type  == 3?state.getCategoryAdsState:state.getAllFilterAdsState;

                        print("Here"+adsState.toString());
                        if (adsState is BaseFailState) {
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


                        // final adsState;

                        // switch(widget.type){
                        //   case 0:
                        //     adsState = state.getAllRecentAdsState;
                        //     break;
                        //   case 1:
                        //     adsState = state.getAllMostRatedAdsState;
                        //     break;
                        //   case 2:
                        //     adsState = state.getAllPopularAdsState;
                        //     break;
                        //   default:
                        //     adsState = state.getCategoryAdsState;
                        //     break;
                        // }

                        if (loading == true&&
                            widget.arg.type == 0 &&
                            (adsState is GetAllRecentAdsSuccessState)) {
                          final data = (state.getAllRecentAdsState
                                  as GetAllRecentAdsSuccessState)
                              .ads;
                          items.addAll(data.data!);
                          loading = false;
                          return _buildWithGridViewBody();
                        } else if (loading &&
                            widget.arg.type == 1 &&
                            (adsState is GetAllMostRatedAdsSuccessState)) {
                          final data = (state.getAllMostRatedAdsState
                                  as GetAllMostRatedAdsSuccessState)
                              .ads;
                          items.addAll(data.data!);
                          loading = false;
                         return _buildWithGridViewBody();
                        }
                        else if (loading &&
                            widget.arg.type == 2 &&
                            adsState is GetAllPopularAdsSuccessState) {
                          final data = (state.getAllPopularAdsState
                                  as GetAllPopularAdsSuccessState)
                              .ads;
                          items.addAll(data.data!);
                          loading = false;
                          return _buildWithGridViewBody();

                        }
                        // else if (loading &&
                        //     widget.arg.type == 3 &&
                        //     adsState is GetSearchFilterAdsSuccessState) {
                        //   final data = (state.getAllSearchAdsState
                        //   as GetSearchFilterAdsSuccessState)
                        //       .ads;
                        //   items.addAll(data.data!);
                        //   loading = false;
                        //   return _buildWithGridViewBody();
                        // }
                        //
                        // else if (loading &&
                        //     widget.arg.type == 4 &&
                        //     adsState is GetAllFilterAdsSuccessState) {
                        //   final data = (state.getAllFilterAdsState
                        //   as GetAllFilterAdsSuccessState)
                        //       .ads;
                        //   items.addAll(data.data!);
                        //   loading = false;
                        //   return _buildWithGridViewBody();
                        //
                        // }


                        // هذه الحالة من الصفحو الرئيسية ولانستطيع الفلترة عليها
                        else if (loading &&
                            widget.arg.type == 3 &&
                            adsState is GetCategoryAdsSuccessState) {
                          final data = (state.getCategoryAdsState
                          as GetCategoryAdsSuccessState)
                              .ads;
                          items.addAll(data.data!);
                          // loading = false;
                          return items.isEmpty?  Center(child: Text(translate("no_items_found"),style: AppStyle.midTitleStyle,)):_buildAds() ;


                        }

                        return _buildWithGridViewBody() ;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.sp,),
            ],
          ),
        ),),
      ),
      bottomSheet: bottomNavigationBarWidget(),

    );
  }

  _buildBody() {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if(categoriesBloc.isJobs(items[index].category_title??'')){
          return card.JobAdCard(
            data: items[index],
            onPress: () {
              DIManager.findNavigator().pushNamed(
                ItemsDetailsPage.routeName,
                arguments: ItemsArgs(id: items[index].ad_id ?? 0),
              );
            },
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BuildCircularImageUser(
                        size: 40.sp,
                        url: items![index]?.profile_pic,
                        id: items![index]?.user_id,
                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                      Text(
                        "${items![index]!.user_name} , ",
                        style: AppStyle.smallTitleStyle.copyWith(
                          color: AppColorsController().black,
                          fontWeight: AppFontWeight.midLight,
                        ),
                      ),
                      Text(
                        items![index]!.date_ad != null
                            ? getComparedTime(items![index]!.date_ad!)
                                .toString()!
                            : "",
                        style: AppStyle.smallTitleStyle.copyWith(
                          color: AppColorsController().black,
                          fontWeight: AppFontWeight.midLight,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: RatingBarIndicator(
                      rating: items![index]!.average?.toDouble() ?? 0,
                      itemCount: 5,
                      itemSize: 17.sp,
                      unratedColor: AppColorsController().darkGreyTextColor,
                      direction: Axis.horizontal,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        size: 13.sp,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 4.sp,
            ),
            DetailsBodyFilterWidget(
              onPressedLike: _makeLikeChanged,
              onPressedFavourite: _makeFavouriteChanged,
              onPressedLoader: _makeLoaderChanged,
              id: items![index]?.id!,
              data: items![index],
              index: index,
            ),
            SizedBox(height: 6.sp,),
            Container(
              height: 1.sp,
              width: MediaQuery.of(context).size.width,
              color: AppColorsController().defaultPrimaryColor,
            ),
            SizedBox(
              height: 5.sp,
            ),
          ],
        );
      },
      itemCount: items!.length!,
    );
  }



  _buildWithGridViewBody() {
    return widget.arg.type == 3? ListView.builder(
      primary: false,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return card.JobAdCard(
          data: items[index],
          onPress: () {
            DIManager.findNavigator().pushNamed(
              ItemsDetailsPage.routeName,
              arguments: ItemsArgs(id: items[index].ad_id ?? 0),
            );
          },
        );

      },
      itemCount: items.length,
    ): Padding(
      padding:  EdgeInsets.all(12.sp),
      child:  GridView.builder(
        itemCount:  items.length,
        shrinkWrap: true,

        itemBuilder: (context, index) {
          if(categoriesBloc.isJobs(items[index].category_title??'')){
            return card.JobAdCard(
              data: items[index],
              onPress: () {
                DIManager.findNavigator().pushNamed(
                  ItemsDetailsPage.routeName,
                  arguments: ItemsArgs(id: items[index].ad_id ?? 0),
                );
              },
            );
          }
          return widget.arg.type == 3?card.JobAdCard(
            data: items[index],
            onPress: () {
              DIManager.findNavigator().pushNamed(
                ItemsDetailsPage.routeName,
                arguments: ItemsArgs(id: items[index].ad_id ?? 0),
              );
            },
          ): HomeItemsWidget(

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


/*


HomeItemsWidget(

                        onPress: () {
                          DIManager.findNavigator()
                              .pushNamed(ItemsDetailsPage.routeName,
                                  arguments: ItemsArgs(
                                    id: itemsList[index].ad_id??0,
                                  ));
                        },
                        data: itemsList[index],
                      );
 */
  _buildAdsBody() {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if(categoriesBloc.isJobs(items[index].category_title??'')){
          return card.JobAdCard(
            data: items[index],
            onPress: () {
              DIManager.findNavigator().pushNamed(
                ItemsDetailsPage.routeName,
                arguments: ItemsArgs(id: items[index].ad_id ?? 0),
              );
            },
          );
        }
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BuildCircularImageUser(
                          size: 48.sp,
                          url: items![index]?.profile_pic,
                          id: items![index]?.user_id,
                        ),

                        // Text(
                        //   "${items![index]!.user_name} , ",
                        //   style: AppStyle.smallTitleStyle.copyWith(
                        //     color: AppColorsController().black,
                        //     fontWeight: AppFontWeight.midLight,
                        //   ),
                        // ),
                        // Text(
                        //   items![index]!.date_ad != null
                        //       ? getComparedTime(items![index]!.date_ad!)
                        //       .toString()!
                        //       : "",
                        //   style: AppStyle.smallTitleStyle.copyWith(
                        //     color: AppColorsController().black,
                        //     fontWeight: AppFontWeight.midLight,
                        //   ),
                        // ),
                      ],
                    ),
                    Container(
                      child: RatingBarIndicator(
                        rating: items[index].average?.toDouble() ?? 0,
                        itemCount: 5,
                        itemSize: 17.sp,
                        unratedColor: AppColorsController().darkGreyTextColor,
                        direction: Axis.horizontal,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          size: 13.sp,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 18.sp,
              ),
              DetailsBodyFilterWidget(
                onPressedLike: _makeLikeChanged,
                onPressedFavourite: _makeFavouriteChanged,
                onPressedLoader: _makeLoaderChanged,
                id: items![index]?.id!,
                data: items![index],
                index: index,
              ),
              SizedBox(height: 16.sp,),
              Container(
                height: 1.sp,
                width: MediaQuery.of(context).size.width,
                color: AppColorsController().black,
              ),
            ],
          ),
        );
      },
      itemCount: items.length,
    );
  }

  _buildAds() {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if(categoriesBloc.isJobs(items[index].category_title??'')){
          return card.JobAdCard(
            data: items[index],
            onPress: () {
              DIManager.findNavigator().pushNamed(
                ItemsDetailsPage.routeName,
                arguments: ItemsArgs(id: items[index].ad_id ?? 0),
              );
            },
          );
        }
        return Padding(
          padding:  EdgeInsets.all(10.sp),
          child:  HomeItemsWidget(

            onPress: () {
              DIManager.findNavigator()
                  .pushNamed(ItemsDetailsPage.routeName,
                  arguments: ItemsArgs(
                    id: items[index].ad_id??0,
                  ));
            },
            data: items[index],
          ),
        );;
      },
      itemCount: items.length,
    );
  }
}

//
//
// class JobAdsCard extends StatefulWidget {
//   final ItemsAdsEntity? data;
//   final double? height;
//   final Function() onPress;
//   final double? width;
//   final bool weNeedJustImage;
//   const JobAdsCard(
//       {Key? key, this.data, this.width, this.height, required this.onPress,this.weNeedJustImage = false})
//       : super(key: key);
//
//   @override
//   State<JobAdsCard> createState() => _JobAdsCardState();
// }
//
//
//
// class _JobAdsCardState extends State<JobAdsCard> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: widget.height,
//       width: widget.width,
//       decoration: BoxDecoration(
//         border: Border.all(
//             color: AppColorsController().buttonRedColor, width: 0.2.sp),
//         color: AppColorsController().card,
//         borderRadius: BorderRadius.all(
//           Radius.circular(16.sp),
//         ),
//       ),
//       margin: EdgeInsets.all(widget.width == null ? 12.sp : 0),
//       child: TextButton(
//         onPressed: widget.onPress,
//         style: TextButton.styleFrom(
//             padding: EdgeInsets.zero,
//             foregroundColor: AppColorsController().dropdown,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.sp)))),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10.sp),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.symmetric(vertical: 8.sp),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(child: _titleWidget()),
//                             Padding(
//                               padding:  EdgeInsets.only(top:0.0,left: 4.sp,right: 4.sp),
//                               child: widget.weNeedJustImage? widget.data?.profile_pic!=null && widget.data?.profile_pic != ''? ClipOval(
//                                 child: Image.network(
//                                   AppConsts.IMAGE_URL+'${widget.data?.profile_pic}',
//                                   width: 32.sp,
//                                   height: 32.sp,
//                                   fit: BoxFit.fill,
//                                 ),):AccountIcon(
//                                 height: 32.sp,
//                                 width: 32.sp,
//                               ): BuildCircularImageUser(
//                                 url: widget.data?.profile_pic,
//                                 id: widget.data?.user_id,
//                                 size: 25.sp,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       _descriptionWidget(),
//                       _priceAndDateWidget(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 // Expanded(
//                 //   child: Padding(
//                 //     padding: EdgeInsets.symmetric(horizontal: 10.sp),
//                 //     child: Text(
//                 //       data?.city ?? '',
//                 //       style: AppStyle.lightSubtitle.copyWith(
//                 //           color: AppColorsController().black,
//                 //           fontWeight: AppFontWeight.midLight,
//                 //           overflow: TextOverflow.ellipsis),
//                 //       maxLines: 1,
//                 //     ),
//                 //   ),
//                 // ),
//                 _chatButton(context)
//               ],
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _propWidget({required String image, required String title}) {
//     return Row(
//       children: [
//         SvgPicture.asset(image, height: 18.sp, width: 18.sp),
//         SizedBox(width: 6,),
//         Text(title, style: AppStyle.lightSubtitle.copyWith(
//             color: AppColorsController().black,
//             fontWeight: AppFontWeight.midLight,fontSize: AppFontSize.fontSize_12
//         ),)
//       ],
//     );
//   }
//
//   Widget _priceAndDateWidget() {
//     return Padding(
//       padding:  EdgeInsets.symmetric(vertical: 1.sp,),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Flexible(
//                 flex: 1,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 0.sp),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         _getTitle(PropType.SALARY, withTitle: true) ?? '',
//                         style: AppStyle.lightSubtitle.copyWith(
//                             color: AppColorsController().black,
//                             fontWeight: AppFontWeight.midLight,fontSize: AppFontSize.fontSize_12
//                         ),
//                       ),
//                       SizedBox(height: 2.sp,),
//                       Text(
//                         _getTitle(PropType.EMP_TYPE) ?? '',
//                         style: AppStyle.lightSubtitle.copyWith(
//                             color: AppColorsController().black,
//                             fontWeight: AppFontWeight.midLight,fontSize: AppFontSize.fontSize_12
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(bottom: 4.sp),
//                 child: Text(
//                   "${widget.data?.availability_status}",
//                   style: AppStyle.lightSubtitle.copyWith(
//                       color: AppColorsController().greyTextColor,
//                       fontWeight: AppFontWeight.midLight,fontSize: AppFontSize.fontSize_12
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               _propWidget(
//                   image: 'assets/icons/ic_job.svg', title: _getTitle(PropType.EXPERIENCE) ?? ''),
//               SizedBox(width: 8.sp,),
//               _propWidget(
//                   image: 'assets/icons/ic_graduation.svg', title: _getTitle(PropType.EDUCATION) ?? ''),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   String? _getTitle(PropType propType,{bool withTitle = false}) {
//     for (CategoryAdsDetailsEntity element in widget.data?.properties ?? []) {
//       switch (propType) {
//         case PropType.EMP_TYPE:
//           if ((element.title?.contains('نوع') ?? false) || (element.title?.toLowerCase().contains('type') ?? false)) {
//             return withTitle ? '${element.title}: ${element.description}' : element.description;
//           }
//           break;
//         case PropType.EXPERIENCE:
//           if ((element.title?.contains('خبرة') ?? false) ||
//               (element.title?.toLowerCase().contains('experience') ?? false)) {
//             return withTitle ? '${element.title}: ${element.description}' : element.description;
//           }
//           break;
//         case PropType.EDUCATION:
//           if ((element.title?.contains('تعليم') ?? false) ||
//               (element.title?.toLowerCase().contains('education') ?? false)) {
//             return withTitle ? '${element.title}: ${element.description}' : element.description;
//           }
//           break;
//
//         case PropType.SALARY:
//           if ((element.title?.contains('راتب') ?? false) ||
//               (element.title?.toLowerCase().contains('salary') ?? false)) {
//             return withTitle ? '${element.title}: ${element.description}' : element.description;
//           }
//           break;
//       }
//     }
//     return null;
//   }
//
//   Widget _titleWidget() {
//     return Text(
//       widget.data?.title ?? '',
//       style: AppStyle.defaultStyle.copyWith(
//           color: AppColorsController().black,
//           fontWeight: AppFontWeight.bold,
//           overflow: TextOverflow.ellipsis,fontSize: AppFontSize.fontSize_14
//       ),
//       maxLines: 1,
//     );
//   }
//
//   Widget _descriptionWidget() {
//     return Text(
//       widget.data?.short_description ?? '',
//       style: AppStyle.verySmallTitleStyle.copyWith(
//           color: AppColorsController().black,
//           overflow: TextOverflow.ellipsis,fontSize: AppFontSize.fontSize_12
//       ),
//       maxLines: 2,
//     );
//   }
//
//   Widget _chatButton(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (!AppUtils.checkIfGuest(context)) {
//           DIManager.findNavigator().pushNamed(ChatMessagesPage.routeName,
//               arguments: ArgumentMessage(user_id_2: widget.data?.user_id, ad_id: widget.data?.ad_id));
//         }
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           // color: AppColorsController().white,
//             color: Colors.white,
//             border: Border.all(color: AppColorsController().dropdown, width: 0.5.sp),
//             borderRadius: BorderRadius.only(
//                 bottomRight: Radius.circular(
//                     DIManager.findDep<ApplicationCubit>().appLanguage.languageCode == AppConsts.LANG_AR ? 0 : 16.sp),
//                 topLeft: Radius.circular(
//                     DIManager.findDep<ApplicationCubit>().appLanguage.languageCode == AppConsts.LANG_AR ? 0 : 16.sp),
//                 topRight: Radius.circular(
//                     DIManager.findDep<ApplicationCubit>().appLanguage.languageCode == AppConsts.LANG_AR ? 16.sp : 0),
//                 bottomLeft: Radius.circular(
//                     DIManager.findDep<ApplicationCubit>().appLanguage.languageCode == AppConsts.LANG_AR ? 16.sp : 0))),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 4.sp,vertical: 2.sp),
//           child: Row(
//             children: [
//               Padding(
//                 padding: EdgeInsetsDirectional.only(start: 8.sp, end: 4.sp),
//                 child: Text(translate("chat"), style: AppStyle.lightSubtitle.copyWith(
//                     color: AppColorsController().dropdown,
//                     fontWeight: AppFontWeight.midLight,fontSize: AppFontSize.fontSize_14,
//                     overflow: TextOverflow.ellipsis)),
//               ),
//               Padding(
//                 padding: EdgeInsetsDirectional.only(start: 4.sp, end: 8.sp),
//                 child: ChatIcon(
//                   width: 18.sp,
//                   height: 18.sp,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// String getComparedTime(DateTime dateTime) {
//   Duration difference = DateTime.now().difference(dateTime);
//   final List prefix = [
//     translate("just now"),
//     translate("second(s)"),
//     translate("minute(s)"),
//     translate("hour(s)"),
//     translate("day(s)"),
//     translate("month(s)"),
//     translate("year(s)")
//   ];
//   if (difference.inDays == 0) {
//     if (difference.inMinutes == 0) {
//       if (difference.inSeconds < 20) {
//         return (prefix[0]);
//       } else {
//         return ("${difference.inSeconds} ${prefix[1]}");
//       }
//     } else {
//       if (difference.inMinutes > 59) {
//         return ("${(difference.inMinutes / 60).floor()} ${prefix[3]}");
//       } else {
//         return ("${difference.inMinutes} ${prefix[2]}");
//       }
//     }
//   } else {
//     if (difference.inDays > 30) {
//       if (((difference.inDays) / 30).floor() > 12) {
//         return ("${((difference.inDays / 30) / 12).floor()} ${prefix[6]}");
//       } else {
//         return ("${(difference.inDays / 30).floor()} ${prefix[5]}");
//       }
//     } else {
//       return ("${difference.inDays} ${prefix[4]}");
//     }
//   }
// }
