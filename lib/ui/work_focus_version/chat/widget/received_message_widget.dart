import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_consts.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../data/models/messages/entity/messages_entity.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

import '../../home/widget/home_items_favourite.dart';
import '../../pdf/download_pdf_widget.dart';

class ReceivedMessageWidget extends StatelessWidget {
  final MessagesEntity? data;

  const ReceivedMessageWidget({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Container(
    //       padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
    //       // width: 20,
    //       decoration: BoxDecoration(
    //           color: AppColorsController().buttonRedColor,
    //           border: Border.all(
    //             color: AppColorsController().borderColor,
    //             width: 0.2,
    //           ),
    //           borderRadius:
    //               BorderRadius.all(Radius.circular(Dimens.bigBorderRadius))),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //
    //           data?.type == "text"
    //               ? Text(
    //                   data!.message.toString(),
    //                   style: AppStyle.defaultStyle.copyWith(
    //                     color: AppColorsController().white,
    //                     fontWeight: FontWeight.w400,
    //                   ),
    //                   maxLines: 2,
    //                   overflow: TextOverflow.ellipsis,
    //                 )
    //               : data?.type == "image"
    //                   ? Container(
    //                       height: 60.sp,
    //                       width: 120.sp,
    //                       child: Image.network(
    //                         AppConsts.IMAGE_URL + "/" +data!.filepath.toString(),
    //                       ),
    //                     )
    //                   : DownloadPdfWidget(
    //                   url: data!.filepath!,
    //             name: data!.filename!,
    //           ),
    //         ],
    //       ),
    //     ),
    //     SizedBox(
    //       width: 8.sp,
    //     ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         Container(),
    //         Text(
    //           data!.created_at != null
    //               ? getComparedTime(data!.created_at!).toString()!
    //               : "",
    //           style: AppStyle.lightSubtitle.copyWith(
    //             color: AppColorsController().greyTextColor,
    //             fontWeight: FontWeight.w400,
    //           ),
    //         ),
    //       ],
    //     ),
    //     // Flexible(
    //     //   flex: 1,
    //     //   child: ClipRRect(
    //     //     child: (data?.ad_img != null )
    //     //         ? Image.network(
    //     //             AppConsts.IMAGE_URL + data!.ad_img.toString(),
    //     //             fit: BoxFit.fill,
    //     //             height: 25.sp,
    //     //             width: 25.sp,
    //     //           )
    //     //         : AccountIcon(
    //     //             height: 25.sp,
    //     //             width: 25.sp,
    //     //           ),
    //     //     borderRadius:
    //     //         BorderRadius.all(Radius.circular(Dimens.defaultBorderRadius)),
    //     //   ),
    //     // ),
    //   ],
    // );

    return  ChatBubble(
      clipper: ChatBubbleClipper9(type: BubbleType.receiverBubble),
      // alignment: Alignment.topRight,
      // margin: EdgeInsets.only(top: 20),

      backGroundColor: AppColorsController().buttonRedColor,
      child: data?.type == "text"
          ? Text(
        // "Ut enim nia laborisasdasasdsaaaasas nisi ut aliquip ex ea commodo consequat",
        data!.message.toString(),
        style: AppStyle.defaultStyle.copyWith(
          color: AppColorsController().white,
          fontWeight: FontWeight.w400,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      )
          : data?.type == "image"
          ? Container(
        height: 60.sp,
        width: 120.sp,
        child: Image.network(
          AppConsts.IMAGE_URL + "/" +data!.filepath.toString(),
        ),
      )
          : DownloadPdfWidget(
        url: data!.filepath!,
        name: data!.filename!,
      ),
    );
  }
}
