import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../data/models/ads/entity/ads_entity.dart';
import '../../../../data/models/profile/entity/profile_entity.dart';
import '../../home/widget/build_circular_image_user.dart';
import '../args/other_args.dart';
import '../pages/client_account_page.dart';
class ItemsUserMoreWidget extends StatelessWidget {
  final List<ItemsUserEntity>? items;
  final String? title;
  const ItemsUserMoreWidget({Key? key,this.title,this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColorsController().containerPrimaryColor,
            border: Border.all(
              color: AppColorsController().borderColor,
              width: 0.2,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                Dimens.containerBorderRadius,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 18.sp),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.toString(),
                style: AppStyle.lightSubtitle.copyWith(
                  color: AppColorsController().textPrimaryColor,
                  fontWeight: FontWeight.w400,  fontSize: 14.5
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              ListView.separated(
                itemCount: items!.length,
                shrinkWrap: true,
                // this is important to make the ListView scrollable inside the column

                physics: NeverScrollableScrollPhysics(),

                itemBuilder: (context, index) {

                  return InkWell(
                    onTap: (){
                      DIManager.findNavigator().pushNamed(
                        ClientAccountPage.routeName,
                        arguments:  items![index].id,
                      );
                      print(items![index].company_name.toString());
                    },
                    child: Container(
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BuildCircularImageUser(
                            url: items![index].profile_pic,
                            size: 38.sp,
                          ),
                          SizedBox(width: 8.sp,),
                          Text(
                            // items![index].first_name.toString() + " " + items![index].last_name.toString(),
                            items![index].user_name.toString() ,
                            style: AppStyle.lightSubtitle.copyWith(
                              color: AppColorsController().black,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );},
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 8.sp,
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 8.sp,),
      ],
    );
  }
}
