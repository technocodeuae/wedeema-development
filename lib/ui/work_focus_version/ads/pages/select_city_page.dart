import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/dimens.dart';
import 'package:wadeema/ui/work_focus_version/general/icons/check_icon.dart';
import 'package:wadeema/ui/work_focus_version/widget/select_city_widget.dart';
import '../../../../blocs/cities/cities_bloc.dart';
import '../../../../blocs/cities/states/cities_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/widgets/general_error_widget.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/icons/add_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../../home/widget/app_bar_app.dart';
import 'choose_listing_page.dart';

class SelectCityPage extends StatefulWidget {
  static const routeName = '/SelectCityPage';

  const SelectCityPage({Key? key}) : super(key: key);

  @override
  State<SelectCityPage> createState() => _SelectCityPageState();
}

class _SelectCityPageState extends State<SelectCityPage> {
  final citiesBloc = DIManager.findDep<CitiesCubit>();

  int select = -1;
  int cityId = -1;
  Map<String, dynamic> dataMap = {};
  bool  _isLoading = false;


  @override
  void initState() {
    citiesBloc.getCities();
    _isLoading = true;
    dataMap.clear();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsController().scaffoldBGColor,
      appBar: appBarApp(context,text: translate("place_ads"),
          isNeedBack: true
      ),
      body:  SafeArea(
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
                //     child: AddIcon(
                //       width: 30.sp,
                //       height: 30.sp,
                //     ),
                //   ),
                // ),
                Expanded(
                  child: ListView(
                    children: [
                      BlocConsumer<CitiesCubit, CitiesState>(
                        bloc: citiesBloc,
                        listener: (context, state) {
                          setState(() {
                            _isLoading = false;
                          });
                        },
                        builder: (context, state) {
                          final citiesState = state.getCitiesState;

                          if (citiesState is BaseFailState) {
                            return ListView(
                              children: [
                                VerticalPadding(3.0),
                                GeneralErrorWidget(
                                  error: citiesState.error,
                                  callback: citiesState.callback,
                                ),
                              ],
                            );
                          }

                          if (citiesState is CitiesSuccessState) {
                            final data =
                                (state.getCitiesState as CitiesSuccessState).cities;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 12.sp,
                                ),
                                SelectCityWidget(),
                                SizedBox(
                                  height: 40.sp,
                                ),
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
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 60.sp, vertical: 16.sp),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                select = index;
                                                cityId = data[index].id!;
                                                dataMap["city_id"] = cityId;
                                                if (cityId == -1) {

                                                  const snackBar = SnackBar(
                                                    content: Text('Please select city'),
                                                    behavior: SnackBarBehavior.floating,
                                                    duration: Duration(seconds: 1),
                                                  );
                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                                } else
                                                  DIManager.findNavigator().pushNamed(
                                                      SelectListingPage.routeName,
                                                      arguments: dataMap);
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data[index].title!,
                                                  style:
                                                  AppStyle.verySmallTitleStyle.copyWith(
                                                    color: AppColorsController()
                                                        .textPrimaryColor,
                                                    fontWeight: AppFontWeight.midLight,
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
                                // AppButton(
                                //   width: 150.sp,
                                //   height: 44.sp,
                                //   childPadding: EdgeInsets.symmetric(horizontal: 10.sp),
                                //   onPressed: () {
                                //     dataMap["city_id"] = cityId;
                                //     if (cityId == -1) {
                                //
                                //       const snackBar = SnackBar(
                                //         content: Text('Please select city'),
                                //         behavior: SnackBarBehavior.floating,
                                //         duration: Duration(seconds: 1),
                                //       );
                                //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                //
                                //     } else
                                //       DIManager.findNavigator().pushNamed(
                                //           SelectListingPage.routeName,
                                //           arguments: dataMap);
                                //   },
                                //   child: Text(
                                //     translate("continue"),
                                //     style: AppStyle.verySmallTitleStyle.copyWith(
                                //       color: AppColorsController().textPrimaryColor,
                                //       fontWeight: AppFontWeight.midLight,
                                //     ),
                                //   ),
                                // ),
                              ],
                            );
                          }
                          return Container();
                        },
                      )
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
