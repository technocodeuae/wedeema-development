import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wadeema/blocs/chat_firebase/states/chat_state_firebase.dart';

import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../data/models/messages_firebase/ads_chats_model.dart';
import '../../data/models/messages_firebase/messages_model_new.dart';
import '../../repos/chat_firebase/chat_repo_i_firebase.dart';

class ChatCubitFirebase extends Cubit<ChatStateFirebase> {
  final ChatFacadeFirebase adsRepo;

  ChatCubitFirebase(
    this.adsRepo,
  ) : super(ChatFirebaseInitialState());

  // Future<void> getAllChats() async {
  //   emit(state.copyWith(getAllAdsChatsStateFirebase: BaseLoadingState()));
  //   final result = await adsRepo.getAllChatsFirebase();
  //   if (result.hasDataOnly) {
  //     emit(state.copyWith(getAllAdsChatsStateFirebase: GetAllChatsSuccessStateFirebase(result.data!)));
  //   } else {
  //     emit(
  //       state.copyWith(
  //         getAllAdsChatsStateFirebase: BaseFailState(
  //           result.error,
  //           callback: () => this.getAllChats(),
  //         ),
  //       ),
  //     );
  //   }
  // }
  //
  //
  // Future<void> getChatMessages(int id) async {
  //   emit(state.copyWith(getChatMassageStateFirebase: BaseLoadingState()));
  //   final result = await adsRepo.getChatMessagesFirebase(id);
  //   if (result.hasDataOnly) {
  //     emit(state.copyWith(getChatMassageStateFirebase: GetChatMassageSuccessStateFirebase(result.data!)));
  //   } else {
  //     emit(
  //       state.copyWith(
  //         getChatMassageStateFirebase: BaseFailState(
  //           result.error,
  //           callback: () => this.getChatMessages(id),
  //         ),
  //       ),
  //     );
  //   }
  // }
  //
  //
  // Future<void> sendMassage(ArgumentMessage arg) async  {
  //   emit(state.copyWith(sendMassageStateFirebase: BaseLoadingState()));
  //   final result = await adsRepo.sendMessageFirebase(arg);
  //   if (result.hasDataOnly) {
  //     emit(state.copyWith(sendMassageStateFirebase: SendMessageSuccessStateFirebase(result.data!)));
  //   } else {
  //     emit(
  //       state.copyWith(
  //         sendMassageStateFirebase: BaseFailState(
  //           result.error,
  //           callback: () => this.sendMassage(arg),
  //         ),
  //       ),
  //     );
  //   }
  // }

  // final databaseReference = FirebaseDatabase.instance.reference();

  List<AdsChatsModel> adsChatsModel = [];
  // String user_id = DIManager.findDep<SharedPrefs>().getUserID().toString();
  //
  // Future<void> getAllAdsChats({
  //   required String user_id,
  // }) async {
  //   emit(GetAllAdsChatsLoadingState());
  //   try {
  //     // await adsRepo.getAllAdsChats(user_id: user_id);
  //     //
  //
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(user_id)
  //         .collection('ads')
  //         .get()
  //         .then((value) {
  //       value.docs.forEach((element) {
  //         AdsChatsModel adsChats = AdsChatsModel.forJson(element.data());
  //         adsChatsModel.add(adsChats);
  //       });
  //
  //       print(adsChatsModel);
  //     }).catchError((error) {
  //       print(error.toString());
  //     });
  //
  //     emit(GetAllAdsChatsSuccessState());
  //   } catch (error) {
  //     print(error.toString());
  //     emit(GetAllAdsErrorState());
  //   }
  // }
  //

  Future<void> getAllAdsChats(
  {
    required String? user_id,
}
      ) async {
    emit(GetAllAdsChatsLoadingState());
    adsChatsModel = [];
    print("user_id:====================================user_id===============user_id===============${user_id}");
    try {
      // await adsRepo.getAllAdsChats(user_id: user_id);
      //

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user_id)
          .collection('ads')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          AdsChatsModel adsChats = AdsChatsModel.forJson(element.data());
          adsChatsModel.add(adsChats);
        });
        print(adsChatsModel[0].nameAds);
        print(adsChatsModel[1].nameAds);
      });
      print('adsChatsModel[2].nameAds-----------------------------------------------------------------------');
      print(adsChatsModel[0].nameAds);
      emit(GetAllAdsChatsSuccessState());
    } catch (error) {
      print(error.toString());
      emit(GetAllAdsErrorState());
    }
  }


  List<DataMassageModel> messages = [];

  void getMessages({
    required String? ad_id,
    required String? user_id_2,
    required String? user_id,
    required String? receiverId,
  }) {
    print('============================================================================');
    print("ad_id!+user_id_2!: ${ad_id!+user_id!}");
    print('============================================================================');
    FirebaseFirestore.instance
        .collection('users')
        .doc(user_id)
        .collection('ads')
        .doc(ad_id!+user_id_2!)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(DataMassageModel.forJson(element.data()));
      });
      print(messages);
      emit(GetMessagesSuccessState());
      // getAllAdsChats(
      //   user_id: user_id
      // );
    });
  }

  List<DataMassageModel> messagesLast = [];

String lastMessages = '';
  List<AdsChatsModel> adsLastInfo = [];
  void getAdsLastInfo({
    required String? user_id,

  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user_id)
        .collection('ads')
        .snapshots()
        .listen((event) {
      adsLastInfo = [];
      event.docs.forEach((element) {
        AdsChatsModel adsChats = AdsChatsModel.forJson(element.data());
        adsLastInfo.add(adsChats);
      });
      print(adsLastInfo[0].nameAds);
      print(adsLastInfo[1].nameAds);
      emit(GetAdsInfoSuccessState());
    });
  }


  Future<void> sendMassageFirebaseToFireStore({
    required String user_id,
    required String user_id_2,
    required String ad_id,
    required DataMassageModel dataMassageModel,
    required AdsChatsModel adsChatsModel,
  }) async {
    emit(ChatFirebaseLoadingState());

    try {
      await adsRepo.sendMassageFirebaseToFireStore(
          user_id: user_id,
          user_id_2: user_id_2,
          ad_id: ad_id,
          dataMassageModel: dataMassageModel,
          adsChatsModel: adsChatsModel);
      // print('SendMessageSuccessFirebase');

      //
      // getLastMessages(
      //   user_id: user_id,
      // receiverId: user_id_2,
      //  user_id_2: user_id_2,
      // ad_id: ad_id,
      // );
      emit(SendMessageSuccessState());
    } catch (error) {
      print(error.toString());
      emit(SendMessageErrorState());
    }
  }

  void deleteChat({
    required String? ad_id,
    required String? user_id_2,
    required String? user_id,
    required String? receiverId,
  }) {
    emit(DeleteMessagesLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(user_id)
        .collection('ads')
        .doc(ad_id!+user_id_2!)
        .delete()
        .then((value) {
      getAllAdsChats(
        user_id: user_id
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(user_id)
          .collection('ads')
          .doc(ad_id+user_id_2)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .get()
          .then((value) {
        for (DocumentSnapshot ds in value.docs) {
          ds.reference.delete();
        }
        ;
        emit(DeleteMessagesSuccessState());
      }).catchError((error) {
        DeleteMessagesErrorState(error.toString());
      });
    }).catchError((error) {
      DeleteMessagesErrorState(error.toString());
    });
  }
}


