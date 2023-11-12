import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wadeema/blocs/chat_firebase/states/chat_state_firebase.dart';
import 'package:wadeema/core/constants/app_consts.dart';
import 'package:wadeema/ui/work_focus_version/general/icons/account_icon.dart';

import '../../../../blocs/application/application_bloc.dart';
import '../../../../blocs/chat/chat_bloc.dart';
import '../../../../blocs/chat/states/chat_state.dart';
import '../../../../blocs/chat_firebase/chat_bloc_firebase.dart';
import '../../../../blocs/notifications/notifications_bloc.dart';
import '../../../../blocs/notifications/states/notifications_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
import '../../../../data/models/messages/entity/messages_entity.dart';
import '../../../../data/models/messages_firebase/ads_chats_model.dart';
import '../../../../data/models/messages_firebase/messages_model_new.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/icons/back_icon.dart';
import '../../general/icons/send_message.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../../home/arg/items_args.dart';
import '../../home/pages/items_details_page.dart';
import '../../home/widget/home_items_favourite.dart';
import '../args/argument_message.dart';
import '../widget/received_message_widget.dart';
import '../widget/sender_message_widget.dart';

class ChatMessagesPage extends StatefulWidget {
  final ArgumentMessage? data;
  static const routeName = '/ChatMessagesPage';

  const ChatMessagesPage({Key? key, this.data}) : super(key: key);

  @override
  State<ChatMessagesPage> createState() => _ChatMessagesPageState();
}

class _ChatMessagesPageState extends State<ChatMessagesPage>
    with WidgetsBindingObserver {
  final chatBloc = DIManager.findDep<ChatCubit>();
  final chatBlocFirebase = DIManager.findDep<ChatCubitFirebase>();

  bool isLoading = true;

  List<MessagesEntity> data = [];

  List<File> files = [];
  Timer? _timer;

  TextEditingController controller = TextEditingController();

  String value = "";
  bool _isLoading = false;



  // @override
  // void initState() {
  //   //startApiRequest();
  //
  //   _isLoading = true;
  //
  //   _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
  //     // Code to send message goes here
  //     _makeApiRequest();
  //     print('Message sent at ${DateTime.now()}Message sent at ${DateTime.now()}Message sent at ${DateTime.now()}Message sent at ${DateTime.now()}Message sent at ${DateTime.now()}Message sent at ${DateTime.now()}Message sent at ${DateTime.now()}Message sent at ${DateTime.now()}Message sent at ${DateTime.now()}');
  //     print('Message sent at ${DateTime.now()}');
  //   });
  //   WidgetsBinding.instance.addObserver(this);
  //   // _scrollController.animateTo(
  //   //   _scrollController.position.maxScrollExtent + 50.h,
  //   //   duration: Duration(seconds: 2), // قد تحتاج لضبط مدى الوقت حسب تفضيلاتك
  //   //   curve: Curves.easeOut,
  //   // );
  // }
  //
  // @override
  // void dispose() {
  //   _timer?.cancel();
  //   WidgetsBinding.instance?.removeObserver(this);
  //
  //   super.dispose();
  // }
  //
  // void startApiRequest(AppLifecycleState state) {
  //
  //   if (state == AppLifecycleState.paused) {
  //     _timer?.cancel();
  //   } else if (state == AppLifecycleState.resumed) {
  //
  //     const fiveSec = const Duration(seconds: 1);
  //     _timer =  Timer.periodic(fiveSec, (Timer t) => _makeApiRequest());
  //   }
  // }
  //
  // void _makeApiRequest() async {
  //   if(isLoading == true) {
  //     await chatBloc.getChatMessages(widget.data!.user_id_2!);
  //   }
  // }
  //
  // Future<void> loadImages() async {
  //   final picker = ImagePicker(
  //   );
  //  // List<XFile>? result = await picker.pickMultiImage();
  //
  //
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.image,
  //       allowMultiple: true,
  //     allowCompression: true,
  //   );
  //
  //   if (result != null) {
  //     files.clear();
  //
  //     for (PlatformFile platformFile in result.files) {
  //       print("path:" +platformFile.path.toString() );
  //       final File file = File(platformFile.path.toString());
  //       files.add(file);
  //     }
  //
  //     setState(() {
  //       _isLoading = true;
  //     });
  //
  //     await chatBloc.sendMassage(ArgumentMessage(
  //         message: controller.text.toString(),
  //         user_id_2: widget?.data!.user_id_2,
  //         ad_id: widget?.data!.ad_id,
  //         files: files));
  //     value = "";
  //     controller.text = "";
  //     files = [];
  //   }
  //
  //
  // }
  //
  //
  // Future<void> loadFiles() async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowCompression: true,
  //       allowedExtensions: ['txt', 'pdf'],
  //       allowMultiple: true,
  //     );
  //
  //     if (result != null) {
  //       files.clear();
  //
  //       for (PlatformFile platformFile in result.files) {
  //         final File file = File(platformFile.path.toString());
  //         files.add(file);
  //       }
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //
  //   setState(() {
  //     _isLoading = true;
  //   });
  //     await chatBloc.sendMassage(ArgumentMessage(
  //         message: controller.text.toString(),
  //         user_id_2: widget?.data!.user_id_2,
  //         ad_id: widget?.data!.ad_id,
  //         files: files));
  //     value = "";
  //     controller.text = "";
  //     files = [];
  // }

  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 3000);

  void move() {
    // _scrollController.initialScrollOffset.isNaN;
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 2),
      // قد تحتاج لضبط مدى الوقت حسب تفضيلاتك
      curve: Curves.easeOutBack,
    );
  }

  bool tapOnKeyboard = false;

  bool isLoadingChats= true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsController().white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColorsController().white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.appBarBackgroundImage),
                fit: BoxFit.fill),
          ),
        ),
        // centerTitle: true,
        elevation: 0,
        title: Column(
          children: [
            SizedBox(
              height: 25.h,
            ),
            Text(
              widget.data!.user_id_2.toString() ==
                      DIManager.findDep<SharedPrefs>().getUserID().toString()
                  ? '${widget.data!.user_name_person_sender!}'
                  : '${widget.data!.nameOwnerAds!}',
              style: AppStyle.smallTitleStyle.copyWith(
                color: AppColorsController().black,
                fontWeight: AppFontWeight.bold,
                fontSize: AppFontSize.fontSize_20,
              ),
              maxLines: 1,
            ),
          ],
        ),
        leading: Transform.scale(
          scale: 0.5,
          child: InkWell(
            onTap: () {
              // print(data[0]);
              // setState(() {
              //   isLoading = false;
              //   data.clear();
              // });
              DIManager.findNavigator().pop();
              // debugPrint(DIManager.findDep<SharedPrefs>().getToken());
// print(DIManager.findDep<SharedPrefs>().getToken());
            },
            child: BackIcon(
              width: 26.sp,
              height: 18.sp,
            ),
          ),
        ),
        iconTheme: IconThemeData(
          size: 20.0, // تحديد حجم الأيقونة في الـ leading
        ),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            // height: 60.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.sp),
              color: AppColorsController().card,
              border: Border.all(
                color: AppColorsController().borderColor,
                width: 0.2,
              ),
            ),
            child: InkWell(
              onTap: () {
                DIManager.findNavigator().pushNamed(
                    ItemsDetailsPage.routeName,
                    arguments: ItemsArgs(
                      id: widget.data?.ad_id,
                      // type: 'adsWithoutImage' ,
                      categoryId: widget.data?.adsIsJob == true ? 27:0,
                    ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10.w),
                    ClipRRect(
                      child: (widget.data?.imageAds != null)
                          ? widget.data?.imageAds == '/img/ad/default.png'?    Container(
                        width: 50.sp,
                        height: 50.sp,
                        child: SvgPicture.asset(
                          "assets/images/trace.svg",
                          width: 50.sp,
                          height: 50.sp, fit: BoxFit.fill,
                        ),
                      ):  Image.network(
                              AppConsts.IMAGE_URL +
                                  widget.data!.imageAds.toString(),
                              fit: BoxFit.fill,
                              height: 50.sp,
                              width: 50.sp, errorBuilder: (context, error, stackTrace) {
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
                    Text(
                      widget.data!.nameAds.toString(),
                      style: AppStyle.defaultStyle.copyWith(
                          color: AppColorsController().black,
                          fontWeight: FontWeight.w400,
                          fontSize: AppFontSize.fontSize_16),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Builder(builder: (context) {
              chatBlocFirebase.getMessages(
                ad_id: widget.data!.ad_id.toString(),
                receiverId: widget.data!.user_id_2.toString() ==
                        DIManager.findDep<SharedPrefs>().getUserID().toString()
                    ? widget.data!.user_id.toString()
                    : widget.data!.user_id_2.toString(),
              );
              return BlocConsumer<ChatCubitFirebase, ChatStateFirebase>(
                bloc: chatBlocFirebase,
                listener: (context, state) {

                  if(state is GetMessagesSuccessState){
                    move();

                  }


                },
                builder: (context, state) {
                 // DateTime timeMessage = DateTime.parse(chatBlocFirebase.messages.last.dateTime.toString());
                 // DateTime timeMessage2 = DateTime.parse(chatBlocFirebase.messages.last.dateTime.toString());
                 // String _dateTimeNow = DateFormat.yMMMMd().format(timeMessage);
                 // bool shouldBreak = false;
                  return Column(
                    children: [
                      // for(int i = 0 ;i<chatBlocFirebase.messages.length;i++)...[
                      //   Text(chatBlocFirebase.messages[i].text.toString(),style: TextStyle(color: Colors.black,fontSize: 25),),
                      // ],
                      // Text(chatBlocFirebase.messages[0].text.toString(),style: TextStyle(color: Colors.black,fontSize: 25),),
                      SizedBox(height: 10.h,),

                    // Container(
                    //   color: Colors.grey[300],
                    //   padding: EdgeInsets.symmetric(vertical: 8),
                    //   child: Text(
                    //     timeMessage.day.toString(),
                    //     style: TextStyle(fontSize: 12),
                    //   ),
                    // ),
                    //
                    //   if(chatBlocFirebase.messages.length !=0)...[
                    //     for(int i = chatBlocFirebase.messages.length+1; i>=chatBlocFirebase.messages.length;i--)...[
                    //       if (DateTime.parse(chatBlocFirebase.messages[i -2 ].dateTime.toString()).day == DateTime.now().day.toString())
                    //             () {
                    //           shouldBreak = true;
                    //           return Container(); // or any other widget
                    //         }(),
                    //
                    //       if(!shouldBreak)
                    //         Container(
                    //           color: Colors.grey[300],
                    //           padding: EdgeInsets.symmetric(vertical: 8),
                    //           child: Text(
                    //             chatBlocFirebase.messages[i-2].dateTime.toString(),
                    //             style: TextStyle(fontSize: 12),
                    //           ),
                    //         ),
                    //       // Container(
                    //       //   color: Colors.grey[300],
                    //       //   padding: EdgeInsets.symmetric(vertical: 8),
                    //       //   child: Text(
                    //       //     chatBlocFirebase.messages[i -2].text.toString(),
                    //       //     style: TextStyle(fontSize: 12),
                    //       //   ),
                    //       // ),
                    //
                    //     ],
                    //
                    //   ],
                    //
                    //
                    //   Container(
                    //     color: Colors.grey[300],
                    //     padding: EdgeInsets.symmetric(vertical: 8),
                    //     child: Text(
                    //       DateTime.now().day.toString(),
                    //       style: TextStyle(fontSize: 12),
                    //     ),
                    //   ),
                    //
                    //
                    //   Container(
                    //     color: Colors.grey[300],
                    //     padding: EdgeInsets.symmetric(vertical: 8),
                    //     child: Text(
                    //       _dateTimeNow.toString(),
                    //       style: TextStyle(fontSize: 12),
                    //     ),
                    //   ),



                      Expanded(
                        child: ListView.separated(
                          controller: _scrollController,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            // DIManager.findDep<SharedPrefs>().getUserID() ==
                            //     data[index].user_id_1.toString()
                            //     ?  SenderMessageWidget(data: data[index])
                            //     : ReceivedMessageWidget(data: data[index]);
                            //





                            if (chatBlocFirebase.messages[index].senderId ==
                                DIManager.findDep<SharedPrefs>()
                                    .getUserID()
                                    .toString())
                              return SenderMessageWidget(
                                  dataMessages:
                                      chatBlocFirebase.messages[index]);

                            return ReceivedMessageWidget(
                                dataMessages: chatBlocFirebase.messages[index]);


                          },
                          separatorBuilder: (context, state) => Container(),
                          itemCount: chatBlocFirebase.messages.length,
                        ),
                      ),
                      // Spacer(),

                      Container(
                        height: 0.4.h,
                        width: MediaQuery.of(context).size.width,
                        color: AppColorsController().borderColor,
                      ),
                      // TextFormField()
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 48.sp,
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.grey.withOpacity(0.2),
                          margin: EdgeInsets.symmetric(
                                  horizontal: 20.sp, vertical: 12.sp)
                              .copyWith(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom +
                                          16),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: controller,

                                  maxLength: null,
                                  style: AppStyle.tinySmallTitleStyle.copyWith(
                                      color:
                                          AppColorsController().naveTextColor,
                                      fontSize: AppFontSize.fontSize_13),
                                  minLines: 1,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: translate("enter_your_message"),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 4.sp, horizontal: 16.sp)),
                                  onChanged: (value) {
                                    value = value.toString();

                                    // final lines = value.split('\n');
                                    // // تحقق من عدد الأسطر وقم بتحويل السطر إذا كانت الحاجة موجودة
                                    // if (value.length == 5 || value.length == 10 || value.length == 15) {
                                    //  print('asdasdsadasddasddasddasddasddasddasddasd');
                                    //   controller.text += '\n';
                                    //  // value += '\n';
                                    //   // قم بتعيين النص بالأسطر الجديدة
                                    //  controller.selection = TextSelection.fromPosition(
                                    //    TextPosition(offset: value.length),
                                    //  );
                                    //
                                    // }
                                  },

                                ),
                              ),
                              Container(
                                width: 40.sp,
                                height: 40.sp,
                                child: InkWell(
                                    onTap: () {
                                      if (controller.text.isNotEmpty) {

                                        chatBlocFirebase
                                            .sendMassageFirebaseToFireStore(
                                                user_id: DIManager.findDep<SharedPrefs>()
                                                    .getUserID()
                                                    .toString(),
                                                user_id_2: widget.data!.user_id_2
                                                            .toString() ==
                                                        DIManager.findDep<SharedPrefs>()
                                                            .getUserID()
                                                            .toString()
                                                    ? widget.data!.user_id
                                                        .toString()
                                                    : widget.data!.user_id_2
                                                        .toString(),
                                                ad_id: widget.data!.ad_id
                                                    .toString(),
                                                dataMassageModel:
                                                    DataMassageModel(
                                                  text: controller.text
                                                      .toString(),
                                                  dateTime:
                                                      DateTime.now().toString(),
                                                  receiverId: widget
                                                              .data!.user_id_2
                                                              .toString() ==
                                                          DIManager.findDep<
                                                                  SharedPrefs>()
                                                              .getUserID()
                                                              .toString()
                                                      ? widget.data!.user_id
                                                          .toString()
                                                      : widget.data!.user_id_2
                                                          .toString(),
                                                  senderId: DIManager.findDep<
                                                          SharedPrefs>()
                                                      .getUserID()
                                                      .toString(),
                                                ),
                                                adsChatsModel: AdsChatsModel(
                                                    dateTime: DateTime.now()
                                                        .toString(),
                                                    ad_id: widget.data!.ad_id
                                                        .toString(),
                                                    imageAds: widget.data!.imageAds
                                                        .toString(),
                                                    nameAds: widget.data!.nameAds
                                                        .toString(),
                                                    nameOwnerAds: widget
                                                        .data!.nameOwnerAds
                                                        .toString(),
                                                    massage: controller.text
                                                        .toString(),
                                                    user_id: widget.data!.user_id
                                                        .toString(),
                                                    user_id_2: widget.data!.user_id_2.toString(),
                                                    userNamePersonSender: widget.data!.user_name_person_sender.toString()));
// print(chatBlocFirebase.messages[0].text.toString());
                                        // await chatBloc.sendMassage(
                                        //   ArgumentMessage(
                                        //       message: controller.text.toString(),
                                        //       user_id_2: widget.data!.user_id_2,
                                        //       ad_id: widget.data!.ad_id,
                                        //       files: files),
                                        // );
                                        value = "";
                                        controller.text = "";
                                        // Future.delayed(
                                        //         Duration(milliseconds: 500))
                                        //     .then((value) => move());
                                      }
                                    },
                                    child: Transform.rotate(
                                      angle: 90 * 3.141592653589793 / 90,
                                      // تحويل الزاوية من درجة إلى راديان
                                      child: Container(
                                        width: 40.sp,
                                        height: 40.sp,
                                        child: SendMessageIcon(
                                            width: 29.sp,
                                            height: 25.sp,
                                            color: AppColorsController()
                                                .iconColor),
                                      ), // استبدل بمسار صورتك
                                    )),
                              ),

                              /*
                                 Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      loadImages();
                                    },
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: AppColorsController().red,
                                      size: 24.sp,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      loadFiles();
                                    },
                                    child: Icon(
                                      Icons.attach_file_sharp,
                                      color: AppColorsController().red,
                                      size: 24.sp,
                                    ),
                                  ),

                                  Container(
                                    width: 200.sp,
                                    child: TextField(

                                      controller: controller,
                                      style: AppStyle.tinySmallTitleStyle.copyWith(
                                        color: AppColorsController().naveTextColor,
                                      ),
                                      minLines: 1,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: translate("enter_your_message"),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 4.sp, horizontal: 16.sp)),
                                      onChanged: (value) {
                                        value = value.toString();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                               */
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 300,
                      // ),
                    ],
                  );
                },
              );
            }),
          ),
        ],
      ),
      // bottomSheet: Container(
      //   height: 48.sp,
      //   margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 12.sp)
      //       .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + 16),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Container(
      //         width: 280.sp,
      //         padding: EdgeInsets.symmetric(vertical: 8.sp,horizontal: 12.sp),
      //         decoration: BoxDecoration(
      //           border: Border.all(
      //             color: AppColorsController().borderColor,
      //             width: 0.2,
      //           ),
      //           borderRadius: BorderRadius.all(
      //             Radius.circular(Dimens.containerBorderRadius),
      //           ),
      //           color: AppColorsController().containerPrimaryColor,
      //         ),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             InkWell(
      //               onTap: (){
      //                 loadImages();
      //               },
      //               child: Icon(
      //                 Icons.camera_alt_outlined,
      //                 color: AppColorsController().red,
      //                 size: 24.sp,
      //               ),
      //             ),
      //             InkWell(
      //               onTap: (){
      //                 loadFiles();
      //               },
      //               child: Icon(
      //                 Icons.attach_file_sharp,
      //                 color: AppColorsController().red,
      //                 size: 24.sp,
      //               ),
      //             ),
      //
      //             Container(
      //               width: 200.sp,
      //               child: TextField(
      //
      //                 controller: controller,
      //                 style: AppStyle.tinySmallTitleStyle.copyWith(
      //                   color: AppColorsController().naveTextColor,
      //                 ),
      //                 minLines: 1,
      //                 maxLines: null,
      //                 decoration: InputDecoration(
      //                     border: InputBorder.none,
      //                     hintText: translate("enter_your_message"),
      //                     contentPadding: EdgeInsets.symmetric(
      //                         vertical: 4.sp, horizontal: 16.sp)),
      //                 onChanged: (value) {
      //                   value = value.toString();
      //                 },
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         padding: EdgeInsets.all(12.sp),
      //         decoration: BoxDecoration(
      //           border: Border.all(
      //             color: AppColorsController().borderColor,
      //             width: 0.2,
      //           ),
      //           borderRadius: BorderRadius.all(
      //             Radius.circular(Dimens.containerBorderRadius),
      //           ),
      //           color: AppColorsController().containerPrimaryColor,
      //         ),
      //         child: GestureDetector(
      //           onTap: () async {
      //             if (controller.text.isNotEmpty) {
      //               await chatBloc.sendMassage(
      //                 ArgumentMessage(
      //                     message: controller.text.toString(),
      //                     user_id_2: widget?.data!.user_id_2,
      //                     ad_id: widget?.data!.ad_id,
      //                     files: files),
      //               );
      //               value = "";
      //               controller.text = "";
      //             }
      //           },
      //           child: SendMessageIcon(
      //             width: 29.sp,
      //             height: 25.sp,
      //               color:AppColorsController().iconColor
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }

/*

LoadingColumnOverlay(
      isLoading: _isLoading,
      child: BackLongPress(

        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                SizedBox(height: 12.h,),
                // AppBarWidget(
                //   name: translate(""),
                //             child: InkWell(
                //     onTap: () {
                //       setState(() {
                //         isLoading = false;
                //         data.clear();
                //       });
                //       DIManager.findNavigator().pop();
                //     },
                //     child: BackIcon(
                //       width: 26.sp,
                //       height: 18.sp,
                //     ),
                //   ),
                // ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60.h,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.sp),
                    color: AppColorsController().card,
                    border: Border.all(
                      color: AppColorsController().borderColor,
                      width: 0.2,
                    ),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          child: (widget.data?.imageAds != null )
                              ? Image.network(
                            AppConsts.IMAGE_URL + widget.data!.imageAds.toString(),
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
                        Text(
                          widget.data!.nameAds.toString() ,
                          style: AppStyle.defaultStyle.copyWith(
                              color: AppColorsController().black,
                              fontWeight: FontWeight.w400,
                              fontSize: AppFontSize.fontSize_16
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: BlocConsumer<ChatCubit, ChatState>(
                      bloc: chatBloc,
                      listener: (_, state) {
                        setState(() {
                          _isLoading = false;
                        });
                      },
                      builder: (context, state) {
                        final getChatMassageState = state.getChatMassageState;

                        if (getChatMassageState is BaseFailState) {
                          return Column(
                            children: [
                              VerticalPadding(3.0),
                            ],
                          );
                        }

                        if (getChatMassageState is GetChatMassageSuccessState) {
                          data = (state.getChatMassageState
                                  as GetChatMassageSuccessState)
                              .massages
                              .messages!;
                          return _buildBody();
                        }
                        return _buildBody();
                      }),
                ),
                // SizedBox(
                //   height: 100.sp,
                // ),
              ],
            ),
          // Container(
          //     height: 48.sp,width: MediaQuery.of(context).size.width,color: Colors.grey.withOpacity(0.2),
          //     margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 12.sp)
          //         .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + 16),
          //     child: Row(
          //
          //       children: [
          //         Expanded(
          //           child: TextField(
          //             controller: controller,
          //             style: AppStyle.tinySmallTitleStyle.copyWith(
          //               color: AppColorsController().naveTextColor,
          //             ),
          //             minLines: 1,
          //             maxLines: null,
          //             decoration: InputDecoration(
          //                 border: InputBorder.none,
          //                 hintText: translate("enter_your_message"),
          //                 contentPadding: EdgeInsets.symmetric(
          //                     vertical: 4.sp, horizontal: 16.sp)),
          //             onChanged: (value) {
          //               value = value.toString();
          //             },
          //           ),
          //         ),
          //         GestureDetector(
          //           onTap: () async {
          //             if (controller.text.isNotEmpty) {
          //               await chatBloc.sendMassage(
          //                 ArgumentMessage(
          //                     message: controller.text.toString(),
          //                     user_id_2: widget.data!.user_id_2,
          //                     ad_id: widget.data!.ad_id,
          //                     files: files),
          //               );
          //               value = "";
          //               controller.text = "";
          //             }
          //           },
          //             child:  Transform.rotate(
          //               angle: 90 * 3.141592653589793 / 90, // تحويل الزاوية من درجة إلى راديان
          //               child: SendMessageIcon(
          //                   width: 29.sp,
          //                   height: 25.sp,
          //                   color:AppColorsController().iconColor
          //               ), // استبدل بمسار صورتك
          //             )
          //
          //         ),
          //
          //
          //         /*
          //            Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             InkWell(
          //               onTap: (){
          //                 loadImages();
          //               },
          //               child: Icon(
          //                 Icons.camera_alt_outlined,
          //                 color: AppColorsController().red,
          //                 size: 24.sp,
          //               ),
          //             ),
          //             InkWell(
          //               onTap: (){
          //                 loadFiles();
          //               },
          //               child: Icon(
          //                 Icons.attach_file_sharp,
          //                 color: AppColorsController().red,
          //                 size: 24.sp,
          //               ),
          //             ),
          //
          //             Container(
          //               width: 200.sp,
          //               child: TextField(
          //
          //                 controller: controller,
          //                 style: AppStyle.tinySmallTitleStyle.copyWith(
          //                   color: AppColorsController().naveTextColor,
          //                 ),
          //                 minLines: 1,
          //                 maxLines: null,
          //                 decoration: InputDecoration(
          //                     border: InputBorder.none,
          //                     hintText: translate("enter_your_message"),
          //                     contentPadding: EdgeInsets.symmetric(
          //                         vertical: 4.sp, horizontal: 16.sp)),
          //                 onChanged: (value) {
          //                   value = value.toString();
          //                 },
          //               ),
          //             ),
          //           ],
          //         ),
          //          */
          //       ],
          //     ),
          //   ),
          ],
        ),
      ),
      )

 */

  _buildBody() {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.sp, vertical: 5.sp),
                  // margin: EdgeInsets.symmetric(horizontal: 22.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 10.sp),
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //                                  Row(
                      //         mainAxisAlignment: MainAxisAlignment.start,
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           ClipRRect(
                      //             child: (data?[index].ad_img != null && data[index].ad_img!.isNotEmpty)
                      //                 ? Image.network(
                      //               AppConsts.IMAGE_URL + data[index].ad_img.toString(),
                      //               fit: BoxFit.fill,
                      //               height: 50.sp,
                      //               width: 50.sp,
                      //             )
                      //                 : AccountIcon(
                      //               height: 50.sp,
                      //               width: 50.sp,
                      //             ),
                      //             borderRadius:
                      //             BorderRadius.all(Radius.circular(40.sp)),
                      //           ),
                      //           SizedBox(width: 10.w),
                      //           Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Text(
                      //                 data[index].ad_name.toString() ,
                      //                 style: AppStyle.defaultStyle.copyWith(
                      //                     color: AppColorsController().black,
                      //                     fontWeight: FontWeight.w400,
                      //                     fontSize: AppFontSize.fontSize_14
                      //                 ),
                      //                 maxLines: 2,
                      //                 overflow: TextOverflow.ellipsis,
                      //               ),
                      //               Text(
                      //                 data[index].ad_id.toString() ,
                      //                 style: AppStyle.defaultStyle.copyWith(
                      //                     color: AppColorsController().black,
                      //                     fontWeight: FontWeight.w400,
                      //                     fontSize: AppFontSize.fontSize_12
                      //                 ),
                      //                 maxLines: 2,
                      //                 overflow: TextOverflow.ellipsis,
                      //               ),
                      //             ],
                      //           ),
                      //           Spacer(),
                      //           Text(
                      //             data[index].created_at != null
                      //                 ? getComparedTime(data[index].created_at!).toString()!
                      //                 : "",
                      //             style: AppStyle.lightSubtitle.copyWith(
                      //               color: AppColorsController().greyTextColor,
                      //               fontWeight: FontWeight.w400,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //
                      //     ],
                      //   ),
                      // ),

                      DIManager.findDep<SharedPrefs>().getUserID() ==
                              data[index].user_id_1.toString()
                          ? SenderMessageWidget(data: data[index])
                          : ReceivedMessageWidget(data: data[index]),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 0.sp,
                );
              },
              itemCount: data.length),
        ),
        Container(
          height: 0.4.h,
          width: MediaQuery.of(context).size.width,
          color: AppColorsController().borderColor,
        ),
        Container(
          height: 48.sp, width: MediaQuery.of(context).size.width,
          // color: Colors.grey.withOpacity(0.2),
          margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 12.sp)
              .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + 16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  style: AppStyle.tinySmallTitleStyle.copyWith(
                      color: AppColorsController().naveTextColor,
                      fontSize: AppFontSize.fontSize_13),
                  minLines: 1,
                  maxLines: null,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: translate("enter_your_message"),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 4.sp, horizontal: 16.sp)),
                  onChanged: (value) {
                    value = value.toString();
                  },
                ),
              ),
              GestureDetector(
                  onTap: () async {
                    if (controller.text.isNotEmpty) {
                      await chatBloc.sendMassage(
                        ArgumentMessage(
                            message: controller.text.toString(),
                            user_id_2: widget.data!.user_id_2,
                            ad_id: widget.data!.ad_id,
                            files: files),
                      );
                      value = "";
                      controller.text = "";
                      Future.delayed(Duration(seconds: 1))
                          .then((value) => move());
                    }
                  },
                  child: Transform.rotate(
                    angle: 90 * 3.141592653589793 / 90,
                    // تحويل الزاوية من درجة إلى راديان
                    child: SendMessageIcon(
                        width: 29.sp,
                        height: 25.sp,
                        color: AppColorsController()
                            .iconColor), // استبدل بمسار صورتك
                  )),

              /*
                     Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){
                          loadImages();
                        },
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: AppColorsController().red,
                          size: 24.sp,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          loadFiles();
                        },
                        child: Icon(
                          Icons.attach_file_sharp,
                          color: AppColorsController().red,
                          size: 24.sp,
                        ),
                      ),

                      Container(
                        width: 200.sp,
                        child: TextField(

                          controller: controller,
                          style: AppStyle.tinySmallTitleStyle.copyWith(
                            color: AppColorsController().naveTextColor,
                          ),
                          minLines: 1,
                          maxLines: null,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: translate("enter_your_message"),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 4.sp, horizontal: 16.sp)),
                          onChanged: (value) {
                            value = value.toString();
                          },
                        ),
                      ),
                    ],
                  ),
                   */
            ],
          ),
        ),
      ],
    );
  }
}
