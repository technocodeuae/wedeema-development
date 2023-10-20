import 'package:flutter/material.dart';
import 'package:wadeema/blocs/application/application_bloc.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/app_consts.dart';
import 'package:wadeema/core/constants/app_font.dart';
import 'package:wadeema/core/di/di_manager.dart';
import 'package:wadeema/ui/work_focus_version/ads/widget/divider_item.dart';

class OptionItem extends StatelessWidget {
  const OptionItem({required this.title, required this.subtitle, required this.onClick});

  final String title, subtitle;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: null,
          style: TextButton.styleFrom(foregroundColor: AppColorsController().scaffoldBGColor, padding: EdgeInsets.all(8.0)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColorsController().black,fontWeight: FontWeight.bold,fontSize: AppFontSize.fontSize_16)),
                SizedBox(width: 8,),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(subtitle,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: AppColorsController().greyTextColor,height: 1.2)),
                      ),
                      Icon(
                        DIManager.findDep<ApplicationCubit>().appLanguage.languageCode == AppConsts.LANG_EN
                            ? Icons.keyboard_arrow_right_sharp
                            : Icons.keyboard_arrow_left_sharp,
                        color: AppColorsController().selectIconColor,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        DividerItem()
      ],
    );
  }
}
