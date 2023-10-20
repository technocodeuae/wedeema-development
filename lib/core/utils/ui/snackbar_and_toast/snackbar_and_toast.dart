import 'package:flutter/material.dart';
import '../../../../core/di/di_manager.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/errors/base_error.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/screen_utils/device_utils.dart';

class CustomSnackbar {
  static const String routeName = 'CustomSnackbar/showSnackbar';

  static showSnackbar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
            content: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenHelper.fromHeight55(1.0)),
                child: Text(
                  message,
                  maxLines: 2,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
          backgroundColor:
          DIManager.findDep<AppColorsController>()
              .primaryColor
              .withOpacity(0.9),
        ),
    );
    // Get.snackbar('', '',
    //     snackPosition: SnackPosition.BOTTOM,
    //     duration: const Duration(seconds: 5),
    //     borderRadius: ScreenHelper.fromWidth55(0.5),
    //     animationDuration: const Duration(seconds: 1),
    //     backgroundColor:
    //         DIManager.findDep<AppColorsController>()
    //             .primaryColor
    //             .withOpacity(0.9),
    //     isDismissible: false,
    //
    //     messageText: Row(
    //       children: [
    //         Expanded(
    //           child: Padding(
    //             padding: EdgeInsets.symmetric(
    //                 vertical: ScreenHelper.fromHeight55(1.0)),
    //             child: Text(
    //               message,
    //               maxLines: 2,
    //               style: TextStyle(color: Colors.white),
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //     margin: EdgeInsets.symmetric());
  }

  static showErrorSnackbar(BaseError error) {
    Get.snackbar(
      translate('error'),
      'message',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 5),
      animationDuration: Duration(seconds: 1),
      backgroundColor: Colors.red,
      isDismissible: false,
      titleText: Text(
        translate('error'),
        style:
            TextStyle(color: Colors.grey.shade300, fontWeight: FontWeight.bold),
      ),
      messageText: Row(
        children: [
          Expanded(
            child: Text(
              error.message ?? '',
              maxLines: 2,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      margin: EdgeInsets.symmetric(),
    );
  }


  static showNormalSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            maxLines: 2,
            style: const TextStyle(color: Colors.white),
          ),
          duration: const Duration(seconds: 5),
          backgroundColor: DIManager.findDep<AppColorsController>()
              .primaryColor
              .withOpacity(0.9),
        )
    );
  }
}
