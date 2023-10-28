import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wadeema/core/shared_prefs/data_store.dart';
import 'package:wadeema/ui/work_focus_version/ads/args/argument_category.dart';
import 'package:wadeema/ui/work_focus_version/ads/pages/add_main_details_page.dart';
import 'package:wadeema/ui/work_focus_version/ads/widget/post_ad_button.dart';
import 'package:wadeema/ui/work_focus_version/app.dart';
import 'package:wadeema/ui/work_focus_version/general/app_bar/app_bar.dart';
import 'package:wadeema/ui/work_focus_version/home/pages/view_all_page.dart';
import 'package:wadeema/ui/work_focus_version/home/pages/view_all_search.dart';
import 'package:wadeema/ui/work_focus_version/home/widget/build_looking_search.dart';

import '../../../../blocs/ads/ads_bloc.dart';
import '../../../../blocs/ads/states/ads_state.dart';
import '../../../../blocs/categories/categories_bloc.dart';
import '../../../../blocs/categories/states/categories_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/widgets/general_error_widget.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
import '../../../../data/models/ads/entity/ads_entity.dart';
import '../../../../data/models/categories/entity/categories_entity.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '../../general/icons/back_icon.dart';
import '../../general/icons/search_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../../general/text_fields/text_field_widget.dart';
import '../arg/view_all_args.dart';
import '../widget/build_looking_widget.dart';
import '../widget/looking_for_widget_search.dart';
import '../widget/looking_widget_shimmer.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/SearchPage';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  String searchValue = "";
  final categoriesBloc = DIManager.findDep<CategoriesCubit>();
   List<CategoriesEntity> categories = [];

  bool loading = false;
  bool loadingLoader = false;

  final adsBloc = DIManager.findDep<AdsCubit>();

  int page = 1;
  List<ItemsAdsEntity> items = [];


  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    loadingLoader = true;
    // if failed,use refreshFailed()
    page = 1;
    loading = true;
    items = [];

    adsBloc.getSearchFilterAds(
        page, titleSearch);

    setState(() {});
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 30));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    page++;

    adsBloc.getSearchFilterAds(
        page, titleSearch);
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





String titleSearch ='';


  List<String> searchHistory = [];

  @override
  void initState() {
    super.initState();
    loading = true;
    loadingLoader = true;
    // categoriesBloc.getMainCategories();
    _getData();
  }

  _getData(){
    categoriesBloc.getMainCategories();
    dataStore.getSearchHistory().then((value) {
      setState(() {
        searchHistory = value;
      });
    });
  }
  bool isLoadingCategories = true;

  @override
  void didUpdateWidget(covariant SearchPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }


  bool isSelectAll = true;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          new TextEditingController().clear();
        },
        child: BackLongPress(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.sp,),
              AppBarWidget(
                name: translate('search'),
                // flip: true,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
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
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8.sp,
                    ),
                    Row(
                      children: [
                        Expanded(child: _searchWidget()),
                        SizedBox(
                          width: 20.sp,
                        ),
                        TextButton(
                            onPressed: () {
                              final Map<String, dynamic>? dataMap = {"filter": true};

                              DIManager.findNavigator().pushNamed(AddMainDetailsPage.routeName,
                                  arguments: ArgumentCategory(dataMap: dataMap)).then((value) => _getData());
                            },
                            style: TextButton.styleFrom(
                                foregroundColor: AppColorsController().lightRed,
                                backgroundColor: AppColorsController().card,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    side: BorderSide(color: AppColorsController().borderColor, width: 0.2))),
                            child: SizedBox(
                              height: 45,
                              child: Icon(Icons.tune_outlined,
                                  size: 28.sp, color: AppColorsController().darkRed.withOpacity(0.75)),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: BlocConsumer<CategoriesCubit, CategoriesState>(
                  bloc: categoriesBloc,
                  listener: (context, state) {},
                  builder: (context, state) {
                    final categoriesState =
                        state.getMainCategoriesState;
                    if (categoriesState is BaseFailState) {
                      return Column(
                        children: [
                          VerticalPadding(3.sp),
                          GeneralErrorWidget(
                            error: categoriesState.error,
                            callback: categoriesState.callback,
                          ),
                        ],
                      );
                    }

                    if (isLoadingCategories == true &&
                        categoriesState
                        is GetMainCategoriesSuccessState) {
                      categories = (state.getMainCategoriesState
                      as GetMainCategoriesSuccessState)
                          .categories;
                      isLoadingCategories = false;

                      return Column(
                        children: [
                          BuildLookingSearch(
                              name: translate(
                                  "are_you_looking_for"),
                              lookingList: categories
                          ),
                          SizedBox(height: 4.sp),
                        ],
                      );
                    }
                    return (isLoadingCategories == true)
                        ? LookingWidgetShimmer(
                      name:
                          "search",
                    )
                        :

                    // Column(
                    //   children: [
                    //     Padding(
                    //       padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                    //       child: Column(
                    //         children: [
                    //           Container(
                    //             width: MediaQuery.of(context).size.width,
                    //             height: 40.sp,
                    //             // child: ListView.separated(
                    //             //   physics: BouncingScrollPhysics(),
                    //             //   itemBuilder: (context, index) {
                    //             //     return LookingForWidgetSearch(
                    //             //       onPressed: () {
                    //             //         if(firstList[index].hasChild !=0) {
                    //             //           DIManager.findNavigator().pushNamed(
                    //             //             LookingForDetailsPage.routeName,
                    //             //             arguments:
                    //             //             ItemsArgs(title: firstList[index].title,
                    //             //                 id: firstList[index].category_id,
                    //             //                 childCount: firstList[index].hasChild,indexPage: 0),
                    //             //           );
                    //             //         }
                    //             //       },
                    //             //       data: firstList[index],
                    //             //     );
                    //             //   },
                    //             //   separatorBuilder: (context, index) {
                    //             //     return SizedBox(
                    //             //       width: 5.sp,
                    //             //     );
                    //             //   },
                    //             //   itemCount: firstList.length,
                    //             //   scrollDirection: Axis.horizontal,
                    //             // ),
                    //             child: SingleChildScrollView(
                    //               physics: BouncingScrollPhysics(),
                    //               scrollDirection: Axis.horizontal,
                    //               child: Row(
                    //                 children: [
                    //                   LookingForWidgetSearch(
                    //                     currentSelect: currentSelect,
                    //                     isSelectAll: isSelectAll,
                    //                     onPressed: () {
                    //                       setState(() {
                    //                         currentSelect = 0;
                    //                         isSelectAll = true;
                    //                       });
                    //                       print(currentSelect);
                    //                     },
                    //                     data: CategoriesEntity(title: "الجميع"),
                    //                   ),
                    //                   SizedBox(
                    //                     width: 7.sp,
                    //                   ),
                    //                   for (int index = 0;
                    //                   index < firstList.length;
                    //                   index++) ...[
                    //                     LookingForWidgetSearch(
                    //                       currentSelect: currentSelect,
                    //                       onPressed: () {
                    //                         setState(() {
                    //                           currentSelect = firstList[index].category_id!;
                    //                           isSelectAll = false;
                    //                         });
                    //                         print(currentSelect);
                    //                       },
                    //                       data: firstList[index],
                    //                     ),
                    //                     SizedBox(
                    //                       width: 7.sp,
                    //                     ),
                    //                   ]
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // );

                    Column(
                      children: [
                        BuildLookingSearch(

                          name: translate(
                              "are_you_looking_for"),
                          lookingList: categories,
                        ),
                        // SizedBox(height: 4.sp),
                      ],
                    );
                  },
                ),
              ),
Expanded(
                child: Container(
                  child: SmartRefresher(
                    enablePullDown: false,
                    enablePullUp: true,
                    scrollDirection: Axis.vertical,

                    controller: _refreshController,
                    // onRefresh: _onRefresh,
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
                      height: 80.sp,
                      noMoreIcon: Container(
                          width: 20.sp,
                          height: 20.sp,
                          child: CircularProgressIndicator(
                            color: AppColorsController().buttonRedColor,
                            strokeWidth: 1.5,
                          )),
                      idleIcon: Center(
                        child: Icon(
                          Icons.arrow_upward,
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
                      textStyle:
                      TextStyle(color: AppColorsController().white),
                    ),
                    onLoading: _onLoading,
                    child:  BlocConsumer<AdsCubit, AdsState>(
                      bloc: adsBloc,
                      listener: (context, state) {
                        setState(() {
                          loadingLoader = false;
                        });
                      },
                      builder: (context, state) {
                        print("Here" + state.toString());

                        final adsState = state.getAllSearchAdsState;

                        print("Here" + adsState.toString());
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

                        if (loading &&
                            adsState is GetSearchFilterAdsSuccessState) {
                          final data = (state.getAllSearchAdsState
                          as GetSearchFilterAdsSuccessState)
                              .ads;
                          items.addAll(data.data!);
                          loading = false;
                          return
                            loading?LinearProgressIndicator(
                              color: AppColorsController().buttonRedColor,
                             backgroundColor: AppColorsController().greyBackground,
                              minHeight: 2,
                            ): _bodySearchItems();
                        }

                        return
                          loading?LinearProgressIndicator(
                            color: AppColorsController().buttonRedColor,
                            backgroundColor: AppColorsController().greyBackground,minHeight: 2,
                          ): _bodySearchItems();
                      },
                    ),
                  ),
                ),
              ),




              if(searchHistory.isNotEmpty)...[
                SizedBox(height: 16.sp,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 24.sp),
                  child: Text(translate('last_search'),textAlign: TextAlign.start, style: TextStyle(color: AppColorsController().black, fontSize: AppFontSize.fontSize_14,)),
                ),
                ListView.separated( physics: BouncingScrollPhysics(),
                  itemCount: searchHistory.length,
                  padding: EdgeInsets.symmetric(horizontal: 8.sp),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return _searchItem(index: index, value: searchHistory[index]);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 0,
                    );
                  },
                ),
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.sp),
                    child: NewButton(
                        text: translate('clear_all'),
                        textStyle: AppStyle.titleStyle.copyWith(
                            color: AppColorsController().white,fontSize: AppFontSize.fontSize_10, overflow: TextOverflow.ellipsis),
                        textPadding: EdgeInsets.symmetric(horizontal: 16.sp,vertical: 8.sp),
                        onPressed: () {
                          _clearAll();
                        }),
                  ),
                ),
                SizedBox(height: 16.sp,),
              ]
            ],
          ),
        ),
      ),
      // bottomSheet: bottomNavigationBarWidget(),
    );
  }

  Widget _bodySearchItems(){
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: items.length,shrinkWrap: true,padding: const EdgeInsets.all(8.0),
        physics: BouncingScrollPhysics(),
        itemBuilder: (context,index){

          return InkWell(
            onTap: (){
              print(categoriesBloc.currentSelect2);
            },
            child: Column(
              children: [
                Row(

                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(items[index].title.toString() ,style: TextStyle(color: AppColorsController().black,fontSize: AppFontSize.fontSize_12,)),
                        Text('موتورات',style: TextStyle(color: AppColorsController().greyTextColor,fontSize: AppFontSize.fontSize_14,)),
                      ],

                    ),
                    Spacer(),
                    Text('٢٠٠١ إعلانات',style: TextStyle(color: AppColorsController().buttonRedColor,fontSize: AppFontSize.fontSize_12,fontWeight: AppFontWeight.bold)),

                  ],),
                Divider(color: AppColorsController().buttonRedColor,height: 4),

              ],
            ),
          );
        });
  }
  Widget _searchItem({required int index,required String value}) {
    return TextButton(
      onPressed: () {

        // DIManager.findNavigator().pushNamed(
        //   ViewAllPage.routeName,
        //   arguments: ViewAllArgs(
        //     type: 3,
        //     title: value,
        //   ),
        // ).then((value) => _getData());
        setState(() {
          titleSearch =value;
          _onRefresh();

        });

      },
      style: TextButton.styleFrom(foregroundColor: AppColorsController().primaryColor,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 12.sp,),
              Icon(
                Icons.restore,
                color: AppColorsController().red,
              ),
              SizedBox(width: 4,),
              Text(value,style: TextStyle(color: AppColorsController().black,fontSize: AppFontSize.fontSize_12)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
                onPressed: () {
                  _removeItem(index);
                },
                icon: Icon(
                  Icons.close,
                  color: AppColorsController().red,
                )),
          )
        ],
      ),
    );
  }

  Widget oldWidget() {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      bloc: categoriesBloc,
      listener: (context, state) {
        setState(() {
          loadingLoader = false;
        });
      },
      builder: (context, state) {
        final categoriesState = state.getMainCategoriesState;

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
        if (loading && categoriesState is GetMainCategoriesSuccessState) {
          final data = (state.getMainCategoriesState as GetMainCategoriesSuccessState).categories;
          loading = false;
          categories.addAll(data);
        }
        return buildBody();
      },
    );
  }

  Widget _searchWidget() {
    return Container(
      height: 45.h,
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(14.sp),
        ),
        border: Border.all(color: AppColorsController().borderColor, width: 0.2),
        color: AppColorsController().card,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              // DIManager.findNavigator().pop();
            },
            child: SearchIcon(
              width: 28.sp,
              height: 20.sp,
            ),
          ),
          SizedBox(
            width: 12.w,
          ),
          Expanded(
            child: TextFieldWidget(
              textDirection: TextDirection.rtl,
              controller: searchController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.search,
              hintColor: AppColorsController().greyTextColor,

              onFieldSubmitted: (value) {
                _saveSearchValue(value);

               setState(() {
                 titleSearch =value;
                 _onRefresh();

               });

                // Navigator.push(context, MaterialPageRoute(builder: (context){
                //   return ViewAllSearch(
                //   arg: ViewAllArgs(
                //   type: 6,
                //   title: value,
                //
                // ),
                // );}));

                // DIManager.findNavigator().pushNamed(
                //   ViewAllSearch.routeName,
                //   arguments: ViewAllArgs(
                //     type: 6,
                //     title: value,
                //   ),
                // ).then((value) => _getData());
              },
              onTextChanged: (value) {
                print(value);
                setState(() {
                  searchValue = value;
                });
              },
              hint: translate("search_in_wadeema"),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40.sp),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColorsController().borderColor,
              width: 0.2,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.containerBorderRadius),
            ),
            color: AppColorsController().containerPrimaryColor,
          ),
          child: ListView.separated( physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.sp, vertical: 16.sp),
                  child: InkWell(
                    onTap: () {
                      DIManager.findNavigator().pushNamed(
                        ViewAllPage.routeName,
                        arguments: ViewAllArgs(
                          type: 3,
                          title: searchValue,
                          category_id: categories[index].category_id,
                        ),
                      ).then((value) => _getData());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Text(
                            categories[index].title!,
                            style: AppStyle.verySmallTitleStyle.copyWith(
                              color: AppColorsController().textPrimaryColor,
                              fontWeight: AppFontWeight.midLight,
                            ),
                            maxLines: 3,
                          ),
                        ),
                        Container(),
                        Flexible(
                          flex: 1,
                          child: SearchIcon(
                            width: 18.sp,
                            height: 18.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  height: 1.sp,
                  width: MediaQuery.of(context).size.width,
                  color: AppColorsController().borderColor,
                );
              },
              itemCount: categories.length),
        ),
        SizedBox(
          height: 120.sp,
        ),
      ],
    );
  }

  void _saveSearchValue(String value) {
    dataStore.getSearchHistory().then((values) {
      dataStore.setSearchHistory(values + [value]);
    });
  }

  void _removeItem(int index){
    dataStore.getSearchHistory().then((values) {
      values.removeAt(index);
      dataStore.setSearchHistory(values).then((value) => _getData());
    });
  }

  void _clearAll(){
    dataStore.setSearchHistory([]).then((value) => _getData());
  }

}
