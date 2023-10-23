import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/shared_prefs/data_store.dart';
import 'package:wadeema/ui/work_focus_version/ads/args/argument_category.dart';
import 'package:wadeema/ui/work_focus_version/ads/pages/add_main_details_page.dart';
import 'package:wadeema/ui/work_focus_version/ads/widget/post_ad_button.dart';
import 'package:wadeema/ui/work_focus_version/general/app_bar/app_bar.dart';
import 'package:wadeema/ui/work_focus_version/home/pages/view_all_page.dart';

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
import '../../../../data/models/categories/entity/categories_entity.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '../../general/icons/back_icon.dart';
import '../../general/icons/search_icon.dart';
import '../../general/text_fields/text_field_widget.dart';
import '../arg/view_all_args.dart';

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
  final List<CategoriesEntity> categories = [];

  bool loading = false;
  bool loadingLoader = false;

  List<String> searchHistory = [];

  @override
  void initState() {
    super.initState();
    loading = true;
    loadingLoader = true;
    categoriesBloc.getMainCategories();
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

  @override
  void didUpdateWidget(covariant SearchPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

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
              AppBarWidget(
                flip: true,
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
                    Text(
                      translate('search'),
                      style: AppStyle.bigTitleStyle.copyWith(
                          color: AppColorsController().black, fontSize: 20.sp, fontWeight: AppFontWeight.bold),
                    ),
                    SizedBox(
                      height: 24.sp,
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

              if(searchHistory.isNotEmpty)...[
                SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(translate('last_search'),textAlign: TextAlign.start, style: TextStyle(color: AppColorsController().black, fontSize: 16.sp)),
                ),
                ListView.separated( physics: BouncingScrollPhysics(),
                  itemCount: searchHistory.length,
                  padding: EdgeInsets.symmetric(horizontal: 8),
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
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: NewButton(
                        text: translate('clear_all'),
                        textStyle: AppStyle.titleStyle.copyWith(
                            color: AppColorsController().white,fontSize: 12.sp, overflow: TextOverflow.ellipsis),
                        textPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                        onPressed: () {
                          _clearAll();
                        }),
                  ),
                ),

              ]
            ],
          ),
        ),
      ),
      bottomSheet: bottomNavigationBarWidget(),
    );
  }

  Widget _searchItem({required int index,required String value}) {
    return TextButton(
      onPressed: () {
        DIManager.findNavigator().pushNamed(
          ViewAllPage.routeName,
          arguments: ViewAllArgs(
            type: 3,
            title: value,
          ),
        ).then((value) => _getData());
      },
      style: TextButton.styleFrom(foregroundColor: AppColorsController().primaryColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 12,),
              Icon(
                Icons.restore,
                color: AppColorsController().red,
              ),
              SizedBox(width: 4,),
              Text(value,style: TextStyle(color: AppColorsController().black)),
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
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.sp),
        ),
        border: Border.all(color: AppColorsController().borderColor, width: 0.2),
        color: AppColorsController().card,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              DIManager.findNavigator().pop();
            },
            child: SearchIcon(
              width: 28.sp,
              height: 20.sp,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: TextFieldWidget(
              controller: searchController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.search,
              hintColor: AppColorsController().greyTextColor,
              onFieldSubmitted: (value) {
                _saveSearchValue(value);

                DIManager.findNavigator().pushNamed(
                  ViewAllPage.routeName,
                  arguments: ViewAllArgs(
                    type: 3,
                    title: value,
                  ),
                ).then((value) => _getData());
              },
              onTextChanged: (value) {
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
