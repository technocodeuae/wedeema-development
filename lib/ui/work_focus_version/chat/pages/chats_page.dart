import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wadeema/blocs/chat_firebase/chat_bloc_firebase.dart';
import 'package:wadeema/blocs/chat_firebase/states/chat_state_firebase.dart';

import '../../../../blocs/application/application_bloc.dart';
import '../../../../blocs/chat/chat_bloc.dart';
import '../../../../blocs/chat/states/chat_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_font.dart';
import '../../../../core/constants/app_style.dart';
import '../../../../core/constants/dimens.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../../../core/utils/localization/app_localizations.dart';
import '../../../../core/utils/ui/widgets/general_error_widget.dart';
import '../../../../core/utils/ui/widgets/utils/vertical_padding.dart';
import '../../../../data/models/messages/entity/messages_entity.dart';
import '../../../../data/models/messages_firebase/ads_chats_model.dart';
import '../../../../data/models/messages_firebase/messages_model_new.dart';
import '../../../../data/sources/chat_firebase/chat_remote_data_source_firebase.dart';
import '../../general/app_bar/app_bar.dart';
import '../../general/back_long_press_widget.dart';
import '../../general/bottom_navigation_bar/bottom_navigation_bar_widget.dart';
import '../../general/icons/back_icon.dart';
import '../../general/progress_indicator/loading_column_overlay.dart';
import '../args/argument_message.dart';
import '../widget/main_page_chats.dart';
import 'chat_messages_page.dart';

class ChatsPage extends StatefulWidget {
  static const routeName = '/ChatPage';

  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  final chatBloc = DIManager.findDep<ChatCubit>();
  final chatBlocFirebase = DIManager.findDep<ChatCubitFirebase>();

  List<MessagesEntity> data = [];

  ChatRemoteDataSourceFirebaseImplFirebase
      chatRemoteDataSourceFirebaseImplFirebase =
      ChatRemoteDataSourceFirebaseImplFirebase();
  bool isLoading = false;
  bool _isLoading = false;

  @override
  void initState() {
    chatBloc.getAllChats();
    chatBlocFirebase.getAllAdsChats(
      user_id: DIManager.findDep<SharedPrefs>().getUserID().toString()
    );
    isLoading = true;
    _isLoading = true;
  }

  AdsChatsModel? adsChatsModel;

  late DataMassageModel dataMassageModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColorsController().card.withOpacity(0.8),
      backgroundColor: AppColorsController().white,
      appBar: AppBar(
        backgroundColor: AppColorsController().white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.appBarBackgroundImage),
                fit: BoxFit.fill),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        title: Text(
          translate('chat'),
          style: AppStyle.smallTitleStyle.copyWith(
            color: AppColorsController().black,
            fontWeight: AppFontWeight.midBold,
            fontSize: AppFontSize.fontSize_20,
          ),
          maxLines: 1,
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SafeArea(
            child: BlocConsumer<ChatCubitFirebase, ChatStateFirebase>(
              bloc: chatBlocFirebase,
              listener: (_, state) {
                if (state is GetAllAdsChatsLoadingState) {
                  isLoading = true;
                } else {
                  isLoading = false;
                }

                if (state is DeleteMessagesLoadingState) {
                  isLoading = true;
                } else {
                  isLoading = false;
                }
              },
              builder: (_, __) {
                return isLoading
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 20.sp,
                                height: 20.sp,
                                child: CircularProgressIndicator(
                                  color: AppColorsController().buttonRedColor,
                                  strokeWidth: 1.5,
                                )),
                            Spacer(),
                            Container()
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) => _buildBodyChats(
                            chatBlocFirebase.adsChatsModel[index]),
                        separatorBuilder: (context, index) => Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: Colors.grey,
                        ),
                        itemCount: chatBlocFirebase.adsChatsModel.length,
                      );
              },
            ),
          ),
          // isLoading?SizedBox(height: 500,):Container(),
          bottomNavigationBarWidget(indexPage: 1),
        ],
      ),
      // bottomSheet: bottomNavigationBarWidget(),
    );
  }

  // _buildBody() {
  //   return Expanded(
  //     child: ListView.separated(
  //         shrinkWrap: false,
  //         physics: NeverScrollableScrollPhysics(),
  //         itemBuilder: (context, index) {
  //           return InkWell(
  //             onTap: () {
  //               print(data[index].ad_id);
  //               print(data[index].user_id_2);
  //               if (DIManager.findDep<SharedPrefs>().getUserID() ==
  //                   data[index].user_id_1.toString()) {
  //                 print(
  //                     '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
  //               } else {
  //                 print(
  //                     '111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111');
  //               }
  //               DIManager.findNavigator().pushNamed(ChatMessagesPage.routeName,
  //                   arguments: ArgumentMessage(
  //                     user_id_2: data[index].user_id_2,
  //                     ad_id: data[index].ad_id,
  //                   ));
  //             },
  //             child: MainPageChat(
  //               data: data[index],
  //             ),
  //           );
  //         },
  //         separatorBuilder: (context, index) {
  //           return SizedBox(
  //             height: 8.sp,
  //           );
  //         },
  //         itemCount: data.length),
  //   );
  // }

  _buildBodyChats(AdsChatsModel data) {
    return InkWell(
        onTap: () {


          DIManager.findNavigator().pushNamed(ChatMessagesPage.routeName,
              arguments: ArgumentMessage(
                nameOwnerAds: data.nameOwnerAds,
                nameAds: data.nameAds,
                imageAds: data.imageAds,
                ad_id: int.parse(data.ad_id.toString()),
                user_id: data.user_id.toString(),
                // user_id_firebase: DIManager.findDep<SharedPrefs>().getUserID().toString(),
                user_id_2: int.parse(data.user_id_2.toString()),
                user_name_person_sender: data.userNamePersonSender,
              ));
        },
        child: MainPageChat(
          adsData: data,
        ));
  }
}

/*

LoadingColumnOverlay(
              isLoading: _isLoading,
              child: BackLongPress(
                child: Container(
                  child: Column(
                    children: [
                      AppBarWidget(
                        name: translate("chat"),
                        child: Container(
                          width: 26.sp,
                          height: 18.sp,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            // await FirebaseFirestore.instance
                            //     .collection('user')
                            //     .doc(
                            //     DIManager.findDep<SharedPrefs>().getToken())
                            //     .set({
                            //   "name": "aa",
                            //   "Token":
                            //   DIManager.findDep<SharedPrefs>().getToken()
                            // }).then((value) {
                            //   print('Sucsses');
                            // }).catchError((error) {
                            //   print(error.toString());
                            // });

                            // set my chats
                            // await FirebaseFirestore.instance
                            //     .collection('users')
                            //     .doc('user_id')
                            //     .collection('ads')
                            //     .doc('ad_id')
                            //     .collection('chats')
                            //     .doc('user_id_2')
                            //     .collection('messages')
                            //     .add({
                            //   'text':'text',
                            //   'senderId':'user_id',
                            //   'receiverId':'user_id_2',
                            //   'dateTime':'dateTime'
                            // })
                            //     .then((value) {})
                            //     .catchError((error) {
                            //       print(error);
                            //     });
                            //
                            // // set receiver chats
                            // await FirebaseFirestore.instance
                            //     .collection('users')
                            //     .doc('user_id_2')
                            //     .collection('ads')
                            //     .doc('ad_id')
                            //     .collection('chats')
                            //     .doc('user_id')
                            //     .collection('messages')
                            //     .add({
                            //   'text':'text',
                            //   'senderId':'user_id',
                            //   'receiverId':'user_id_2',
                            //   'dateTime':'dateTime'
                            // })
                            //     .then((value) {
                            //
                            // })
                            //     .catchError((error) {
                            //   print(error);
                            // });

                            chatBlocFirebase.sendMassageFirebaseToFireStore(
                              user_id: '1234',
                              user_id_2: '4321',
                              ad_id: '3',
                              dataMassageModel: DataMassageModel(
                                  text: 'hi',
                                  receiverId: '4321',
                                  senderId: '1234',
                                  dateTime: DateTime.now()),
                              adsChatsModel: AdsChatsModel(
                                  nameAds: 'سيازة ارمادا',
                                  ad_id: '3',
                                  imageAds: 'image/ar.png',
                                  dateTime: DateTime.now().toString()),
                            );
//
                          chatBlocFirebase.getAllAdsChats(
                                user_id: '1234') ;


                  // print(chatBlocFirebase.adsChatsModel?.ad_id);


//                             await FirebaseFirestore.instance
//                                 .collection('users')
//                                 .doc('1234')
//                                 .collection('ads').doc('2').set({
//                               'nameAds':'سيارة نيسان',
//                               'ad_id':'1234',
//                               'imageAds':'as/asd/asd.png',
//                               'dateTime':'2023/11/7'
//                             })
//                                 .then((value) {})
//                                 .catchError((error) {
//                               print(error);
//                             });
//
//
//
//
//                             await FirebaseFirestore.instance
//                                 .collection('users')
//                                 .doc('4321')
//                                 .collection('ads').doc('2')
//
//                                 .set({
//                               'nameAds':'سيارة نيسان',
//                               'ad_id':'1234',
//                               'imageAds':'as/asd/asd.png',
//                               'dateTime':'2023/11/7'
//                             })
//                                 .then((value) {})
//                                 .catchError((error) {
//                               print(error);
//                             });
//
//                             await FirebaseFirestore.instance
//                                 .collection('users')
//                                 .doc('1234')
//                                 .collection('ads')
//                                 .doc('2')
//                                 .collection('chats')
//                                 .doc('4321')
//                                 .collection('messages')
//                                 .add({
//                               'text':'Hello',
//                               'senderId':'1234',
//                               'receiverId':'4321',
//                               'dateTime':'2023/11/7'
//                             })
//                                 .then((value) {})
//                                 .catchError((error) {
//                               print(error);
//                             });
//
//                             // set receiver chats
//                             await FirebaseFirestore.instance
//                                 .collection('users')
//                                 .doc('4321')
//                                 .collection('ads')
//                                 .doc('2')
//                                 .collection('chats')
//                                 .doc('1234')
//                                 .collection('messages')
//                                 .add({
//                               'text':'Hello',
//                               'senderId':'1234',
//                               'receiverId':'4321',
//                               'dateTime':'2023/11/7'
//                             })
//                                 .then((value) {
//
//                             })
//                                 .catchError((error) {
//                               print(error);
//                             });
//
//                             await FirebaseFirestore.instance
//                                 .collection('users')
//                                 .doc('1234')
//                                 .collection('ads').get().then((value) {
//
//                               value.docs.forEach((element) {
//
//                                 adsChatsModel =AdsChatsModel.forJson(element.data());
// print(element.data()['ad_id']);
//                                 print(adsChatsModel!.imageAds);
//                               });
//
//                             }).catchError((error){
//                               print('object');
//                             });
                          },
                          icon: Icon(
                            Icons.send,
                            size: 50,
                          )),
                      BlocConsumer<ChatCubit, ChatState>(
                          bloc: chatBloc,
                          listener: (_, state) {
                            setState(() {
                              _isLoading = false;
                            });
                          },
                          builder: (context, state) {
                            final getAllChatState = state.getAllChatsState;

                            if (getAllChatState is BaseFailState) {
                              return Column(
                                children: [
                                  VerticalPadding(3.0),
                                  GeneralErrorWidget(
                                    error: getAllChatState.error,
                                    callback: getAllChatState.callback,
                                  ),
                                ],
                              );
                            }
                            if (isLoading == true &&
                                getAllChatState is GetAllChatsSuccessState) {
                              data = (state.getAllChatsState
                                      as GetAllChatsSuccessState)
                                  .massages;
                              return _buildBody();
                            }
                            return _buildBody();
                          })
                    ],
                  ),
                ),
              ),
            ),


 */
