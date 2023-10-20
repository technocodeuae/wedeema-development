// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/utils/app_general_utils.dart';
import 'package:wadeema/ui/work_focus_version/ads/pages/add_main_details_page.dart';
import 'package:wadeema/ui/work_focus_version/general/icons/check_icon.dart';
import 'package:wadeema/ui/work_focus_version/widget/select_city_widget.dart';

import '../../../../blocs/categories/categories_bloc.dart';
import '../../../../blocs/categories/states/categories_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_consts.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/widgets/general_error_widget.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
import '../../../../data/models/categories/entity/categories_entity.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '../../general/icons/back_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../args/argument_category.dart';

class SelectListingPage extends StatefulWidget {
  static const routeName = '/SelectListingPage';
  Map<String, dynamic>? dataMap;

  SelectListingPage({Key? key, this.dataMap}) : super(key: key);

  @override
  State<SelectListingPage> createState() => _SelectListingPageState();
}

class _SelectListingPageState extends State<SelectListingPage> {
  int select = -1;
  int categorySelect = -1;
  List<CategoriesEntity> data = [];

  final categoriesBloc = DIManager.findDep<CategoriesCubit>();
  bool  _isLoading = false;

  bool _isFilter() => widget.dataMap?["filter"] == true;

  @override
  void initState() {
    super.initState();
    categoriesBloc.getMainCategories();
    _isLoading = true;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: bottomNavigationBarWidget(),
        backgroundColor: AppColorsController().greyBackground,
        body: LoadingColumnOverlay(
            isLoading: _isLoading,
            child: BackLongPress(
              child: Column(
                children: [   SizedBox(height: 10.sp ,),
                  AppBarForPages(
                    name: translate(_isFilter() ? 'filter' : "place_ads"),

                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 20.sp,
                        ),
                        SelectCityWidget(
                            isFilter: _isFilter(),
                            onSelected: (dataMap) {
                              bool isFilter = _isFilter();
                              widget.dataMap = dataMap;
                              if (isFilter) {
                                widget.dataMap?['filter'] = true;
                              }
                            }),
                        BlocConsumer<CategoriesCubit, CategoriesState>(
                          bloc: categoriesBloc,
                          listener: (context, state) {
                            setState(() {
                              _isLoading = false;
                            });
                          },
                          builder: (context, state) {
                            final categoriesState = state.getMainCategoriesState;

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
                            if (categoriesState is GetMainCategoriesSuccessState) {
                              data = (state.getMainCategoriesState
                              as GetMainCategoriesSuccessState)
                                  .categories;
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 20.sp,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 40.sp),
                                    child: GridView.builder(
                                      itemCount: data.length,
                                      shrinkWrap: true,

                                      itemBuilder: (context, index) =>
                                          lookingItemsWidget(
                                              categories: data[index], itemNo: index),
                                      gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 0.9,
                                        crossAxisSpacing: 30.sp,
                                        mainAxisSpacing: 10.sp,
                                      ),
                                      physics: NeverScrollableScrollPhysics(),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 60.sp,
                                  // ),
                                ],
                              );

                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget lookingItemsWidget(
      {required CategoriesEntity categories,
      required int itemNo,
      double? height,
      double? width}) {
    return Container(
      height: height ?? 50.sp,
      width: width ?? 40.sp,
      decoration: BoxDecoration(
        border: Border.all(color: AppColorsController().black, width: 0.2),
        color: AppColorsController().containerPrimaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(12.sp),
        ),
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            select = itemNo;
            categorySelect = categories.category_id ?? 0;
            if (select == -1) {
              var snackBar = SnackBar(
                content: Text(translate('Please select data')),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 1),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              if (data[select].hasChild == 1) {
                print('widget.dataMap: ${widget.dataMap}');
                if ((widget.dataMap?['city_id'] ?? -1) == -1) {
                  AppUtils.showMessage(context: context, message: translate('select_city'));
                  return;
                }

                widget.dataMap?['category_id'] = categorySelect;
                print('widget.dataMap: ${widget.dataMap}');
                DIManager.findNavigator().pushNamed(AddMainDetailsPage.routeName,
                    arguments: ArgumentCategory(
                        id: categorySelect, dataMap: widget.dataMap, name: (data[select].title ?? ''), list: data));
                // DIManager.findNavigator().pushNamed(
                //     ChooseRightCategoryPage.routeName,
                //     arguments: ArgumentCategory(
                //         id: categorySelect,
                //         dataMap: widget.dataMap,
                //         name: "......> " + data[select].title!));
              } else {}
            }
          });
        },
        style: TextButton.styleFrom(
            foregroundColor: AppColorsController().lightRed,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                itemNo == select
                    ? CheckIcon(
                        width: 22.sp,
                      )
                    : Container(),
              ],
            ),
            itemNo == select
                ? Container()
                : SizedBox(
                    height: 20.sp,
                  ),
            Center(
              child: categories.icon.toString().endsWith(".svg") == true
                  ? SvgPicture.network(
                      AppConsts.IMAGE_URL + categories.icon,
                      width: 34.sp,
                      height: 34.sp,placeholderBuilder: (BuildContext context) => Container(
                width: 18.sp,height: 18.sp,
                child: CircularProgressIndicator(
                  strokeWidth: 1.2,
                  color: AppColorsController().buttonRedColor,),
              )

              )
                  : Image.network(
                      AppConsts.IMAGE_URL + categories.icon,
                      width: 34.sp,
                      height: 34.sp,
                      fit: BoxFit.fill,
                    ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            Center(
              child: Text(
                categories.title!,
                style: AppStyle.verySmallTitleStyle.copyWith(
                  color: AppColorsController().black,
                  fontWeight: AppFontWeight.bold,overflow: TextOverflow.ellipsis,
                ),maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 6.sp,
            ),
          ],
        ),
      ),
    );
  }
}
