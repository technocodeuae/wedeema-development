import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/constants/app_font.dart';
import 'package:wadeema/data/models/messages_firebase/ads_chats_model.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_consts.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../data/models/messages/entity/messages_entity.dart';
import '../../general/icons/account_icon.dart';
import '../../home/widget/home_items_widget.dart';
import '../../pdf/download_pdf_widget.dart';

class MainPageChat extends StatelessWidget {
  final MessagesEntity? data;
  final AdsChatsModel? adsData;

  const MainPageChat({Key? key, this.data,this.adsData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('0000000549068439085438598342905890348538409438058049845398435904395034859084398504830543509345');
    print(adsData?.imageAds);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IconButton(onPressed: (){
          //   print(data);
          // }, icon: Icon(Icons.abc)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: (adsData?.imageAds != null )
                    ? Image.network(
                        AppConsts.IMAGE_URL + adsData!.imageAds.toString(),
                        // AppConsts.IMAGE_URL + '/img/ad/1698142488797.jpg',
                        fit: BoxFit.fill,
                        height: 50.sp,
                        width: 50.sp,
                      )
                    : AccountIcon(
                        height: 50.sp,
                        width: 50.sp,
                      ),
                borderRadius:
                    BorderRadius.all(Radius.circular(40.sp)),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    adsData!.nameAds.toString() ,
                    style: AppStyle.defaultStyle.copyWith(
                        color: AppColorsController().black,
                        fontWeight: FontWeight.w400,
                        fontSize: AppFontSize.fontSize_14
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    adsData!.ad_id.toString() ,
                    style: AppStyle.defaultStyle.copyWith(
                        color: AppColorsController().black,
                        fontWeight: FontWeight.w400,
                        fontSize: AppFontSize.fontSize_12
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Spacer(),
              Text(
                adsData!.dateTime != null
                    ?  getComparedTime(DateTime.parse(adsData!.dateTime.toString())).toString()
                    : "",
                style: AppStyle.lightSubtitle.copyWith(
                  color: AppColorsController().greyTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
SizedBox(height: 10.sp,),
          // Padding(
          //   padding: EdgeInsets.only(right: 20.sp),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //
          //       // data?.type == "text"
          //       //     ?
          //       Container(width: 200.sp,
          //             child: Text(
          //                 data!.user_id_2.toString(),
          //                 // 'data!.message.toString()data!.message.toString()data!.message.toString()data!.message.toString()data!.message.toString()data!.message.toString()',
          //                 style: AppStyle.defaultStyle.copyWith(
          //                   color: AppColorsController().greyTextColor,
          //                   fontWeight: FontWeight.w400,
          //                   fontSize: AppFontSize.fontSize_12
          //                 ),
          //                 maxLines: 1,
          //                 overflow: TextOverflow.ellipsis,
          //               ),
          //           )
          //       //     :
          //       //
          //       // data?.type == "image"
          //       //         ?
          //       // Container(
          //       //             height: 30.sp,
          //       //             width: 60.sp,
          //       //             child: Image.network(
          //       //               AppConsts.IMAGE_URL +
          //       //                   "/" +
          //       //                   data!.filepath.toString(),
          //       //             ),
          //       //           )
          //       //         :
          //       //
          //       // DownloadPdfWidget(
          //       //             url: data!.filepath!,
          //       //             name: data!.filename!,
          //       //           ),
          //
          //     ],
          //   ),
          // ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: 1.h,
          //   color: AppColorsController().buttonRedColor.withOpacity(0.2),
          // ),
        ],
      ),
    );
  }
}

// DateTime.parse(adsData!.dateTime.toString()).toString()

//getComparedTime(data!.created_at!).toString()!

/*

Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IconButton(onPressed: (){
          //   print(data);
          // }, icon: Icon(Icons.abc)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: (data?.ad_img != null && data!.ad_img!.isNotEmpty)
                    ? Image.network(
                        AppConsts.IMAGE_URL + data!.ad_img.toString(),
                        fit: BoxFit.fill,
                        height: 50.sp,
                        width: 50.sp,
                      )
                    : AccountIcon(
                        height: 50.sp,
                        width: 50.sp,
                      ),
                borderRadius:
                    BorderRadius.all(Radius.circular(40.sp)),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data!.ad_name.toString() ,
                    style: AppStyle.defaultStyle.copyWith(
                        color: AppColorsController().black,
                        fontWeight: FontWeight.w400,
                        fontSize: AppFontSize.fontSize_14
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    data!.user_name_2.toString() ,
                    style: AppStyle.defaultStyle.copyWith(
                        color: AppColorsController().black,
                        fontWeight: FontWeight.w400,
                        fontSize: AppFontSize.fontSize_12
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Spacer(),
              Text(
                data!.created_at != null
                    ? getComparedTime(data!.created_at!).toString()!
                    : "",
                style: AppStyle.lightSubtitle.copyWith(
                  color: AppColorsController().greyTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
SizedBox(height: 10.sp,),
          Padding(
            padding: EdgeInsets.only(right: 20.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                data?.type == "text"
                    ? Container(width: 200.sp,
                      child: Text(
                          data!.user_id_2.toString(),
                          // 'data!.message.toString()data!.message.toString()data!.message.toString()data!.message.toString()data!.message.toString()data!.message.toString()',
                          style: AppStyle.defaultStyle.copyWith(
                            color: AppColorsController().greyTextColor,
                            fontWeight: FontWeight.w400,
                            fontSize: AppFontSize.fontSize_12
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    )
                    :

                data?.type == "image"
                        ?
                Container(
                            height: 30.sp,
                            width: 60.sp,
                            child: Image.network(
                              AppConsts.IMAGE_URL +
                                  "/" +
                                  data!.filepath.toString(),
                            ),
                          )
                        :

                DownloadPdfWidget(
                            url: data!.filepath!,
                            name: data!.filename!,
                          ),

              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1.h,
            color: AppColorsController().buttonRedColor.withOpacity(0.2),
          ),
        ],
      ),
    );

 */