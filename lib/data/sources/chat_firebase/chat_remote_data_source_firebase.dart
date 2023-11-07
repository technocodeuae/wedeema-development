import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

import '../../../../core/data_source/base_remote_data_source.dart';
import '../../../../core/net/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../../data/endpoints/endpoints.dart';
import '../../../ui/work_focus_version/chat/args/argument_message.dart';
import '../../models/messages/messages_model.dart';
import '../../models/messages_firebase/ads_chats_model.dart';
import '../../models/messages_firebase/messages_model_firebase.dart';
import '../../models/messages_firebase/messages_model_new.dart';

class ChatRemoteDataSourceFirebaseImplFirebase
    implements ChatRemoteDataSourceFirebase {
  ChatRemoteDataSourceFirebaseImplFirebase();

  /*

                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc('1234')
                                .collection('ads')
                                .doc('1')
                                .collection('chats')
                                .doc('4321')
                                .collection('messages')
                                .add({
                              'text':'Hello',
                              'senderId':'1234',
                              'receiverId':'4321',
                              'dateTime':'2023/11/7'
                            })
                                .then((value) {})
                                .catchError((error) {
                              print(error);
                            });

                            // set receiver chats
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc('4321')
                                .collection('ads')
                                .doc('1')
                                .collection('chats')
                                .doc('1234')
                                .collection('messages')
                                .add({
                              'text':'Hello',
                              'senderId':'1234',
                              'receiverId':'4321',
                              'dateTime':'2023/11/7'
                            })
                                .then((value) {

                            })
                                .catchError((error) {
                              print(error);
                            });
   */

  Future<Result<List<MessagesModelFirebase>>> getAllChatsFirebase() async {
    return await RemoteDataSource.request<List<MessagesModelFirebase>>(
      converterList: (list) =>
          list
              ?.map((model) => MessagesModelFirebase.fromJson(model))
              .toList() ??
          [],
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.allChats,
    );
  }

  Future<Result<MessagesAllDataFirebaseModel>> getChatMessagesFirebase(
      int id) async {
    return await RemoteDataSource.request<MessagesAllDataFirebaseModel>(
      converter: (model) => MessagesAllDataFirebaseModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.getChatMassage + "${id}",
    );
  }

  Future<Result<MessagesModelFirebase>> sendMassageFirebase(
      ArgumentMessage arg) async {
    print("my list" + arg.files!.length.toString());

    FormData formData;

    Map<String, dynamic>? dataMap = {};

    List<dynamic> mediaList = [];
    for (int i = 0; i < arg!.files!.length; i++) {
      print("arg!.files![i].path" + arg!.files![i].path.toString());
      mediaList.add(await MultipartFile.fromFile(
        arg!.files![i].path,
        filename: basename(
          arg!.files![i]?.path ?? "",
        ),
      ));

      print(arg!.files![i].path + mediaList[i].toString());
    }

    dataMap!["files[]"] = mediaList;
    dataMap!["message"] = arg.message;
    dataMap!["ad_id"] = arg.ad_id;
    dataMap!["user_id_2"] = arg.user_id_2;

    formData = FormData.fromMap(dataMap!);

    print("MY DATAFORM" + formData.files.toString());

    ///[{} {}]

    return await RemoteDataSource.request<MessagesModelFirebase>(
      converter: (model) => MessagesModelFirebase.fromJson(model),
      method: HttpMethod.POST,
      headers: {RemoteDataSource.requiresToken: true},
      formData: formData,
      url: AppEndpoints.sendMassage,
    );
  }

  Future<void> sendMassageFirebaseToFireStore({
    required String user_id,
    required String user_id_2,
    required String ad_id,
    required DataMassageModel dataMassageModel,
    required AdsChatsModel adsChatsModel,
  }) async {
    /*
    dataMassage
    {
          'text': 'Hello',
          'senderId': '1234',
          'receiverId': '4321',
          'dateTime': '2023/11/7'
        }
     */

    /*
    dataAds
    {
           'nameAds':'سيارة نيسان',
           'lastText':'Hello',
           'ad_id':'1234',
           'imageAds':'as/asd/asd.png',
           'dateTime':'2023/11/7'
        }
     */

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user_id)
        .collection('ads')
        .doc(ad_id)
        .set(adsChatsModel.toMap())
        .then((value) {})
        .catchError((error) {
      print(error);
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user_id_2)
        .collection('ads')
        .doc(ad_id)
        .set(adsChatsModel.toMap())
        .then((value) {})
        .catchError((error) {
      print(error);
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user_id)
        .collection('ads')
        .doc(ad_id)
        .collection('chats')
        .doc(user_id_2)
        .collection('messages')
        .add(dataMassageModel.toMap())
        .then((value) {
      print(value.toString());
    }).catchError((error) {
      print(error);
    });

    // set receiver chats
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user_id_2)
        .collection('ads')
        .doc(ad_id)
        .collection('chats')
        .doc(user_id)
        .collection('messages')
        .add(dataMassageModel.toMap())
        .then((value) {
      print(value.toString());
    }).catchError((error) {
      print(error);
    });
  }

AdsChatsModel? adsChatsModel;

  Future<void> getAllAdsChats({
    required String user_id,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user_id)
        .collection('ads')
        .get()
        .then((value) {

      value.docs.forEach((element) {
        adsChatsModel =AdsChatsModel.forJson(element.data());
        print(adsChatsModel!.imageAds);
      });


    }).catchError((error) {

      print(error.toString());
    });
  }
}

abstract class ChatRemoteDataSourceFirebase {
  const ChatRemoteDataSourceFirebase();

  Future<Result<List<MessagesModelFirebase>>> getAllChatsFirebase();

  Future<Result<MessagesAllDataFirebaseModel>> getChatMessagesFirebase(int id);

  Future<void> sendMassageFirebaseToFireStore({
    required String user_id,
    required String user_id_2,
    required String ad_id,
    required DataMassageModel dataMassageModel,
    required AdsChatsModel adsChatsModel,
  });

  Future<void> getAllAdsChats({
    required String user_id,
  });

  Future<Result<MessagesModelFirebase>> sendMassageFirebase(
      ArgumentMessage arg);
}
