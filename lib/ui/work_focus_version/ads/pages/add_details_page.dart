import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/dimens.dart';


import '../../../../blocs/categories/categories_bloc.dart';
import '../../../../blocs/categories/states/categories_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/widgets/general_error_widget.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
import '../../../../data/models/properties/entity/properties_entity.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/buttons/app_button.dart';
import '../../general/icons/back_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../../home/arg/view_all_args.dart';
import '../../home/pages/view_all_page.dart';
import 'add_main_details_page.dart';

class AddDetailsPage extends StatefulWidget {
  static const routeName = '/AddDetailsPage';
  final Map<String, dynamic>? dataMap;

  const AddDetailsPage({Key? key, this.dataMap}) : super(key: key);

  @override
  State<AddDetailsPage> createState() => _AddDetailsPageState();
}

class _AddDetailsPageState extends State<AddDetailsPage> {
  final categoriesBloc = DIManager.findDep<CategoriesCubit>();

  final Map<int, String> myValue = Map();

  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    myValue.clear();
    _isLoading = true;
    categoriesBloc.getPropertiesCategories(widget.dataMap!['category_id']);
  }

  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsController().scaffoldBGColor,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
          new TextEditingController().clear();
        },
        child: SafeArea(
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
                      child: BackIcon(
                        width: 26.sp,
                        height: 18.sp,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 12.sp,
                        ),
                        widget.dataMap!["filter"] == true
                            ? Container()
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 60.sp),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      translate("you_are_almost_there"),
                                      style:
                                          AppStyle.verySmallTitleStyle.copyWith(
                                        color: AppColorsController().black,
                                        fontWeight: AppFontWeight.midLight,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 8.sp,
                                    ),
                                    Text(
                                      translate("include_much_details"),
                                      style:
                                          AppStyle.verySmallTitleStyle.copyWith(
                                        color: AppColorsController().black,
                                        fontWeight: AppFontWeight.midLight,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                        SizedBox(
                          height: 40.sp,
                        ),
                        BlocConsumer<CategoriesCubit, CategoriesState>(
                          bloc: categoriesBloc,
                          listener: (context, state) {
                            setState(() {
                              _isLoading = false;
                            });
                          },
                          builder: (context, state) {
                            final getPropertiesCategoriesState =
                                state.getPropertiesCategories;

                            if (getPropertiesCategoriesState is BaseFailState) {
                              return Column(
                                children: [
                                  VerticalPadding(3.0),
                                  GeneralErrorWidget(
                                    error: getPropertiesCategoriesState.error,
                                    callback:
                                        getPropertiesCategoriesState.callback,
                                  ),
                                ],
                              );
                            }
                            if (getPropertiesCategoriesState
                                is GetPropertiesCategoriesSuccessState) {
                              data = (state.getPropertiesCategories
                                      as GetPropertiesCategoriesSuccessState)
                                  .propertiesCategories;

                              // if(data.length==0){
                              //   if(widget.dataMap!["filter"] == true){
                              //     DIManager.findNavigator().pushNamed(
                              //       ViewAllPage.routeName,
                              //       arguments: ViewAllArgs(
                              //         type: 4,
                              //         formData: widget.dataMap!["properties"],
                              //         category_id: widget?.dataMap!["category_id"],
                              //       ),
                              //     );
                              //   }
                              //   else
                              //     DIManager.findNavigator().pushNamed(
                              //         AddMainDetailsPage.routeName,
                              //         arguments: widget!.dataMap!
                              //     );
                              //   }
                              return _buildBody();
                            }
                            return _buildBody();
                          },
                        ),
                        SizedBox(
                          height: 16.sp,
                        ),
                        Container(
                          width: 150.sp,
                          height: 44.sp,
                          margin: EdgeInsets.symmetric(horizontal: 120.sp),
                          child: AppButton(
                            width: 150.sp,
                            height: 44.sp,
                            childPadding: EdgeInsets.symmetric(horizontal: 10.sp),
                            onPressed: () {
                              List<String> mapDetails = [];

                              myValue.forEach((key, value) {
                                mapDetails.add(json.encode({
                                  "property_id": key,
                                  "description": value.toString()
                                }));
                              });

                              widget.dataMap!["properties"] =
                                  json.encode(mapDetails);

                              if (widget.dataMap!["filter"] == true) {
                                DIManager.findNavigator().pushNamed(
                                  ViewAllPage.routeName,
                                  arguments: ViewAllArgs(
                                    type: 4,
                                    formData: json.encode(mapDetails),
                                    category_id: widget?.dataMap!["category_id"],
                                  ),
                                );
                              } else
                                DIManager.findNavigator().pushNamed(
                                    AddMainDetailsPage.routeName,
                                    arguments: widget!.dataMap!);

                              // DIManager.findNavigator().pushNamed(
                              //   SafetyPage.routeName,
                              //     arguments: widget.dataMap!
                              // );
                            },
                            child: Text(
                              translate("continue"),
                              style: AppStyle.verySmallTitleStyle.copyWith(
                                color: AppColorsController().textPrimaryColor,
                                fontWeight: AppFontWeight.midLight,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.sp,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildTextField({required int id, String? title}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title! + ": ",
          style: AppStyle.smallTitleStyle.copyWith(
            color: AppColorsController().textPrimaryColor,
          ),
        ),
        Expanded(

          child: TextField(
            autofocus: false,
            style: AppStyle.tinySmallTitleStyle.copyWith(
              color: AppColorsController().naveTextColor,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter ${title} here',
                hintStyle: AppStyle.tinyTitleStyle.copyWith(
                  color: AppColorsController().black
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 13.sp)),
            onChanged: (value) {
              myValue[id] = value.toString();
            },
          ),
        ),
      ],
    );
  }

  buildDropdownButton(
      {List<ItemsSubPropertiesEntity>? sub_properties,
      required int id,
      String? title}) {
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: Text(
            title! + ": ",
            style: AppStyle.smallTitleTextStyle.copyWith(
              color: AppColorsController().textPrimaryColor,
            ),
            maxLines: 5,
          ),
        ),
        SizedBox(
          width: 4.sp,
        ),
        Flexible(
          flex: 4,
          child: DropdownButtonHideUnderline(

            child: DropdownButton(
              iconSize: 24.sp,
              isExpanded: true,
              dropdownColor: AppColorsController().white,
              alignment: Alignment.centerLeft,
              style: AppStyle.tinySmallTitleStyle.copyWith(
                color: AppColorsController().naveTextColor,
              ),
              hint: Text('Please choose a ${title}',style: AppStyle.tinyTitleStyle.copyWith(
                color: AppColorsController().black
              ),),
              // Not necessary for Option 1
              value: myValue[id],
              onChanged: (newValue) {
                setState(() {
                  myValue[id] = newValue.toString();
                });
              },
              items: sub_properties?.map((property) {
                return DropdownMenuItem(

                  child: new Text(property.title.toString()),
                  value: property.title,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  _buildBody() {
    return ListView.separated( physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return Container(
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
              child: data[index].sub_properties!.length > 0
                  ? buildDropdownButton(
                      title: data[index].property!.title.toString(),
                      sub_properties: data[index].sub_properties,
                      id: data[index].property!.id!)
                  : buildTextField(
                      title: data[index].property!.title!,
                      id: data[index].property!.id!),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 8.sp,
          );
        },
        itemCount: data.length);
  }
}
