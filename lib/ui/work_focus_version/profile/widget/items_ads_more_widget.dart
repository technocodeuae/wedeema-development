import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/ui/work_focus_version/home/widget/job_ad_card.dart';

import '../../../../blocs/categories/categories_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../data/models/ads/entity/ads_entity.dart';
import '../../home/arg/items_args.dart';
import '../../home/pages/items_details_page.dart';
import '../../home/widget/home_items_widget.dart';
class ItemsAdsMoreWidget extends StatefulWidget {
  final List<ItemsAdsEntity>? items;
  final String? title;
  const ItemsAdsMoreWidget({Key? key,this.title,this.items}) : super(key: key);

  @override
  State<ItemsAdsMoreWidget> createState() => _ItemsAdsMoreWidgetState();
}

class _ItemsAdsMoreWidgetState extends State<ItemsAdsMoreWidget> {
  final categoriesBloc = DIManager.findDep<CategoriesCubit>();

  @override
  Widget build(BuildContext context) {
    return   Column(
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
                widget.title.toString(),
                style: AppStyle.lightSubtitle.copyWith(
                  color: AppColorsController().textPrimaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.5
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              (widget.items?.length!)! > 0? Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 195.sp,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      if (categoriesBloc.isJobs(widget.items?[index].category_title ?? '')) {
                        return JobAdCard(
                          width: MediaQuery.sizeOf(context).width * 0.85,
                          data: widget.items?[index],
                          onPress: () {
                            DIManager.findNavigator().pushNamed(
                              ItemsDetailsPage.routeName,
                              arguments: ItemsArgs(id: widget.items?[index].ad_id ?? 0),
                            );
                          },
                        );
                      }
                      return HomeItemsWidget(
                        onPress: () {
                          DIManager.findNavigator().pushNamed(
                              ItemsDetailsPage.routeName,
                              arguments: ItemsArgs(
                                  id: widget.items![index]!.ad_id
                              )
                          );
                        },
                        data: widget.items![index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 22.sp,
                      );
                    },
                    itemCount: widget.items!.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ):Container(),
            ],
          ),
        ),
        SizedBox(height: 8.sp,),
      ],
    );
  }
}
