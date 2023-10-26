import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/blocs/application/application_bloc.dart';
import 'package:wadeema/blocs/cities/cities_bloc.dart';
import 'package:wadeema/blocs/cities/states/cities_state.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/app_consts.dart';
import 'package:wadeema/core/constants/app_font.dart';
import 'package:wadeema/core/constants/app_style.dart';
import 'package:wadeema/core/constants/dimens.dart';
import 'package:wadeema/core/di/di_manager.dart';
import 'package:wadeema/core/utils/localization/app_localizations.dart';
import 'package:wadeema/data/models/cities/entity/cities_entity.dart';

class SelectCityWidget extends StatefulWidget {
  const SelectCityWidget({key,this.onSelected,this.isFilter = false});

  final Function(Map<String,dynamic>)? onSelected;
  final bool isFilter;

  @override
  State<SelectCityWidget> createState() => _SelectCityWidgetState();
}

class _SelectCityWidgetState extends State<SelectCityWidget> {
  final citiesBloc = DIManager.findDep<CitiesCubit>();

  int select = -1;
  int cityId = -1;
  String? city;
  Map<String, dynamic> dataMap = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    citiesBloc.getCities();
  }

  void _showBottomSheet(BuildContext context,data) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _dropdownMenuList(data);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CitiesCubit, CitiesState>(
        bloc: citiesBloc,
        builder: (context, state) {
          final citiesState = state.getCitiesState;
          if (citiesState is CitiesSuccessState) {
            final data = (state.getCitiesState as CitiesSuccessState).cities;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.sp),
              child: InkWell(
                onTap: (){
                _showBottomSheet(context,data);
                },
                child: Container(
                  padding: EdgeInsets.only(bottom: 0.sp, left: 30.sp,right: 30.sp),
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
                  child: city == null? Row(
                    children: [
                      // _dropdownMenu(data),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_drop_down_sharp, color: AppColorsController().iconColor, size: 30.sp),
                          Text(
                            (city == null) ? translate("select_city") : (city ?? ''),
                            style: AppStyle.verySmallTitleStyle.copyWith(
                              color: AppColorsController().black,
                              fontWeight: AppFontWeight.midLight,
                            ),
                          ),
                        ],
                      ),
                      // selectItems != -1
                      //     ? Container(
                      //   padding: EdgeInsets.all(16),
                      //   child: Text('${data[selectItems].title}'),
                      // )
                      //     : Container(),
                      if ((city?.isEmpty ?? true) && !widget.isFilter) ...[
                        SizedBox(
                          width: 12.sp,
                        ),
                        Text(
                          translate("Where_should_we_place_your_ads"),
                          style: AppStyle.verySmallTitleStyle.copyWith(
                            color: AppColorsController().black,
                            fontWeight: AppFontWeight.midLight,
                          ),
                        ),
                                    ],
                    ],
                  ):

                      // _dropdownMenu(data),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.arrow_drop_down_sharp, color: AppColorsController().iconColor, size: 30.sp),
                            Text(
                              (city == null) ? translate("select_city") : (city ?? ''),
                              style: AppStyle.verySmallTitleStyle.copyWith(
                                color: AppColorsController().black,
                                fontWeight: AppFontWeight.midLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // selectItems != -1
                      //     ? Container(
                      //   padding: EdgeInsets.all(16),
                      //   child: Text('${data[selectItems].title}'),
                      // )
                      //     : Container(),
                      // if ((city?.isEmpty ?? true) && !widget.isFilter) ...[
                      //   SizedBox(
                      //     width: 12.sp,
                      //   ),
                      //   Text(
                      //     translate("Where_should_we_place_your_ads"),
                      //     style: AppStyle.verySmallTitleStyle.copyWith(
                      //       color: AppColorsController().black,
                      //       fontWeight: AppFontWeight.midLight,
                      //     ),
                      //   ),
                      // ],


                ),
              ),
            );
          }
          return SizedBox.shrink();
      }
    );
  }

  // Widget _dropdownMenu(List<CitiesEntity> data) {
  //   return PopupMenuButton(
  //     offset: Offset(
  //         24 * (DIManager.findDep<ApplicationCubit>().appLanguage.languageCode == AppConsts.LANG_AR ? -1 : 1), 24),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.dialogBorderRadius)),
  //     color: AppColorsController().dropdown.withOpacity(0.9),
  //     itemBuilder: (BuildContext context) {
  //       return List.generate(
  //           data.length,
  //               (index) => PopupMenuItem(
  //             value: index,
  //             // padding: EdgeInsets.symmetric(horizontal: 20.sp),
  //             height: 50.sp,
  //             child: Column(
  //               children: [
  //                 Padding(
  //                   padding: EdgeInsets.symmetric(horizontal: 20.sp,vertical: 4.sp),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Opacity(
  //                           opacity: index == select ? 1 : 0,
  //                           child: Icon(
  //                             Icons.check_box,
  //                             color: Colors.white,
  //                             size: 15.sp,
  //                           )),
  //                       Text(
  //                         '  ${data[index].title}  ',
  //                         style: AppStyle.verySmallTitleStyle.copyWith(
  //                           color: Colors.white,
  //                           fontWeight: AppFontWeight.midLight,
  //                         ),
  //                       ),
  //                       SizedBox.shrink(),
  //                       // SizedBox(height: 12.sp,),
  //                     ],
  //                   ),
  //                 ),
  //                 if (index < (data.length - 1)) ...[
  //                   Divider(
  //                     color: AppColorsController().white,
  //                     height: 0,
  //                   )
  //                 ]
  //               ],
  //             ),
  //           ));
  //     },
  //     onSelected: (newValue) {
  //       print(newValue);
  //       HapticFeedback.lightImpact();
  //       _selectCity(newValue as int, data);
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Icon(Icons.arrow_drop_down_sharp, color: AppColorsController().iconColor, size: 30.sp),
  //           SizedBox(
  //             width: 6.sp,
  //           ),
  //           Text(
  //             (city == null) ? translate("select_city") : (city ?? ''),
  //             style: AppStyle.verySmallTitleStyle.copyWith(
  //               color: AppColorsController().black,
  //               fontWeight: AppFontWeight.midLight,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //



  Widget _dropdownMenuEdit(List<CitiesEntity> data) {
    return PopupMenuButton(
      offset: Offset(
          24 * (DIManager.findDep<ApplicationCubit>().appLanguage.languageCode == AppConsts.LANG_AR ? -1 : 1), 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.dialogBorderRadius)),
      color: AppColorsController().dropdown.withOpacity(0.9),
      itemBuilder: (BuildContext context) {
        return List.generate(
            data.length,
                (index) => PopupMenuItem(
              value: index,
              // padding: EdgeInsets.symmetric(horizontal: 20.sp),
              height: 50.sp,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp,vertical: 4.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Opacity(
                            opacity: index == select ? 1 : 0,
                            child: Icon(
                              Icons.check_box,
                              color: Colors.white,
                              size: 15.sp,
                            )),
                        Text(
                          '  ${data[index].title}  ',
                          style: AppStyle.verySmallTitleStyle.copyWith(
                            color: Colors.white,
                            fontWeight: AppFontWeight.midLight,
                          ),
                        ),
                        SizedBox.shrink(),
                        // SizedBox(height: 12.sp,),
                      ],
                    ),
                  ),
                  if (index < (data.length - 1)) ...[
                    Divider(
                      color: AppColorsController().white,
                      height: 0,
                    )
                  ]
                ],
              ),
            ));
      },
      onSelected: (newValue) {
        HapticFeedback.lightImpact();
        _selectCity(newValue as int, data);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.arrow_drop_down_sharp, color: AppColorsController().iconColor, size: 30.sp),
            SizedBox(
              width: 6.sp,
            ),
            Text(
              (city == null) ? translate("select_city") : (city ?? ''),
              style: AppStyle.verySmallTitleStyle.copyWith(
                color: AppColorsController().black,
                fontWeight: AppFontWeight.midLight,
              ),
            ),
          ],
        ),
      ),
    );
  }


  int selectItems = -1;
  Widget _dropdownMenuList(List<CitiesEntity> data) {
    return Container(
      height: 300.sp,

      decoration: BoxDecoration(
          color: AppColorsController().dropdown.withOpacity(0.9),
          borderRadius:
          BorderRadius.only(topRight: Radius.circular(10.sp),topLeft: Radius.circular(10.sp)),
          boxShadow: [AppStyle.normalShadow]),
      child: ListView.builder(
itemCount: data.length,

        itemBuilder: (BuildContext context,index) {
          return Column(
            children: [
              InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                  HapticFeedback.lightImpact();
                  _selectCity(index, data);
                  setState(() {
                    selectItems = index;
                  });
                                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp,vertical: 4.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Opacity(
                          opacity: index == select ? 1 : 0,
                          child: Icon(
                            Icons.check_box,
                            color: Colors.white,
                            size: 15.sp,
                          )),
                      Text(
                        '  ${data[index].title}  ',
                        style: AppStyle.verySmallTitleStyle.copyWith(
                          color: Colors.white,
                          fontWeight: AppFontWeight.midLight,fontSize: 23.sp
                        ),

                      ),
                      SizedBox.shrink(),
                      // SizedBox(height: 12.sp,),
                    ],
                  ),
                ),
              ),
              Container(
                height: 1, // ارتفاع المساحة بين العناصر
                color: Colors.grey, // لون المساحة
              ),
              // if (index < (data.length - 1)) ...[
              //   Divider(
              //     color: AppColorsController().white,
              //     height: 0,
              //   )
              // ]
            ],
          );
        },
        // onSelected: (newValue) {
        //   HapticFeedback.lightImpact();
        //   _selectCity(newValue as int, data);
        // },

        // child: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Icon(Icons.arrow_drop_down_sharp, color: AppColorsController().iconColor, size: 30.sp),
        //       SizedBox(
        //         width: 6.sp,
        //       ),
        //       Text(
        //         (city == null) ? translate("select_city") : (city ?? ''),
        //         style: AppStyle.verySmallTitleStyle.copyWith(
        //           color: AppColorsController().black,
        //           fontWeight: AppFontWeight.midLight,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }

  void _selectCity(int newValue,List<CitiesEntity> data){
    setState(() {
      select = newValue;
      cityId = data[newValue].id ?? 0;
      city = data[newValue].title;
      dataMap["city_id"] = cityId;
      dataMap["city_name"] = city;
      if(widget.onSelected != null) {
        widget.onSelected!(dataMap);
      }

    });
  }
}
