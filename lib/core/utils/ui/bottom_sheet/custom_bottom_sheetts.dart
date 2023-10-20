import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/di_manager.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/string_utils/string_utils.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';

enum ImageTypeEnum {
  GALLERY,
  CAMERA,
}

class CustomBottomSheets {
  static const String routeName = 'CustomBottomSheets/bottom_sheet';

  static void showPickImageCameraGalleryBottomSheet({
    Key? key,
    required void Function(ImageTypeEnum) onChooseWay,
  }) {
    Get.bottomSheet(
      Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                // onTap: () {},
                // leading: Icon(
                //   Icons.camera,
                //   size: 0.08.sw,
                // ),
                title: Text(
                  translate('pick_an_image').toTitleCase(),
                  style: AppStyle.titleStyle.copyWith(
                    fontWeight: AppFontWeight.bold,
                    color: DIManager.findCC().primaryColor,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  onChooseWay(ImageTypeEnum.GALLERY);
                  DIManager.findNavigator().pop();
                },
                leading: Icon(
                  Icons.camera,
                  size: 0.08.sw,
                  color: DIManager.findCC().primaryColor,
                ),
                title: Text(
                  translate('gallery'),
                  style: AppStyle.smallTitleStyle.copyWith(
                    fontWeight: AppFontWeight.semiBold,
                    color: DIManager.findCC().black,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  onChooseWay(ImageTypeEnum.CAMERA);
                  DIManager.findNavigator().pop();
                },
                leading: Icon(
                  Icons.camera_alt_outlined,
                  size: 0.08.sw,
                  color: DIManager.findCC().primaryColor,
                ),
                title: Text(
                  translate('camera'),
                  style: AppStyle.smallTitleStyle.copyWith(
                    fontWeight: AppFontWeight.semiBold,
                    color: DIManager.findCC().black,
                  ),
                ),
              ),
              SizedBox(height: 8.w),
            ],
          ),
        ),
      ),
      settings: RouteSettings(name: CustomBottomSheets.routeName),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            Dimens.bottomSheetBorderRadius,
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

}
