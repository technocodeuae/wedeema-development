import '../../../core/base_repository.dart';
import '../../../core/models/empty_entity.dart';
import '../../../core/results/result.dart';
import '../../../core/shared_prefs/shared_prefs.dart';


import '../../data/models/ads/entity/ads_entity.dart';
import '../../data/models/ads_details/entity/ads_details_entity.dart';
import '../../data/models/auth/entity/auth_entity.dart';
import '../../data/models/messages/entity/messages_entity.dart';
import '../../data/models/messages_firebase/ads_chats_model.dart';
import '../../data/models/messages_firebase/entity/messages_entity_firebase.dart';
import '../../data/models/messages_firebase/messages_model_new.dart';
import '../../data/models/sponsors/entity/sponsors_entity.dart';
import '../../data/sources/ads/ads_remote_data_source.dart';
import '../../data/sources/auth/auth_remote_data_source.dart';
import '../../data/sources/chat/chat_remote_data_source.dart';
import '../../data/sources/chat_firebase/chat_remote_data_source_firebase.dart';
import '../../data/sources/sponsors/sponsors_remote_data_source.dart';
import '../../ui/work_focus_version/ads/args/argument_policy.dart';
import '../../ui/work_focus_version/chat/args/argument_message.dart';
import 'chat_repo_i_firebase.dart';

class ChatRepoFirebase extends BaseRepository implements ChatFacadeFirebase {
  final ChatRemoteDataSourceFirebase _aRD;
  final SharedPrefs _sp;

  ChatRepoFirebase(this._aRD,
      this._sp,);


  @override
  Future<Result<List<MessagesEntityFirebase>>> getAllChatsFirebase() async {
    final res = await _aRD.getAllChatsFirebase();
    return mapModelsToEntities(res);
  }

  @override
  Future<Result<MessagesAllDataFirebaseEntity>> getChatMessagesFirebase(
      int id) async {
    final res = await _aRD.getChatMessagesFirebase(id);
    return mapModelToEntity(res);
  }

  @override
  Future<Result<MessagesEntityFirebase>> sendMessageFirebase(
      ArgumentMessage arg) async {
    final res = await _aRD.sendMassageFirebase(arg);
    return mapModelToEntity(res);
  }

  Future<void> getAllAdsChats({
    required String user_id,
  }) async{
   await _aRD.getAllAdsChats(user_id: user_id);

  }


  Future<void> sendMassageFirebaseToFireStore({
    required String user_id,
    required String user_id_2,
    required String ad_id,
    required DataMassageModel dataMassageModel,
    required AdsChatsModel adsChatsModel,
  }) async {
    await _aRD.sendMassageFirebaseToFireStore(user_id: user_id,
        user_id_2: user_id_2,
        ad_id: ad_id,
        dataMassageModel: dataMassageModel,
        adsChatsModel: adsChatsModel);
  }

}
