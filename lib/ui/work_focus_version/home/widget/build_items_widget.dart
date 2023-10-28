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
import '../arg/items_args.dart';
import '../arg/view_all_args.dart';
import '../pages/items_details_page.dart';
import '../pages/view_all_page.dart';
import 'ads_shimmer_widget.dart';
import 'home_items_widget.dart';

class BuildItemsWidget extends StatefulWidget {
  final String name;

  final int type;
  final int? category_id;
  final bool? is_category;

  const BuildItemsWidget(
      {Key? key,
      required this.name,
      required this.type,
      this.category_id,
      this.is_category})
      : super(key: key);

  @override
  State<BuildItemsWidget> createState() => _BuildItemsWidgetState();
}

class _BuildItemsWidgetState extends State<BuildItemsWidget> {
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
    if (widget.type == 0) {
      adsBloc.getAllRecentAds(page);
      loading = true;
    } else if (widget.type == 1) {
      adsBloc.getAllMostRatedAds(page);
      loading = true;
    } else if (widget.type == 2) {
      adsBloc.getAllPopularAds(page);
      loading = true;
    } else {
      adsBloc.getCategoryAds(page, widget.category_id!);
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
    if (widget.type == 0) {
      adsBloc.getAllRecentAds(page);
      loading = true;
    } else if (widget.type == 1) {
      adsBloc.getAllMostRatedAds(page);
      loading = true;
    } else if (widget.type == 2) {
      adsBloc.getAllPopularAds(page);
      loading = true;
    } else {
      adsBloc.getCategoryAds(page, widget.category_id!);
      loading = true;
    }

    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  final int itemsToShow = 3; // عدد العناصر لعرضها أولاً
  int visibleItemCount = 0; // عدد العناصر المرئية في القائمة
  bool showAll = false; // يتحقق إذا تم النقر على "مشاهدة الكل"
  ScrollController _controller = ScrollController();
  String message = '';

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        // message = translate("view_all");
        message = 'عرض الكل';
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        message = "";
      });
    }
  }

  ScrollController _scrollController = ScrollController();
  int numberOfItems = 0;

  @override
  void initState() {
    super.initState();
    visibleItemCount = itemsToShow;
    _controller.addListener(_scrollListener);

    if (widget.type == 0) {
      adsBloc.getAllRecentAds(page);
      loading = true;
    } else if (widget.type == 1) {
      adsBloc.getAllMostRatedAds(page);
      loading = true;
    } else if (widget.type == 2) {
      adsBloc.getAllPopularAds(page);
      loading = true;
    } else {
      adsBloc.getCategoryAds(page, widget.category_id!);
      loading = true;
    }
    isFirstLoading = true;

    // _scrollController.addListener(() {
    //   setState(() {
    //     // يتم تحديث العدد عند حدوث تغيير
    //    numberOfItems = _scrollController.position.maxScrollExtent.toInt();
    //     // يمكنك أيضًا تحويل العدد إلى شكل نص إذا كنت تفضل ذلك
    //   });
    // });
  }

  // void _showAllItems() {
  //   setState(() {
  //     visibleItemCount = itemsList.length;
  //     showAll = true;
  //   });
  // }
  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    print('--------------------------------------------------${widget.name}');
    return Container(
      height: 260.sp,
      // width: 400.sp,
      child: BlocConsumer<AdsCubit, AdsState>(
        bloc: adsBloc,
        listener: (context, state) {},
        builder: (context, state) {
          final adsState;

          switch (widget.type) {
            case 0:
              adsState = state.getAllRecentAdsState;
              break;
            case 1:
              adsState = state.getAllMostRatedAdsState;
              break;
            case 2:
              adsState = state.getAllPopularAdsState;
              break;
            default:
              adsState = state.getCategoryAdsState;
              break;
          }
          // = widget.type == 0
          //     ? state.getAllRecentAdsState
          //     : widget.type == 1
          //         ? state.getAllMostRatedAdsState
          //         : widget.type == 2?state.getAllPopularAdsState:state.getCategoryAdsState;

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

          if (loading &&
              widget.type == 0 &&
              adsState is GetAllRecentAdsSuccessState) {
            final data =
                (state.getAllRecentAdsState as GetAllRecentAdsSuccessState).ads;
            itemsList.addAll(data.data!);
            loading = false;
            isFirstLoading = false;
          } else if (loading &&
              widget.type == 1 &&
              adsState is GetAllMostRatedAdsSuccessState) {
            final data = (state.getAllMostRatedAdsState
                    as GetAllMostRatedAdsSuccessState)
                .ads;
            itemsList.addAll(data.data!);
            loading = false;
            isFirstLoading = false;
          } else if (loading &&
              widget.type == 2 &&
              adsState is GetAllPopularAdsSuccessState) {
            final data =
                (state.getAllPopularAdsState as GetAllPopularAdsSuccessState)
                    .ads;
            itemsList.addAll(data.data!);
            loading = false;
            isFirstLoading = false;
          } else if (loading && adsState is GetCategoryAdsSuccessState) {
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
                : _buildBody();
          }
          return isFirstLoading == true
              ? AdsShimmerWidget(
                  name: widget.name,
                  type: widget.type,
                  is_category: widget.is_category,
                )
              : _buildBody();
        },
      ),
    );
  }

  int selectedIndex = -1;

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          widget.is_category == true
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.name.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.verySmallTitleStyle.copyWith(
                          color: AppColorsController().textPrimaryColor,
                          fontWeight: AppFontWeight.midLight,
                          fontSize: AppFontSize.fontSize_14),
                    ),
                    InkWell(
                      onTap: () {
                        DIManager.findNavigator().pushNamed(
                          ViewAllPage.routeName,
                          arguments: ViewAllArgs(
                            category_id: widget.category_id,
                            type: widget.type,
                          ),
                        );
                      },
                      child: Text(
                        translate("view_all"),
                        style: AppStyle.verySmallTitleStyle.copyWith(
                            color: AppColorsController().textPrimaryColor,
                            fontWeight: AppFontWeight.midLight,
                            fontSize: AppFontSize.fontSize_14),
                      ),
                    ),
                  ],
                ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.sp),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: itemsList.isNotEmpty &&
                      categoriesBloc
                          .isJobs(itemsList.first.category_title ?? '') &&
                      widget.category_id == AppConsts.jobCategoryId
                  ? 200.sp
                  : 190.sp,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (!(categoriesBloc
                        .isJobs(itemsList[0].category_title ?? '')))
                      Row(
                        children: [
                          if (itemsList.length <= 7) ...[
                            for (int i = 0; i < itemsList.length; i++) ...[
                              itemsList[i].ad_images?[0].name?.toString() ==
                                      '/img/ad/default.png'
                                  ? HomeItemsWidget(
                                      weDontHaveImage: true,
                                      onPress: () {
                                        DIManager.findNavigator().pushNamed(
                                            ItemsDetailsPage.routeName,
                                            arguments: ItemsArgs(
                                              id: itemsList[i].ad_id ?? 0,
                                              type: 'adsWithoutImage' ,                                            ));
                                      },
                                      data: itemsList[i],
                                    )
                                  :

                              HomeItemsWidget(
                                      onPress: () {
                                        DIManager.findNavigator().pushNamed(
                                            ItemsDetailsPage.routeName,
                                            arguments: ItemsArgs(
                                              id: itemsList[i].ad_id ?? 0,                                              ));
                                      },
                                      data: itemsList[i],
                                    ),
                              SizedBox(
                                width: 10.sp,
                              ),
                            ],
                          ] else ...[
                            for (int i = 0; i < 7; i++) ...[
                              itemsList[i].ad_images?[0].name?.toString() ==
                                      '/img/ad/default.png'
                                  ? HomeItemsWidget(
                                      weDontHaveImage: true,
                                      onPress: () {
                                        DIManager.findNavigator().pushNamed(
                                            ItemsDetailsPage.routeName,
                                            arguments: ItemsArgs(
                                              id: itemsList[i].ad_id ?? 0, type: 'adsWithoutImage'
                                            ));
                                      },
                                      data: itemsList[i],
                                    )
                                  : HomeItemsWidget(
                                      onPress: () {
                                        DIManager.findNavigator().pushNamed(
                                            ItemsDetailsPage.routeName,
                                            arguments: ItemsArgs(
                                              id: itemsList[i].ad_id ?? 0,
                                            ));
                                      },
                                      data: itemsList[i],
                                    ),
                              SizedBox(
                                width: 10.sp,
                              ),
                            ],
                            Container(),
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
                        .isJobs(itemsList[0].category_title ?? ''))) ...[
                      Row(
                        children: [
                          if (itemsList.length <= 7) ...[
                            for (int i = 0; i < itemsList.length; i++) ...[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: JobAdCard(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.21,
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.85,
                                  data: itemsList[i],
                                  onPress: () {
                                    DIManager.findNavigator().pushNamed(
                                      ItemsDetailsPage.routeName,
                                      arguments: ItemsArgs(
                                          id: itemsList[i].ad_id ?? 0,
                                          type: 'jobAds'),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ] else ...[
                            for (int i = 0; i < 7; i++) ...[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: JobAdCard(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.21,
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.85,
                                  data: itemsList[i],
                                  onPress: () {
                                    DIManager.findNavigator().pushNamed(
                                      ItemsDetailsPage.routeName,
                                      arguments: ItemsArgs(
                                          id: itemsList[i].ad_id ?? 0,
                                          type: 'jobAds'),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ]
                        ],
                      ),
                    ],

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
                                  color: AppColorsController().textPrimaryColor,
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
            ),
          ),
          // Text(
          //   'عدد العناصر: ${numberOfItems}',
          // ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: List.generate(itemsList.length > 3 ? 3 : itemsList.length,
          //       (index) {
          //     return Container(
          //       width: 6.5.sp,
          //       height: 6.5.sp,
          //       child: InkWell(
          //           onTap: () {
          //             print(index);
          //           },
          //           child: Text('print')),
          //       margin: EdgeInsets.symmetric(horizontal: 1.5.sp),
          //       decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: selectedIndex == index
          //               ? AppColorsController().buttonRedColor
          //               : AppColorsController().grey),
          //     );
          //   }),
          // ),
        ],
      ),
    );
  }
}

/// This is a Code

/// Widget with SmartRefresher
/*
  return Container(
      height:  260.sp,
      // width: 400.sp,
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        scrollDirection: Axis.horizontal,
        controller: _refreshController,
        onRefresh: _onRefresh,
        header: ClassicHeader(
          completeText: "",
          refreshingText: "",
          textStyle: TextStyle(color: AppColorsController().white),
        ),
        footer: ClassicFooter(
          canLoadingText: "",
          loadingText: "",
          textStyle: TextStyle(color: AppColorsController().white),
        ),
        onLoading: _onLoading,
        child: BlocConsumer<AdsCubit, AdsState>(
          bloc: adsBloc,
          listener: (context, state) {},
          builder: (context, state) {
            final adsState;

            switch (widget.type) {
              case 0:
                adsState = state.getAllRecentAdsState;
                break;
              case 1:
                adsState = state.getAllMostRatedAdsState;
                break;
              case 2:
                adsState = state.getAllPopularAdsState;
                break;
              default:
                adsState = state.getCategoryAdsState;
                break;
            }
            // = widget.type == 0
            //     ? state.getAllRecentAdsState
            //     : widget.type == 1
            //         ? state.getAllMostRatedAdsState
            //         : widget.type == 2?state.getAllPopularAdsState:state.getCategoryAdsState;

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

            if (loading &&
                widget.type == 0 &&
                adsState is GetAllRecentAdsSuccessState) {
              final data =
                  (state.getAllRecentAdsState as GetAllRecentAdsSuccessState)
                      .ads;
              itemsList.addAll(data.data!);
              loading = false;
              isFirstLoading = false;
            } else if (loading &&
                widget.type == 1 &&
                adsState is GetAllMostRatedAdsSuccessState) {
              final data = (state.getAllMostRatedAdsState
                      as GetAllMostRatedAdsSuccessState)
                  .ads;
              itemsList.addAll(data.data!);
              loading = false;
              isFirstLoading = false;
            } else if (loading &&
                widget.type == 2 &&
                adsState is GetAllPopularAdsSuccessState) {
              final data =
                  (state.getAllPopularAdsState as GetAllPopularAdsSuccessState)
                      .ads;
              itemsList.addAll(data.data!);
              loading = false;
              isFirstLoading = false;
            } else if (loading && adsState is GetCategoryAdsSuccessState) {
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
                  : _buildBody();
            }
            return isFirstLoading == true
                ? AdsShimmerWidget(
                    name: widget.name,
                    type: widget.type,
                    is_category: widget.is_category,
                  )
                : _buildBody();
          },
        ),
      ),
    );

 */

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
