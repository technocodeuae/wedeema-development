import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/blocs/categories/categories_bloc.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/utils/localization/app_localizations.dart';

import '../../../../core/di/di_manager.dart';

class PrivacyWidget extends StatefulWidget {
  const PrivacyWidget({this.color});

  final Color? color;

  @override
  State<PrivacyWidget> createState() => _PrivacyWidgetState();
}

class _PrivacyWidgetState extends State<PrivacyWidget> {
  final categoriesBloc = DIManager.findDep<CategoriesCubit>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              categoriesBloc.isAcceptPrivacy = !categoriesBloc.isAcceptPrivacy;
              setState(() {

              });
            },
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: AppColorsController().selectIconColor, width: 2.2)),
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Opacity(
                    opacity: categoriesBloc.isAcceptPrivacy ? 1 : 0,
                    child: Icon(Icons.check, color: AppColorsController().selectIconColor, size: 16)),
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              translate('agreement_privacy'),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 13.sp,color: widget.color ?? AppColorsController().darkRed, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
