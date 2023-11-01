import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wadeema/core/constants/app_assets.dart';
import '../../../../blocs/ads/ads_bloc.dart';
import '../../../../blocs/ads/states/ads_state.dart';
import '../../../../blocs/categories/categories_bloc.dart';
import '../../../../blocs/categories/states/categories_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_consts.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/widgets/general_error_widget.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
import '../../../../data/models/ads/entity/ads_entity.dart';
import '../../../../data/models/categories/entity/categories_entity.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/icons/back_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../arg/items_args.dart';
import '../widget/ads_shimmer_widget.dart';
import '../widget/build_items_ads.dart';
import '../widget/build_items_widget.dart';
import '../widget/looking_widget_shimmer.dart';

class LookingForDetailsPage extends StatefulWidget {
  static const routeName = '/LookingForDetailsPage';
  final ItemsArgs? args;

  const LookingForDetailsPage({Key? key, this.args}) : super(key: key);

  @override
  State<LookingForDetailsPage> createState() => _LookingForDetailsPageState();
}

class _LookingForDetailsPageState extends State<LookingForDetailsPage> {
  final categoriesBloc = DIManager.findDep<CategoriesCubit>();
  final adsBloc = DIManager.findDep<AdsCubit>();
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
    // items = [];
    items.clear();
    // categoriesBloc.getSubCategories(widget.args!.id!);
    // categoriesBloc.getPropertiesCategories(widget.args!.id!);
    adsBloc.getCategoryAds(page, widget.args!.id!);
    setState(() {});
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 30));
    page++;
    // categoriesBloc.getSubCategories(widget.args!.id!);
    // categoriesBloc.getPropertiesCategories(widget.args!.id!);
    adsBloc.getCategoryAds(page, widget.args!.id!);
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  //
  @override
  void initState() {
    categoriesBloc.getSubCategories(widget.args!.id!);
    adsBloc.getCategoryAds(page, widget.args!.id!);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: AppColorsController().white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.appBarBackgroundImage),
                fit: BoxFit.fill),
          ),
        ),
        centerTitle: true,elevation: 0,
        title: Text(widget.args!.title ?? "",  style: AppStyle.smallTitleStyle.copyWith(
          color: AppColorsController().black,
          fontWeight: AppFontWeight.midBold,
          fontSize: AppFontSize.fontSize_20,
        ),maxLines: 1,),
        leading:Transform.scale(
          scale: 0.6,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
              categoriesBloc.getSubCategories(widget.args!.idPast! );
              // DIManager.findNavigator().pushReplacementNamed(
              //   LookingForDetailsPage.routeName,
              //   arguments: ItemsArgs(
              //       // idPast: widget.args!.id,
              //       // childCountPast: widget.args!.childCount,
              //       // titlePast: widget.args!.title,
              //       title: widget.args!.title,
              //       id: widget.args!.id,
              //       childCount: widget.args!.childCount,indexPage: 1),
              // );
            },
            child: BackIcon(
              width: 26.sp,
              height: 18.sp,
            ),
          ),
        ), iconTheme: IconThemeData(
        size: 20.0, // تحديد حجم الأيقونة في الـ leading
      ),


      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[

          BlocConsumer<CategoriesCubit, CategoriesState>(
          bloc: categoriesBloc,
          listener: (context, state) {},
          builder: (context, state) {
            final categoriesState = state.getSubCategoriesState;

            if (categoriesState is BaseFailState) {
              return Column(
                children: [
                  VerticalPadding(3.0),
                  GeneralErrorWidget(
                    error: categoriesState.error,
                    callback: categoriesState.callback,
                  ),
                ],
              );
            }




    if (categoriesState
    is GetSubCategoriesSuccessState) {
      final data = (state.getSubCategoriesState
      as GetSubCategoriesSuccessState)
          .categories;

      List<dynamic> firstList =
      data.sublist(0, data.length ~/ 2);
      List<dynamic> secondList =
      data.sublist(data.length ~/ 2);


      return SliverAppBar(
        automaticallyImplyLeading: false,
        expandedHeight: data.length<=7 ? 130.h:230.h ,
        backgroundColor: AppColorsController().white,
        // actions: [Container()],
        // centerTitle: true,pinned: true,leadingWidth: 0,
        flexibleSpace: FlexibleSpaceBar(
          // title: Container(
          //   color: Colors.white,
          //   width: MediaQuery.of(context).size.width,
          //   // height: 50,
          //   child: Text(
          //         translate("ads_list") + ":",
          //         style: AppStyle.smallTitleStyle.copyWith(
          //         color: AppColorsController().black,
          //         fontWeight: FontWeight.bold,fontSize: AppFontSize.fontSize_18
          //         ),
          //         maxLines: 2,
          //         overflow: TextOverflow.ellipsis,
          //         ),
          // ),
          background: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: 16.0.sp, left: 16.0.sp, top: 16.0.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    data.length<=7?Container(
                      width: MediaQuery.of(context).size.width,
                      height: 72.sp,
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) =>
                            lookingItemsWidget(
                                categories:
                                data[index]),
                        separatorBuilder:
                            (BuildContext context,
                            int index) {
                          return SizedBox(
                            width: 8.sp,
                          );
                        },
                      ),
                    ): Column(
                      children: [
                        firstList.length > 0
                            ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: 72.sp,
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: firstList.length,
                            itemBuilder: (context, index) =>
                                lookingItemsWidget(
                                    categories:
                                    firstList[index]),
                            separatorBuilder:
                                (BuildContext context,
                                int index) {
                              return SizedBox(
                                width: 8.sp,
                              );
                            },
                          ),
                        )
                            : Container(),
                        firstList.length > 0
                            ? SizedBox(
                          height: 16.sp,
                        )
                            : Container(),
                        firstList.length > 0
                            ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: 72.sp,
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: secondList.length,
                            itemBuilder: (context, index) =>
                                lookingItemsWidget(
                                    categories:
                                    secondList[index]),
                            separatorBuilder:
                                (BuildContext context,
                                int index) {
                              return SizedBox(
                                width: 8.sp,
                              );
                            },
                          ),
                        )
                            : Container(),
                      ],
                    ),
                    SizedBox(
                      height: 5.sp,
                    ),
                    Text(
                      translate("ads_list") + ":",
                      style: AppStyle.smallTitleStyle.copyWith(
                          color: AppColorsController().black,
                          fontWeight: FontWeight.bold,
                          fontSize: AppFontSize.fontSize_18),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SliverAppBar(

      automaticallyImplyLeading: false,
      expandedHeight: 230.h ,
      backgroundColor: AppColorsController().white,
      // actions: [Container()],
      // centerTitle: true,pinned: true,leadingWidth: 0,
      flexibleSpace: FlexibleSpaceBar(
        // title: Container(
        //   color: Colors.white,
        //   width: MediaQuery.of(context).size.width,
        //   // height: 50,
        //   child: Text(
        //         translate("ads_list") + ":",
        //         style: AppStyle.smallTitleStyle.copyWith(
        //         color: AppColorsController().black,
        //         fontWeight: FontWeight.bold,fontSize: AppFontSize.fontSize_18
        //         ),
        //         maxLines: 2,
        //         overflow: TextOverflow.ellipsis,
        //         ),
        // ),
        background: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  right: 16.0.sp, left: 16.0.sp, top: 16.0.sp),
              child: LookingWidgetShimmer(name: "ads"),
            ),
          ],
        ),
      ),
    );


          }
            ),
          ];
        },
        body: SafeArea(
          child: BlocConsumer<CategoriesCubit, CategoriesState>(
            bloc: categoriesBloc,
            listener: (context, state) {},
            builder: (context, state) {
              final categoriesState = state.getSubCategoriesState;

              if (categoriesState is BaseFailState) {
                return Column(
                  children: [
                    VerticalPadding(3.0),
                    GeneralErrorWidget(
                      error: categoriesState.error,
                      callback: categoriesState.callback,
                    ),
                  ],
                );
              }

              if (categoriesState is GetSubCategoriesSuccessState) {
                final data = (state.getSubCategoriesState
                        as GetSubCategoriesSuccessState)
                    .categories;

                loadingLoader = true;
                loading = true;
                return Padding(
                  padding: EdgeInsets.all(4.0.sp),
                  child: BuildItemsAds(
                    name: translate('ads'),
                    // type: 3,
                    nameType: widget.args!.title!,
                    type: 10,
                    category_id: widget.args!.id!,
                    is_category: true,
                  ),
                );
              }

              return AdsShimmerWidget(
                name: translate('ads'),
                type: 10,
                is_category: true,
              );

              /*
              return widget.args!.title! == 'وظائف'
                  ? AdsShimmerWidget(
                      name: translate('adsJob'),
                      type: 10,
                      is_category: true,
                    )
                  : AdsShimmerWidget(
                      name: translate('ads'),
                      type: 10,
                      is_category: true,
                    );
              */

            },
          ),
        ),
      ),
    );
  }

  Widget lookingItemsWidget(
      {required CategoriesEntity categories, double? height, double? width}) {
    return Container(
      height: height ?? 71.sp,
      width: width ?? 71.sp,
      decoration: BoxDecoration(
        border: Border.all(
            color: AppColorsController().black.withOpacity(0.5), width: 0.2),
        color: AppColorsController().containerPrimaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(12.sp),
        ),
      ),
      child: InkWell(
        onTap: () {
          DIManager.findNavigator().pushNamed(
            LookingForDetailsPage.routeName,
            arguments: ItemsArgs(
                idPast: widget.args!.id,
                childCountPast: widget.args!.childCount,
                titlePast: widget.args!.title,
                           title: categories.title,
                id: categories.category_id,
                childCount: categories.hasChild,indexPage: 1),
          );
          // DIManager.findNavigator().pushNamed(ItemsDetailsPage.routeName,
          //     arguments: ItemsArgs(id: categories.category_id!));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: categories.icon.toString().endsWith(".svg") == true
                  ? SvgPicture.network(
                      AppConsts.IMAGE_URL + categories.icon.toString()!,
                      width: 34.sp,
                      height: 34.sp,
                      placeholderBuilder: (BuildContext context) => Container(
                            width: 18.sp,
                            height: 18.sp,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.2,
                              color: AppColorsController().buttonRedColor,
                            ),
                          ))
                  : Image.network(
                      AppConsts.IMAGE_URL + categories.icon.toString()!,
                      width: 34.sp,
                      height: 34.sp,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return Container();
                      },
                    ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
                child: Text(
                  categories.title.toString(),
                  style: AppStyle.tinySmallTitleStyle.copyWith(
                      color: AppColorsController().black,
                      fontWeight: AppFontWeight.bold,
                      fontSize: AppFontSize.fontSize_12),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            // SizedBox(
            //   height: 6.sp,
            // ),
          ],
        ),
      ),
    );
  }
}
