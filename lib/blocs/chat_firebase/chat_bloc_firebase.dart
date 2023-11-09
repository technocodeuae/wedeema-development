import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wadeema/blocs/chat_firebase/states/chat_state_firebase.dart';
import 'package:wadeema/blocs/chat_firebase/states/chat_state_firebase.dart';
import 'package:wadeema/blocs/chat_firebase/states/chat_state_firebase.dart';
import 'package:wadeema/blocs/chat_firebase/states/chat_state_firebase.dart';
import 'package:wadeema/blocs/chat_firebase/states/chat_state_firebase.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/bloc/states/base_wait_state.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../data/models/messages_firebase/ads_chats_model.dart';
import '../../data/models/messages_firebase/messages_model_new.dart';
import '../../repos/chat_firebase/chat_repo_i_firebase.dart';
import '../../ui/work_focus_version/chat/args/argument_message.dart';

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

  Future<void> getAllAdsChats({
    required String user_id,
  }) async {
    emit(GetAllAdsChatsLoadingState());
    adsChatsModel.clear();
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
      }).catchError((error) {
        print(error.toString());
        print('error.toString()');
      });
      print(adsChatsModel[2].nameAds);
      emit(GetAllAdsChatsSuccessState());
    } catch (error) {
      print(error.toString());
      emit(GetAllAdsErrorState());
    }
  }

  String user_id = DIManager.findDep<SharedPrefs>().getUserID().toString();
  List<DataMassageModel> messages = [];

  void getMessages({
    required String? ad_id,
    required String? receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user_id)
        .collection('ads')
        .doc(ad_id)
        .collection('chats')
        .doc(receiverId)
        .collection('messages').orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages= [];
      event.docs.forEach((element) {
        messages.add(DataMassageModel.forJson(element.data()));
      });
print(messages);
      emit(GetMessagesSuccessState());
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
      print('SendMessageSuccessFirebase');
      emit(SendMessageSuccessState());
    } catch (error) {
      print(error.toString());
      emit(SendMessageErrorState());
    }
  }
}
