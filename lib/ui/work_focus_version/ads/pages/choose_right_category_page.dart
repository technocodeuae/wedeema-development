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
import '../../general/icons/back_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../../home/widget/app_bar_app.dart';
import '../args/argument_category.dart';
import 'add_details_page.dart';
import 'add_main_details_page.dart';

class ChooseRightCategoryPage extends StatefulWidget {
  static const routeName = '/ChooseRightCategoryPage';
  final ArgumentCategory? argumentCategory;

  const ChooseRightCategoryPage({Key? key, this.argumentCategory})
      : super(key: key);

  @override
  State<ChooseRightCategoryPage> createState() =>
      _ChooseRightCategoryPageState();
}

class _ChooseRightCategoryPageState extends State<ChooseRightCategoryPage> {
  int select = -1;
  int subSelectId = -1;
  List<dynamic> data = [];
  final categoriesBloc = DIManager.findDep<CategoriesCubit>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    categoriesBloc.getSubCategories(widget.argumentCategory!.id!);
    _isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsController().scaffoldBGColor,
      appBar: appBarApp(context,text: translate("place_ads"),
          isNeedBack: true
      ),
      body: SafeArea(
        child: LoadingColumnOverlay(
          isLoading: _isLoading,
          child: BackLongPress(
            child: Column(
              children: [
                // SizedBox(height: 10.sp ,),
                // AppBarWidget(
                //   name: translate("place_ads"),
                //   child: InkWell(
                //     onTap: () {
                //       DIManager.findNavigator().pop();
                //     },
                //     child: BackIcon(
                //       width: 26.sp,
                //       height: 18.sp,
                //     ),
                //   ),
                // ),
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 12.sp,
                      ),
                      widget.argumentCategory?.dataMap!["filter"] == true
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 60.sp),
                              child: Text(
                                translate(
                                    "choose_the_category_that_your_ad_fits_into"),
                                style: AppStyle.verySmallTitleStyle.copyWith(
                                  color: AppColorsController().black,
                                  fontWeight: AppFontWeight.midLight,
                                ),
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60.sp),
                        child: Text(
                          "${widget.argumentCategory?.name!}",
                          style: AppStyle.verySmallTitleStyle.copyWith(
                            color: AppColorsController().black,
                            fontWeight: AppFontWeight.midLight,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.sp,
                      ),
                      Container(
                        child: BlocConsumer<CategoriesCubit, CategoriesState>(
                          bloc: categoriesBloc,
                          listener: (context, state) {
                            setState(() {
                              _isLoading = false;
                            });
                          },
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
                              data = (state.getSubCategoriesState
                                      as GetSubCategoriesSuccessState)
                                  .categories;

                              // if(data.length==0){
                              //   widget.argumentCategory?.dataMap!["category_id"] = widget.argumentCategory!.id!;
                              //   DIManager.findNavigator().pushNamed(
                              //       AddDetailsPage.routeName,
                              //       arguments: widget.argumentCategory!.dataMap!
                              //   );
                              // }
                              return _buildBody();
                            }
                            return _buildBody();
                          },
                        ),
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

  _buildBody() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 32.sp),
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
          child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              primary: false,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 60.sp, vertical: 16.sp),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        select = index;
                        subSelectId = data[index].category_id!;
                        if (data.length > 0 && select == -1) {
                          var snackBar = SnackBar(
                            content: Text(
                              translate('please_select_data'),
                            ),
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 1),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (select != -1 && data[select].hasChild == 1) {
                          print("hasChild?" + data[select].hasChild.toString());
                          DIManager.findNavigator().pushNamed(
                              ChooseRightCategoryPage.routeName,
                              arguments: ArgumentCategory(
                                  id: subSelectId,
                                  dataMap: widget.argumentCategory!.dataMap,
                                  name: "${widget.argumentCategory!.name} > " +
                                      data[select].title!));
                        } else {
                          if (subSelectId != -1)
                            widget.argumentCategory?.dataMap!["category_id"] =
                                subSelectId;
                          else {
                            widget.argumentCategory?.dataMap!["category_id"] =
                                widget.argumentCategory!.id!;
                          }
                          DIManager.findNavigator().pushNamed(
                              AddDetailsPage.routeName,
                              arguments: widget.argumentCategory!.dataMap!);
                        }
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            data[index].title!,
                            style: AppStyle.verySmallTitleStyle.copyWith(
                              color: AppColorsController().textPrimaryColor,
                              fontWeight: AppFontWeight.midLight,
                            ),
                            maxLines: 3,
                          ),
                        ),
                        index == select
                            ? CheckIcon(
                                width: 22.sp,
                              )
                            : Container()
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
              itemCount: data.length),
        ),
        SizedBox(
          height: 120.sp,
        ),
      ],
    );
  }
}
