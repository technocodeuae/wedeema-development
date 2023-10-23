import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/dimens.dart';
import 'package:wadeema/ui/work_focus_version/general/icons/check_icon.dart';
import '../../../../blocs/categories/categories_bloc.dart';
import '../../../../blocs/categories/states/categories_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/widgets/general_error_widget.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/buttons/app_button.dart';
import '../../general/icons/add_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import 'choose_listing_page.dart';

class ChooseCategoryPage extends StatefulWidget {
  static const routeName = '/ChooseCategoryPage';
  final Map<String, dynamic>? dataMap;

  const ChooseCategoryPage({Key? key, this.dataMap}) : super(key: key);

  @override
  State<ChooseCategoryPage> createState() => _ChooseCategoryPageState();
}

class _ChooseCategoryPageState extends State<ChooseCategoryPage> {
  final categoriesBloc = DIManager.findDep<CategoriesCubit>();

  int select = -1;
  bool _isLoading = false;



  @override
  void initState() {
    super.initState();
    categoriesBloc.getMainCategories();
    _isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsController().scaffoldBGColor,
      body: SafeArea(
        child: LoadingColumnOverlay(
          isLoading: _isLoading,
          child: BackLongPress(

            child: Column(
              children: [   SizedBox(height: 10.sp ,),
                AppBarWidget(
                  name: translate("place_ads"),
                  child: InkWell(
                    onTap: () {
                      DIManager.findNavigator().pop();
                    },
                    child: AddIcon(
                      width: 30.sp,
                      height: 30.sp,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
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
                                VerticalPadding(3.0),
                                GeneralErrorWidget(
                                  error: categoriesState.error,
                                  callback: categoriesState.callback,
                                ),
                              ],
                            );
                          }
                          if (categoriesState
                              is GetMainCategoriesSuccessState) {
                            final data = (state.getMainCategoriesState
                                    as GetMainCategoriesSuccessState)
                                .categories;
                            return Column(
                              children: [
                                SizedBox(
                                  height: 12.sp,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 60.sp),
                                  child: Text(
                                    translate(
                                        "choose_the_category_that_your_ad_fits_into"),
                                    style:
                                        AppStyle.verySmallTitleStyle.copyWith(
                                      color: AppColorsController().black,
                                      fontWeight: AppFontWeight.midLight,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40.sp,
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 32.sp),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColorsController().borderColor,
                                      width: 0.2,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          Dimens.containerBorderRadius),
                                    ),
                                    color: AppColorsController()
                                        .containerPrimaryColor,
                                  ),
                                  child: ListView.separated( physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 60.sp,
                                              vertical: 16.sp),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                select = index;
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  flex: 2,
                                                  child: Text(
                                                    data[index].title!,
                                                    style: AppStyle
                                                        .verySmallTitleStyle
                                                        .copyWith(
                                                      color:
                                                          AppColorsController()
                                                              .textPrimaryColor,
                                                      fontWeight: AppFontWeight
                                                          .midLight,
                                                    ),
                                                    maxLines: 3,
                                                  ),
                                                ),
                                                Container(),
                                                index == select
                                                    ? Flexible(
                                                        flex: 1,
                                                        child: CheckIcon(
                                                          width: 22.sp,
                                                        ),
                                                      )
                                                    : Flexible(
                                                        child: Container())
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return Container(
                                          height: 1.sp,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color:
                                              AppColorsController().borderColor,
                                        );
                                      },
                                      itemCount: data.length),
                                ),
                                SizedBox(
                                  height: 120.sp,
                                ),
                                AppButton(
                                  width: 150.sp,
                                  height: 44.sp,
                                  childPadding:
                                      EdgeInsets.symmetric(horizontal: 10.sp),
                                  onPressed: () {
                                    if (select == -1) {
                                      var snackBar = SnackBar(
                                        content: Text(
                                            translate('please_select_data')),
                                        behavior: SnackBarBehavior.floating,
                                        duration: Duration(seconds: 1),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else
                                      DIManager.findNavigator().pushNamed(
                                        SelectListingPage.routeName,
                                      );
                                  },
                                  child: Text(
                                    translate("continue"),
                                    style:
                                        AppStyle.verySmallTitleStyle.copyWith(
                                      color: AppColorsController()
                                          .textPrimaryColor,
                                      fontWeight: AppFontWeight.midLight,
                                    ),
                                  ),
                                ),
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
          ),
        ),
      ),
    );
  }
}
