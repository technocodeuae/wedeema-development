import 'package:dio/dio.dart';
import 'package:path/path.dart';

import '../../../../core/data_source/base_remote_data_source.dart';
import '../../../../core/net/http_method.dart';
import '../../../../core/results/result.dart';
import '../../../../data/endpoints/endpoints.dart';
import '../../../ui/work_focus_version/chat/args/argument_message.dart';
import '../../models/messages/messages_model.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  const ChatRemoteDataSourceImpl();

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

  Future<Result<List<MessagesModel>>> getAllChats() async {
    return await RemoteDataSource.request<List<MessagesModel>>(
      converterList: (list) =>
          list?.map((model) => MessagesModel.fromJson(model)).toList() ?? [],
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.allChats,
    );

  }

  Future<Result<MessagesAllDataModel>> getChatMessages(int id) async {
    return await RemoteDataSource.request<MessagesAllDataModel>(
      converter: (model) => MessagesAllDataModel.fromJson(model),
      method: HttpMethod.GET,
      headers: {RemoteDataSource.requiresToken: true},
      url: AppEndpoints.getChatMassage + "${id}",
    );
  }

  Future<Result<MessagesModel>> sendMassage(ArgumentMessage arg) async {
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

    return await RemoteDataSource.request<MessagesModel>(
      converter: (model) => MessagesModel.fromJson(model),
      method: HttpMethod.POST,
      headers: {RemoteDataSource.requiresToken: true},
      formData: formData,
      url: AppEndpoints.sendMassage,
    );
  }
}

abstract class ChatRemoteDataSource {
  const ChatRemoteDataSource();

  Future<Result<List<MessagesModel>>> getAllChats();

  Future<Result<MessagesAllDataModel>> getChatMessages(int id);

  Future<Result<MessagesModel>> sendMassage(ArgumentMessage arg);
}
