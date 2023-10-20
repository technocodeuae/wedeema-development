import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/blocs/cities/cities_bloc.dart';
import 'package:wadeema/blocs/cities/states/cities_state.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/app_consts.dart';
import 'package:wadeema/core/constants/app_font.dart';
import 'package:wadeema/core/constants/app_style.dart';
import 'package:wadeema/core/constants/dimens.dart';

import '../../../../blocs/application/application_bloc.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../data/models/cities/entity/cities_entity.dart';

class CitiesDropdownWidget extends StatefulWidget {
  const CitiesDropdownWidget({required this.child, required this.onSelected, this.selectedCity});

  final Widget child;
  final Function(CitiesEntity?) onSelected;
  final int? selectedCity;

  @override
  State<CitiesDropdownWidget> createState() => _CitiesDropdownWidgetState();
}

class _CitiesDropdownWidgetState extends State<CitiesDropdownWidget> {
  final citiesBloc = DIManager.findDep<CitiesCubit>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    citiesBloc.getCities();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CitiesCubit, CitiesState>(
        bloc: citiesBloc,
        builder: (context, state) {
          final citiesState = state.getCitiesState;
          if (citiesState is CitiesSuccessState) {
            final data = (state.getCitiesState as CitiesSuccessState).cities;

            return PopupMenuButton<CitiesEntity>(
              offset: Offset(
                  20 * (DIManager.findDep<ApplicationCubit>().appLanguage.languageCode == AppConsts.LANG_AR ? -1 : 1),
                  24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.dialogBorderRadius)),
              color: AppColorsController().dropdown.withOpacity(0.9),
              itemBuilder: (BuildContext context) {
                return List.generate(
                    data.length,
                    (index) => PopupMenuItem(
                          value: data[index],
                          padding: EdgeInsets.zero,
                          height: 24.sp,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.sp, vertical: 2.sp),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Opacity(
                                        opacity: (widget.selectedCity == data[index].id) ? 1 : 0,
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
                                    SizedBox.shrink()
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
                widget.onSelected(newValue);
              },
              child: widget.child,
            );
          }
          return widget.child;
        });
  }
}
