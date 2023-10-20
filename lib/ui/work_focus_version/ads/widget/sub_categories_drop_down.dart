import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/blocs/categories/categories_bloc.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/app_consts.dart';
import 'package:wadeema/core/constants/app_font.dart';
import 'package:wadeema/core/constants/app_style.dart';
import 'package:wadeema/core/constants/dimens.dart';
import 'package:wadeema/data/models/categories/entity/categories_entity.dart';
import 'package:wadeema/repos/categories/categories_repo_i.dart';

import '../../../../blocs/application/application_bloc.dart';
import '../../../../blocs/categories/states/categories_state.dart';
import '../../../../core/di/di_manager.dart';

class SubCategoriesDropdownWidget extends StatefulWidget {
  const SubCategoriesDropdownWidget(
      {required this.child, required this.categoryId, required this.onSelected, this.selectedSubCategory, this.list});

  final Widget child;
  final int categoryId;
  final Function(CategoriesEntity?) onSelected;
  final List<CategoriesEntity?>? list;
  final int? selectedSubCategory;

  @override
  State<SubCategoriesDropdownWidget> createState() => _SubCategoriesDropdownWidgetState();
}

class _SubCategoriesDropdownWidgetState extends State<SubCategoriesDropdownWidget> {
  final categoriesBloc = CategoriesCubit(DIManager.findDep<CategoriesFacade>());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  void _getData(){
    if (widget.list == null) {
      categoriesBloc.getSubCategories(widget.categoryId);
    }
  }

  @override
  void didUpdateWidget(covariant SubCategoriesDropdownWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoryId != widget.categoryId) {
      _getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
        bloc: categoriesBloc,
        builder: (context, state) {
          final categoriesState = state.getSubCategoriesState;

          List<CategoriesEntity?>? list;

          if (categoriesState is GetSubCategoriesSuccessState) {
            list = (state.getSubCategoriesState as GetSubCategoriesSuccessState).categories;
          }

          if((widget.list ?? list)?.isEmpty ?? true){
            return SizedBox.shrink();
          }

          return PopupMenuButton<CategoriesEntity>(
            offset: Offset(
                20 * (DIManager.findDep<ApplicationCubit>().appLanguage.languageCode == AppConsts.LANG_AR ? -1 : 1),
                24),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.dialogBorderRadius)),
            color: AppColorsController().dropdown.withOpacity(0.9),
            itemBuilder: (BuildContext context) {
              return List.generate(
                  (widget.list ?? list)?.length ?? 0,
                  (index) => PopupMenuItem(
                        value: (widget.list ?? list)?[index],
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
                                      opacity:
                                          (widget.selectedSubCategory == (widget.list ?? list)?[index]?.id) ? 1 : 0,
                                      child: Icon(
                                        Icons.check_box,
                                        color: Colors.white,
                                        size: 15.sp,
                                      )),
                                  Text(
                                    '  ${(widget.list ?? list)?[index]?.title}  ',
                                    style: AppStyle.verySmallTitleStyle.copyWith(
                                      color: Colors.white,
                                      fontWeight: AppFontWeight.midLight,
                                    ),
                                  ),
                                  SizedBox.shrink()
                                ],
                              ),
                            ),
                            if (index < (((widget.list ?? list)?.length ?? 0) - 1)) ...[
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
        });
  }
}
