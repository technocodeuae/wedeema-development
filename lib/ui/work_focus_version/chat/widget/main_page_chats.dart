import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/core/constants/app_font.dart';
import 'package:wadeema/data/models/messages_firebase/ads_chats_model.dart';

import '../../../../blocs/chat_firebase/states/chat_state_firebase.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_consts.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../data/models/messages/entity/messages_entity.dart';
import '../../general/icons/account_icon.dart';
import '../../home/widget/home_items_widget.dart';
import '../../pdf/download_pdf_widget.dart';
import 'package:wadeema/core/di/di_manager.dart';
import 'package:wadeema/blocs/chat_firebase/chat_bloc_firebase.dart';

class MainPageChat extends StatefulWidget {
  final MessagesEntity? data;
  final AdsChatsModel? adsData;
  final String? index;

  MainPageChat({Key? key, this.data, this.adsData,this.index}) : super(key: key);

  @override
  State<MainPageChat> createState() => _MainPageChatState();
}

final chatBlocFirebase = DIManager.findDep<ChatCubitFirebase>();

class _MainPageChatState extends State<MainPageChat> {
  // final chatBlocFirebase = DIManager.findDep<ChatCubitFirebase>();
  //
  // @override
  // void initState() {
  //   super.initState();
  //   chatBlocFirebase; // قد تحتاج لتكوين ChatCubitFirebase بطريقة أخرى
  //   fetchMessages();
  //   // chatBlocFirebase.getAllAdsChats(
  //   //     user_id: DIManager.findDep<SharedPrefs>().getUserID().toString()
  //   // );
  // }
  //
  // void fetchMessages() {
  //   chatBlocFirebase.getMessages(
  //     user_id: DIManager.findDep<SharedPrefs>().getUserID(),
  //     ad_id: widget.adsData!.ad_id.toString(),
  //     user_id_2: widget.adsData!.user_id_2.toString() ==
  //             DIManager.findDep<SharedPrefs>().getUserID().toString()
  //         ? widget.adsData!.user_id.toString()
  //         : widget.adsData!.user_id_2.toString(),
  //     receiverId: widget.adsData!.user_id_2.toString() ==
  //             DIManager.findDep<SharedPrefs>().getUserID().toString()
  //         ? widget.adsData!.user_id.toString()
  //         : widget.adsData!.user_id_2.toString(),
  //
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    print(
        '0000000549068439085438598342905890348538409438058049845398435904395034859084398504830543509345');
    print(widget.adsData?.imageAds);
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
                child: (widget.adsData?.imageAds != null)
                    ? Image.network(
                        AppConsts.IMAGE_URL +
                            widget.adsData!.imageAds.toString(),
                        // AppConsts.IMAGE_URL + '/img/ad/1698142488797.jpg',
                        fit: BoxFit.fill,
                        height: 50.sp,
                        width: 50.sp,
                        errorBuilder: (context, error, stackTrace) {
                          return Container();
                        },
                      )
                    : AccountIcon(
                        height: 50.sp,
                        width: 50.sp,
                      ),
                borderRadius: BorderRadius.all(Radius.circular(40.sp)),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 220.w,
                    child: Text(
                      widget.adsData!.nameAds.toString(),
                      style: AppStyle.defaultStyle.copyWith(
                          color: AppColorsController().black,
                          fontWeight: FontWeight.w400,
                          fontSize: AppFontSize.fontSize_14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    width: 150.sp,
                    child: Container(
                      height: 25.sp,
                      width: 20.sp,
                      child: Text(
                        // chatBlocFirebase.messages.last.text.toString() ?? '',
                        // chatBlocFirebase.lastMessages ?? '',
                        widget.adsData!.massage?? '',
                        style: AppStyle.defaultStyle.copyWith(
                          color: AppColorsController().red,
                          fontWeight: FontWeight.w400,
                          fontSize: AppFontSize.fontSize_12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )

//                   Container(
//                     width: 150.sp,
//                     child: Builder(builder: (context) {
// print(widget.adsData!.ad_id.toString());
//                       // chatBlocFirebase.getMessages(
//                       //   user_id: DIManager.findDep<SharedPrefs>().getUserID(),
//                       //   ad_id: widget.adsData!.ad_id.toString(),
//                       //   user_id_2: widget.adsData!.user_id_2.toString() ==
//                       //       DIManager.findDep<SharedPrefs>().getUserID().toString()
//                       //       ? widget.adsData!.user_id.toString()
//                       //       : widget.adsData!.user_id_2.toString(),
//                       //   receiverId: widget.adsData!.user_id_2.toString() ==
//                       //       DIManager.findDep<SharedPrefs>().getUserID().toString()
//                       //       ? widget.adsData!.user_id.toString()
//                       //       : widget.adsData!.user_id_2.toString(),
//                       // );
//                       return BlocConsumer<ChatCubitFirebase, ChatStateFirebase>(
//                         bloc: chatBlocFirebase,
//                         listener: (context, state) {
//
//                         },
//                         builder: (context, state) {
//                           // DateTime timeMessage = DateTime.parse(chatBlocFirebase.messages.last.dateTime.toString());
//                           // DateTime timeMessage2 = DateTime.parse(chatBlocFirebase.messages.last.dateTime.toString());
//                           // String _dateTimeNow = DateFormat.yMMMMd().format(timeMessage);
//                           // bool shouldBreak = false;
//                           return  chatBlocFirebase.messages.isEmpty ?Container(): Container(
//                             height: 25.sp,
//                             width: 20.sp,
//                             child:
//                             Text(
//                               chatBlocFirebase.messages.last.text ??'',
//                               style: AppStyle.defaultStyle.copyWith(
//                                   color: AppColorsController().red,
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: AppFontSize.fontSize_12
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//
//                             // child: Text(chatBlocFirebase.messages.last.text ??''),
//                           );
//                         },
//                       );
//                     })
//
//
//
//
//                   ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    widget.adsData!.dateTime != null
                        ? getComparedTime(DateTime.parse(
                                widget.adsData!.dateTime.toString()))
                            .toString()
                        : "",
                    style: AppStyle.lightSubtitle.copyWith(
                      color: AppColorsController().greyTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        chatBlocFirebase.deleteChat(
                          user_id: DIManager.findDep<SharedPrefs>().getUserID(),
                          ad_id: widget.adsData!.ad_id!.toString(),
                          user_id_2: widget.adsData!.user_id_2.toString() ==
                                  DIManager.findDep<SharedPrefs>()
                                      .getUserID()
                                      .toString()
                              ? widget.adsData!.user_id.toString()
                              : widget.adsData!.user_id_2.toString(),
                          receiverId: widget.adsData!.user_id_2.toString(),
                        );
                      },
                      icon: Icon(Icons.delete)),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10.sp,
          ),
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
