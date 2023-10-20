import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class DividerItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColorsController().borderColor,
      height: 0,
      thickness: 0.2,
    );
  }
}
