
import '../../../core/base_repository.dart';
import '../../../core/models/empty_entity.dart';
import '../../../core/results/result.dart';
import '../../../core/shared_prefs/shared_prefs.dart';


import '../../data/models/ads/entity/ads_entity.dart';
import '../../data/models/ads_details/entity/ads_details_entity.dart';
import '../../data/models/auth/entity/auth_entity.dart';
import '../../data/models/messages/entity/messages_entity.dart';
import '../../data/models/sponsors/entity/sponsors_entity.dart';
import '../../data/sources/ads/ads_remote_data_source.dart';
import '../../data/sources/auth/auth_remote_data_source.dart';
import '../../data/sources/chat/chat_remote_data_source.dart';
import '../../data/sources/sponsors/sponsors_remote_data_source.dart';
import '../../ui/work_focus_version/ads/args/argument_policy.dart';
import '../../ui/work_focus_version/chat/args/argument_message.dart';
import 'chat_repo_i.dart';

class ChatRepo extends BaseRepository implements ChatFacade {
  final ChatRemoteDataSource _aRD;
  final SharedPrefs _sp;

  ChatRepo(
    this._aRD,
    this._sp,
  );


  @override
  Future<Result<List<MessagesEntity>>> getAllChats() async{
    final res = await _aRD.getAllChats();
    return mapModelsToEntities(res);
  }

  @override
  Future<Result<MessagesAllDataEntity>> getChatMessages(int id) async {
    final res = await _aRD.getChatMessages(id);
    return mapModelToEntity(res);
  }

  @override
  Future<Result<MessagesEntity>> sendMessage(ArgumentMessage arg) async {
    final res = await _aRD.sendMassage(arg);
    return mapModelToEntity(res);
  }


}
