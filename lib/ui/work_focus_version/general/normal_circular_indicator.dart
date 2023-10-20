import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/di_manager.dart';

class NormalCircularIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(
          DIManager.findDep<AppColorsController>().primaryColor.withOpacity(0.9),
        ),
      ),
    );
  }
}
