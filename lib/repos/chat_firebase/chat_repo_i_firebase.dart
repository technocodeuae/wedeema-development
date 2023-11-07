import '../../../core/results/result.dart';
import '../../data/models/messages/entity/messages_entity.dart';
import '../../data/models/messages_firebase/ads_chats_model.dart';
import '../../data/models/messages_firebase/entity/messages_entity_firebase.dart';
import '../../data/models/messages_firebase/messages_model_new.dart';
import '../../ui/work_focus_version/chat/args/argument_message.dart';

abstract class ChatFacadeFirebase {
  Future<Result<List<MessagesEntityFirebase>>> getAllChatsFirebase();

  Future<Result<MessagesAllDataFirebaseEntity>> getChatMessagesFirebase(int id);

  Future<Result<MessagesEntityFirebase>> sendMessageFirebase(ArgumentMessage arg);


  Future<void> getAllAdsChats({
    required String user_id,
  }) ;

  Future<void> sendMassageFirebaseToFireStore({
    required String user_id,
    required String user_id_2,
    required String ad_id,
    required DataMassageModel dataMassageModel,
    required AdsChatsModel adsChatsModel,
  });
}


