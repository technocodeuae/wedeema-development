import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../blocs/application/application_bloc.dart';
import '../../../../blocs/chat/chat_bloc.dart';
import '../../../../blocs/chat/states/chat_state.dart';
import '../../../../blocs/notifications/notifications_bloc.dart';
import '../../../../blocs/notifications/states/notifications_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
import '../../../../data/models/messages/entity/messages_entity.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/icons/back_icon.dart';
import '../../general/icons/send_message.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
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

class _ChatMessagesPageState extends State<ChatMessagesPage>  with WidgetsBindingObserver{
  final chatBloc = DIManager.findDep<ChatCubit>();

  bool isLoading = true;

  List<MessagesEntity> data = [];

  List<File> files = [];
  Timer? _timer;

  TextEditingController controller = TextEditingController();

  String value = "";
  bool  _isLoading = false;

  @override
  void initState() {
    //startApiRequest();

    _isLoading = true;

    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      // Code to send message goes here
      _makeApiRequest();
      print('Message sent at ${DateTime.now()}');
    });
    WidgetsBinding.instance?.addObserver(this);

  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance?.removeObserver(this);

    super.dispose();
  }

  void startApiRequest(AppLifecycleState state) {

    if (state == AppLifecycleState.paused) {
      _timer?.cancel();
    } else if (state == AppLifecycleState.resumed) {

      const fiveSec = const Duration(seconds: 5);
      _timer =  Timer.periodic(fiveSec, (Timer t) => _makeApiRequest());
    }
  }

  void _makeApiRequest() async {
    if(isLoading == true) {
      await chatBloc.getChatMessages(widget.data!.user_id_2!);
    }
  }

  Future<void> loadImages() async {
    final picker = ImagePicker(
    );
   // List<XFile>? result = await picker.pickMultiImage();


    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      allowCompression: true,
    );

    if (result != null) {
      files.clear();

      for (PlatformFile platformFile in result.files) {
        print("path:" +platformFile.path.toString() );
        final File file = File(platformFile.path.toString());
        files.add(file);
      }

      setState(() {
        _isLoading = true;
      });

      await chatBloc.sendMassage(ArgumentMessage(
          message: controller.text.toString(),
          user_id_2: widget?.data!.user_id_2,
          ad_id: widget?.data!.ad_id,
          files: files));
      value = "";
      controller.text = "";
      files = [];
    }


  }


  Future<void> loadFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowCompression: true,
        allowedExtensions: ['txt', 'pdf'],
        allowMultiple: true,
      );

      if (result != null) {
        files.clear();

        for (PlatformFile platformFile in result.files) {
          final File file = File(platformFile.path.toString());
          files.add(file);
        }
      }
    } catch (e) {
      print(e);
    }

    setState(() {
      _isLoading = true;
    });
      await chatBloc.sendMassage(ArgumentMessage(
          message: controller.text.toString(),
          user_id_2: widget?.data!.user_id_2,
          ad_id: widget?.data!.ad_id,
          files: files));
      value = "";
      controller.text = "";
      files = [];
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsController().white,
      resizeToAvoidBottomInset:false,

      body: LoadingColumnOverlay(
      isLoading: _isLoading,
      child: BackLongPress(

        child: Column(
          children: [
            AppBarWidget(
              name: translate("chat"),
              flip: true,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isLoading = false;
                    data.clear();
                  });
                  DIManager.findNavigator().pop();
                },
                child: BackIcon(
                  width: 26.sp,
                  height: 18.sp,
                ),
              ),
            ),
            Flexible(
              child: ListView(
                children: [
                  BlocConsumer<ChatCubit, ChatState>(
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
                  SizedBox(
                    height: 70.sp,
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
      ),
      bottomSheet: Container(
        height: 48.sp,
        margin: EdgeInsets.symmetric(horizontal: 32.sp, vertical: 12.sp)
            .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 280.sp,
              padding: EdgeInsets.symmetric(vertical: 8.sp,horizontal: 12.sp),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColorsController().borderColor,
                  width: 0.2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimens.containerBorderRadius),
                ),
                color: AppColorsController().containerPrimaryColor,
              ),
              child: Row(
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
            ),
            Container(
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColorsController().borderColor,
                  width: 0.2,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimens.containerBorderRadius),
                ),
                color: AppColorsController().containerPrimaryColor,
              ),
              child: GestureDetector(
                onTap: () async {
                  if (controller.text.isNotEmpty) {
                    await chatBloc.sendMassage(
                      ArgumentMessage(
                          message: controller.text.toString(),
                          user_id_2: widget?.data!.user_id_2,
                          ad_id: widget?.data!.ad_id,
                          files: files),
                    );
                    value = "";
                    controller.text = "";
                  }
                },
                child: SendMessageIcon(
                  width: 29.sp,
                  height: 25.sp,
                    color:AppColorsController().iconColor
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildBody() {
    return ListView.separated( physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
            margin: EdgeInsets.symmetric(horizontal: 22.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
        itemCount: data.length);
  }
}
