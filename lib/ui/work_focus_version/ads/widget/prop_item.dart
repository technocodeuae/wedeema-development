import 'package:flutter/material.dart';
import 'package:wadeema/blocs/application/application_bloc.dart';
import 'package:wadeema/core/constants/app_colors.dart';
import 'package:wadeema/core/constants/app_consts.dart';
import 'package:wadeema/core/di/di_manager.dart';

class PropItem extends StatelessWidget {
  const PropItem({required this.title, required this.onClick});

  final String title;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: onClick,
          style: TextButton.styleFrom(foregroundColor: AppColorsController().scaffoldBGColor, padding: EdgeInsets.all(8.0)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        Divider(
          color: AppColorsController().borderColor,
          height: 0,
          thickness: 0.2,
        )
      ],
    );
  }
}
