import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wadeema/blocs/categories/categories_bloc.dart';
import 'package:wadeema/core/constants/app_consts.dart';
import 'package:wadeema/ui/work_focus_version/home/widget/job_ad_card.dart';

import '../../../../blocs/ads/ads_bloc.dart';
import '../../../../blocs/ads/states/ads_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/widgets/general_error_widget.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
import '../../../../data/models/ads/entity/ads_entity.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../arg/items_args.dart';
import '../arg/view_all_args.dart';
import '../pages/items_details_page.dart';
import '../pages/view_all_page.dart';
import 'ads_shimmer_widget.dart';
import 'home_items_widget.dart';

class BuildItemsAds extends StatefulWidget {
  final String name;
  final String nameType ;

  final int type;
  final int? category_id;
  final bool? is_category;

  const BuildItemsAds(
      {Key? key,
      required this.name,
      required this.type,
      this.category_id,
        required  this.nameType,
      this.is_category})
      : super(key: key);

  @override
  State<BuildItemsAds> createState() => _BuildItemsAdsState();
}

class _BuildItemsAdsState extends State<BuildItemsAds> {
  final adsBloc = DIManager.findDep<AdsCubit>();
  int page = 1;
  List<ItemsAdsEntity> itemsList = [];

  final categoriesBloc = DIManager.findDep<CategoriesCubit>();

  bool loading = false;
  bool isFirstLoading = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    page = 1;
    loading = true;
    isFirstLoading = true;
    itemsList = [];
    adsBloc.getCategoryAds(page, widget.category_id!);
    loading = true;


    setState(() {});
    _refreshController.refreshCompleted();
  }
bool isLoadingFooter = false;
  void _onLoading() async {
    // monitor network fetch
    isLoadingFooter = false;
    await Future.delayed(Duration(seconds: 1));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    page++;
    adsBloc.getCategoryAds(page, widget.category_id!);

    loading = true;

    if (mounted) setState(() {});
    _refreshController.loadComplete();
    isLoadingFooter = true;
  }



  @override
  void initState() {
    super.initState();
    adsBloc.getCategoryAds(page, widget.category_id!);
    loading = true;
    isFirstLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    print('--------------------------------------------------${widget.type}');
    return BlocConsumer<AdsCubit, AdsState>(
      bloc: adsBloc,
      listener: (context, state) {},
      builder: (context, state) {
        final adsState =state.getCategoryAdsState;;


        if (adsState is BaseFailState) {
          isFirstLoading = false;

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

       if (loading && adsState is GetCategoryAdsSuccessState) {
          final data =
              (state.getCategoryAdsState as GetCategoryAdsSuccessState).ads;
          itemsList.addAll(data.data!);
          loading = false;
          isFirstLoading = false;

          return itemsList.isEmpty
              ? Center(
              child: Text(
                translate("no_items_found"),
                style: AppStyle.midTitleStyle,
              ))
              :
          /*
          widget.nameType == 'وظائف'? ListView.builder(
            primary: false,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return JobAdCard(
                data: itemsList[index],
                onPress: () {
                  DIManager.findNavigator().pushNamed(
                    ItemsDetailsPage.routeName,
                    arguments: ItemsArgs(id: itemsList[index].ad_id ?? 0),
                  );
                },
              );

            },
            itemCount: itemsList.length,
          ):

          */
          SmartRefresher(
            physics: BouncingScrollPhysics(),
            enablePullDown: false,
            enablePullUp: true,
            scrollDirection: Axis.vertical,
            controller: _refreshController,
            onRefresh: _onRefresh,
            footer: ClassicFooter(
              height: 80.sp,
              noMoreIcon: Center(
                child: Icon(
                  Icons.arrow_upward,
                  color: AppColorsController().buttonRedColor,
                ),
              ),
              idleIcon: itemsList.length != 8? Center(
                child: Icon(
                  Icons.arrow_upward,
                  color: AppColorsController().buttonRedColor,
                ),
              ):Center(
                child: Icon(
                  Icons.arrow_downward,
                  color: AppColorsController().buttonRedColor,
                ),
              ),
              loadingIcon: Container(
                  width: 20.sp,
                  height: 20.sp,
                  child: CircularProgressIndicator(
                    color: AppColorsController().buttonRedColor,
                    strokeWidth: 1.5,
                  )),
              canLoadingIcon: Center(
                child: Icon(
                  Icons.change_circle_sharp,
                  color: AppColorsController().buttonRedColor,
                  size: 30.sp,
                ),
              ),
              canLoadingText: "",
              loadingText: "",
              textStyle: TextStyle(color: AppColorsController().white),
            ),
            onLoading: _onLoading,
            child: GridView.builder(
              itemCount: itemsList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                          if (categoriesBloc.isJobs(
                    itemsList[index].category_title ?? '')) {
                  return SizedBox(
                    child: JobAdCard(
                      isUseGridView: true,
                      width:
                      MediaQuery.sizeOf(context).width * 0.85,
                      data: itemsList[index],
                      onPress: () {
                        DIManager.findNavigator().pushNamed(
                          ItemsDetailsPage.routeName,
                          arguments: ItemsArgs(
                              id: itemsList[index].ad_id ?? 0   ,  categoryId: itemsList[index].category_id ?? 0,type: 'jobAds'),
                        );
                      },
                    ),
                  );
                }
                return HomeItemsWidget(

                  onPress: () {
                    DIManager.findNavigator()
                        .pushNamed(ItemsDetailsPage.routeName,
                        arguments: ItemsArgs(
                          id: itemsList[index].ad_id ?? 0,categoryId: itemsList[index].category_id ?? 0
                        ));
                  },
                  data: itemsList[index],
                );
              },
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 200.sp,
                crossAxisSpacing: 6.sp,
                mainAxisSpacing: 18.sp,
              ),
              physics: NeverScrollableScrollPhysics(),
            ),
          );
        }
        return isFirstLoading == true ? AdsShimmerWidget(
          name: translate('ads'),
          type: widget.type,
          is_category: widget.is_category,):
        /*

          isFirstLoading == true && widget.nameType == 'وظائف'
            ? AdsShimmerWidget(
          name: translate('adsJob'),
          type: widget.type,
          is_category: widget.is_category,
        )
            : isFirstLoading == true && widget.nameType != 'وظائف'? AdsShimmerWidget(
          name: translate('ads'),
          type: widget.type,
          is_category: widget.is_category,
        ) :isFirstLoading == false && widget.nameType == 'وظائف' ?


          ListView.builder(
          primary: false,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return JobAdCard(
              data: itemsList[index],
              onPress: () {
                DIManager.findNavigator().pushNamed(
                  ItemsDetailsPage.routeName,
                  arguments: ItemsArgs(id: itemsList[index].ad_id ?? 0),
                );
              },
            );

          },
          itemCount: itemsList.length,
        ):

         */

        SmartRefresher(
          physics: BouncingScrollPhysics(),
          enablePullDown: false,
          enablePullUp: true,
          scrollDirection: Axis.vertical,
          controller: _refreshController,
          onRefresh: _onRefresh,
          footer: ClassicFooter(
            height: 80.sp,
            noMoreIcon: Center(
              child: Icon(
                Icons.arrow_upward,
                color: AppColorsController().buttonRedColor,
              ),
            ),
            idleIcon: itemsList.length != 8? Center(
              child: Icon(
                Icons.arrow_upward,
                color: AppColorsController().buttonRedColor,
              ),
            ):Center(
              child: Icon(
                Icons.arrow_downward,
                color: AppColorsController().buttonRedColor,
              ),
            ),
            loadingIcon: Container(
                width: 20.sp,
                height: 20.sp,
                child: CircularProgressIndicator(
                  color: AppColorsController().buttonRedColor,
                  strokeWidth: 1.5,
                )),
            canLoadingIcon: Center(
              child: Icon(
                Icons.change_circle_sharp,
                color: AppColorsController().buttonRedColor,
                size: 30.sp,
              ),
            ),
            canLoadingText: "",
            loadingText: "",
            textStyle: TextStyle(color: AppColorsController().white),
          ),
          onLoading: _onLoading,
          child: GridView.builder(
            itemCount: itemsList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (categoriesBloc.isJobs(
                  itemsList[index].category_title ?? '')) {
                return SizedBox(
                  child: JobAdCard(
                    isUseGridView: true,
                    width:
                    MediaQuery.sizeOf(context).width * 0.85,
                    data: itemsList[index],
                    onPress: () {
                      DIManager.findNavigator().pushNamed(
                        ItemsDetailsPage.routeName,
                        arguments: ItemsArgs(
                            id: itemsList[index].ad_id ?? 0,
                        categoryId: itemsList[index].category_id ?? 0,type: 'jobAds'
                        ),
                      );
                    },
                  ),
                );
              }
              return HomeItemsWidget(

                onPress: () {
                  DIManager.findNavigator()
                      .pushNamed(ItemsDetailsPage.routeName,
                      arguments: ItemsArgs(
                        id: itemsList[index].ad_id ?? 0,categoryId: itemsList[index].category_id ??0,
                      ));
                },
                data: itemsList[index],
              );
            },
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 200.sp,
              crossAxisSpacing: 6.sp,
              mainAxisSpacing: 18.sp,
            ),
            physics: NeverScrollableScrollPhysics(),
          ),
        );
      },
    );  }



}

/// This is a Code

/*

widget.type == 10
                ? Row(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          controller: _controller,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            selectedIndex = index - 1;

                            if (categoriesBloc.isJobs(
                                itemsList[index].category_title ?? '')) {
                              return SizedBox(
                                child: JobAdCard(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.85,
                                  data: itemsList[index],
                                  onPress: () {
                                    DIManager.findNavigator().pushNamed(
                                      ItemsDetailsPage.routeName,
                                      arguments: ItemsArgs(
                                          id: itemsList[index].ad_id ?? 0),
                                    );
                                  },
                                ),
                              );
                            }
                            return HomeItemsWidget(
                              onPress: () {
                                DIManager.findNavigator()
                                    .pushNamed(ItemsDetailsPage.routeName,
                                        arguments: ItemsArgs(
                                          id: itemsList[index].ad_id ?? 0,
                                        ));
                              },
                              data: itemsList[index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: 8,
                            );
                          },
                          itemCount: itemsList.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      message == ''
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.sp),
                              child: InkWell(
                                onTap: () {
                                  DIManager.findNavigator().pushNamed(
                                    ViewAllPage.routeName,
                                    arguments: ViewAllArgs(
                                      category_id: widget.category_id,
                                      type: widget.type,
                                    ),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.arrow_circle_left_outlined,
                                        color: AppColorsController()
                                            .buttonRedColor,
                                        size: 48.sp),
                                    Text(
                                      message,
                                      // 'عرض الكل',
                                      style: AppStyle.verySmallTitleStyle
                                          .copyWith(
                                              color: AppColorsController()
                                                  .textPrimaryColor,
                                              fontWeight:
                                                  AppFontWeight.midLight,
                                              fontSize:
                                                  AppFontSize.fontSize_12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        if (!(categoriesBloc
                            .isJobs(itemsList[0].category_title ?? '')))
                          Row(
                            children: [
                              if (widget.name == "الإعلانات الأكثر شيوعاً") ...[
                                HomeItemsWidget(
                                  onPress: () {
                                    DIManager.findNavigator()
                                        .pushNamed(ItemsDetailsPage.routeName,
                                            arguments: ItemsArgs(
                                              id: itemsList[0].ad_id ?? 0,
                                            ));
                                  },
                                  data: itemsList[0],
                                ),
                              ] else ...[
                                HomeItemsWidget(
                                  onPress: () {
                                    DIManager.findNavigator()
                                        .pushNamed(ItemsDetailsPage.routeName,
                                            arguments: ItemsArgs(
                                              id: itemsList[0].ad_id ?? 0,
                                            ));
                                  },
                                  data: itemsList[0],
                                ),
                                SizedBox(
                                  width: 10.sp,
                                ),
                                HomeItemsWidget(
                                  onPress: () {
                                    DIManager.findNavigator()
                                        .pushNamed(ItemsDetailsPage.routeName,
                                            arguments: ItemsArgs(
                                              id: itemsList[1].ad_id ?? 0,
                                            ));
                                  },
                                  data: itemsList[1],
                                ),
                                SizedBox(
                                  width: 10.sp,
                                ),
                                HomeItemsWidget(
                                  onPress: () {
                                    DIManager.findNavigator()
                                        .pushNamed(ItemsDetailsPage.routeName,
                                            arguments: ItemsArgs(
                                              id: itemsList[2].ad_id ?? 0,
                                            ));
                                  },
                                  data: itemsList[2],
                                ),
                              ],
                            ],
                          ),
                        //               // if(widget.name == "الإعلانات التي تم رفعها مؤخراً"  )
                        //               //   SizedBox(width: 10.sp,),
                        //               // if(widget.name == "الإعلانات التي تم رفعها مؤخراً"  )
                        //               //   HomeItemsWidget(
                        //               //     onPress: () {
                        //               //       DIManager.findNavigator()
                        //               //           .pushNamed(ItemsDetailsPage.routeName,
                        //               //           arguments: ItemsArgs(
                        //               //             id: itemsList[  1].ad_id ?? 0,
                        //               //           ));
                        //               //     },
                        //               //     data: itemsList[1],
                        //               //   ),
                        //               // if(widget.name == "الإعلانات التي تم رفعها مؤخراً"  )
                        //               //    SizedBox(width: 10.sp,),
                        //               // if(widget.name == "الإعلانات التي تم رفعها مؤخراً" )  HomeItemsWidget(
                        //               //   onPress: () {
                        //               //     DIManager.findNavigator()
                        //               //         .pushNamed(ItemsDetailsPage.routeName,
                        //               //         arguments: ItemsArgs(
                        //               //           id: itemsList[2].ad_id ?? 0,
                        //               //         ));
                        //               //   },
                        //               //   data: itemsList[2],
                        //               // ),
                        //

                        if ((categoriesBloc
                            .isJobs(itemsList[0].category_title ?? '')))
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: JobAdCard(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.85,
                                  data: itemsList[0],
                                  onPress: () {
                                    DIManager.findNavigator().pushNamed(
                                      ItemsDetailsPage.routeName,
                                      arguments: ItemsArgs(
                                          id: itemsList[0].ad_id ?? 0),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: JobAdCard(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.85,
                                  data: itemsList[1],
                                  onPress: () {
                                    DIManager.findNavigator().pushNamed(
                                      ItemsDetailsPage.routeName,
                                      arguments: ItemsArgs(
                                          id: itemsList[1].ad_id ?? 0),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: JobAdCard(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.85,
                                  data: itemsList[2],
                                  onPress: () {
                                    DIManager.findNavigator().pushNamed(
                                      ItemsDetailsPage.routeName,
                                      arguments: ItemsArgs(
                                          id: itemsList[2].ad_id ?? 0),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        //

                        // Expanded(
                        //   child: ListView.separated(
                        //     controller: _controller,
                        //     physics: BouncingScrollPhysics(),
                        //     itemBuilder: (context, index) {
                        //
                        //       selectedIndex = index -1;
                        //
                        //       if (categoriesBloc.isJobs(itemsList[index].category_title ?? '')) {
                        //         return SizedBox(
                        //           child: JobAdCard(
                        //             width: MediaQuery.sizeOf(context).width * 0.85,
                        //             data: itemsList[index],
                        //             onPress: () {
                        //               DIManager.findNavigator().pushNamed(
                        //                 ItemsDetailsPage.routeName,
                        //                 arguments: ItemsArgs(id: itemsList[index].ad_id ?? 0),
                        //               );
                        //             },
                        //           ),
                        //         );
                        //       }
                        //       return HomeItemsWidget(
                        //
                        //         onPress: () {
                        //           DIManager.findNavigator()
                        //               .pushNamed(ItemsDetailsPage.routeName,
                        //               arguments: ItemsArgs(
                        //                 id: itemsList[index].ad_id??0,
                        //               ));
                        //         },
                        //         data: itemsList[index],
                        //       );
                        //     },
                        //
                        //     separatorBuilder: (context, index) {
                        //
                        //       return SizedBox(
                        //         width: 8,
                        //       );
                        //     },
                        //     itemCount: itemsList.length ,
                        //     scrollDirection: Axis.horizontal,
                        //
                        //   ),
                        // ),

                        // // الإعلانات الأكثر شيوعاً
                        //               //
                        //               if(widget.name == "الإعلانات الأكثر شيوعاً" ||!(categoriesBloc.isJobs(itemsList[0].category_title ?? '')))
                        //                 Row(
                        //                   children: [
                        //                     HomeItemsWidget(
                        //                       onPress: () {
                        //                         DIManager.findNavigator()
                        //                             .pushNamed(ItemsDetailsPage.routeName,
                        //                             arguments: ItemsArgs(
                        //                               id: itemsList[0].ad_id ?? 0,
                        //                             ));
                        //                       },
                        //                       data: itemsList[0],
                        //                     ), SizedBox(width: 10.sp,),
                        //
                        //                   ],
                        //                 ),
                        //
                        //               if(widget.name == "الإعلانات الأكثر تقييماً"  ||!(categoriesBloc.isJobs(itemsList[0].category_title ?? '')))
                        //                 Row(
                        //                   children: [
                        //                     HomeItemsWidget(
                        //                       onPress: () {
                        //                         DIManager.findNavigator()
                        //                             .pushNamed(ItemsDetailsPage.routeName,
                        //                             arguments: ItemsArgs(
                        //                               id: itemsList[0].ad_id ?? 0,
                        //                             ));
                        //                       },
                        //                       data: itemsList[0],
                        //                     ),  SizedBox(width: 10.sp,),HomeItemsWidget(
                        //                       onPress: () {
                        //                         DIManager.findNavigator()
                        //                             .pushNamed(ItemsDetailsPage.routeName,
                        //                             arguments: ItemsArgs(
                        //                               id: itemsList[1].ad_id ?? 0,
                        //                             ));
                        //                       },
                        //                       data: itemsList[1],
                        //                     ),
                        //                     SizedBox(width: 10.sp,),HomeItemsWidget(
                        //                       onPress: () {
                        //                         DIManager.findNavigator()
                        //                             .pushNamed(ItemsDetailsPage.routeName,
                        //                             arguments: ItemsArgs(
                        //                               id: itemsList[2].ad_id ?? 0,
                        //                             ));
                        //                       },
                        //                       data: itemsList[2],
                        //                     ),
                        //                   ],
                        //                 ),

                        //   SizedBox(width: 10.sp,),
                        // if(widget.name == "الإعلانات الأكثر تقييماً"  )
                        //   HomeItemsWidget(
                        //     onPress: () {
                        //       DIManager.findNavigator()
                        //           .pushNamed(ItemsDetailsPage.routeName,
                        //           arguments: ItemsArgs(
                        //             id: itemsList[1].ad_id ?? 0,
                        //           ));
                        //     },
                        //     data: itemsList[1],
                        //   ),
                        //   SizedBox(width: 10.sp,),
                        // if(widget.name == "الإعلانات الأكثر تقييماً"  )
                        //   HomeItemsWidget(
                        //   onPress: () {
                        //     DIManager.findNavigator()
                        //         .pushNamed(ItemsDetailsPage.routeName,
                        //         arguments: ItemsArgs(
                        //           id: itemsList[2].ad_id ?? 0,
                        //         ));
                        //   },
                        //   data: itemsList[2],
                        // ),

                        // HomeItemsWidget(
                        //   onPress: () {
                        //     DIManager.findNavigator()
                        //         .pushNamed(ItemsDetailsPage.routeName,
                        //         arguments: ItemsArgs(
                        //           id: itemsList[1].ad_id ?? 0,
                        //         ));
                        //   },
                        //   data: itemsList[1],
                        // ),
                        // HomeItemsWidget(
                        //   onPress: () {
                        //     DIManager.findNavigator()
                        //         .pushNamed(ItemsDetailsPage.routeName,
                        //         arguments: ItemsArgs(
                        //           id: itemsList[2].ad_id ?? 0,
                        //         ));
                        //   },
                        //   data: itemsList[2],
                        // ),

                        // List

                        // message == ''
                        //     ? Container()
                        //     :

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.sp),
                          child: InkWell(
                            onTap: () {
                              DIManager.findNavigator().pushNamed(
                                ViewAllPage.routeName,
                                arguments: ViewAllArgs(
                                  category_id: widget.category_id,
                                  type: widget.type,
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_circle_left_outlined,
                                    color: AppColorsController().buttonRedColor,
                                    size: 48.sp),
                                Text(
                                  // message,
                                  'عرض الكل',
                                  style: AppStyle.verySmallTitleStyle.copyWith(
                                      color: AppColorsController()
                                          .textPrimaryColor,
                                      fontWeight: AppFontWeight.midLight,
                                      fontSize: AppFontSize.fontSize_12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


 */
