import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/constants/app_assets.dart';
import 'package:wadeema/core/utils/ui/widgets/images/svg_image_asset.dart';

import '../../../../core/constants/app_consts.dart';
import '../../../../core/constants/dimens.dart';

class ImageProfileWidget extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;

  const ImageProfileWidget({Key? key, this.url, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: (url != null && url.toString() != "null" && url!.isNotEmpty)
          ? Image.network(
              AppConsts.IMAGE_URL + url!,
              fit: BoxFit.fill,
              height: height ?? 80.sp,
              width: width ?? 80.sp,
            )
          : SvgImageAsset(
              AppAssets.accountIcons,
              fit: BoxFit.fill,
              height: height ?? 80.sp,
              width: width ?? 80.sp,
            ),
      borderRadius: BorderRadius.all(
        Radius.circular(100),
      ),
    );
  }
}
