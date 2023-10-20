import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_consts.dart';
import '../../../../core/di/di_manager.dart';
import '../../general/icons/account_icon.dart';
import '../../profile/args/other_args.dart';
import '../../profile/pages/client_account_page.dart';
class BuildCircularImageUser extends StatelessWidget {
  final double? size;
  final String? url;
  final int? id;
  const BuildCircularImageUser({Key? key, this.size,this.url,this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(id != null)
        DIManager.findNavigator().pushNamed(
          ClientAccountPage.routeName,
            arguments:id
        );
      },
      child:url!=null && url!.isNotEmpty? ClipOval(
        child: Image.network(
          AppConsts.IMAGE_URL+url!,
          width: size??32.sp,
          height: size??32.sp,
          fit: BoxFit.fill,
        ),):AccountIcon(
        height: size??32.sp,
        width: size??32.sp,
      ),
    );
  }
}
