
import 'package:wadeema/data/models/ads_details/entity/ads_details_entity.dart';

import '../../../core/bloc/states/base_init_state.dart';
import '../../../core/bloc/states/base_states.dart';
import '../../../core/bloc/states/base_success_state.dart';
import '../../../core/models/empty_entity.dart';
import '../../../data/models/ads/entity/ads_entity.dart';
import '../../../data/models/messages/entity/messages_entity.dart';
import '../../../data/models/messages_firebase/entity/messages_entity_firebase.dart';
import '../../../data/models/sponsors/entity/sponsors_entity.dart';
//
//  class ChatStateFirebase {
//
//   GeneralState getAllAdsChatsStateFirebase;
//   GeneralState getChatMassageStateFirebase;
//   GeneralState sendMassageStateFirebase;
//
//
//   ChatStateFirebase({
//     required this.getAllAdsChatsStateFirebase,
//     required this.getChatMassageStateFirebase,
//     required this.sendMassageStateFirebase,
//   });
//
//   factory ChatStateFirebase.initialState() => ChatStateFirebase(
//
//     getChatMassageStateFirebase: BaseInitState(),
//     getAllAdsChatsStateFirebase: BaseInitState(),
//     sendMassageStateFirebase: BaseInitState(),
//
//   );
//
//   ChatStateFirebase copyWith({
//
//     GeneralState? getAllAdsChatsStateFirebase,
//     GeneralState? getChatMassageStateFirebase,
//     GeneralState? sendMassageStateFirebase,
//
//
//   }) {
//     return ChatStateFirebase(
//
//         getAllAdsChatsStateFirebase: getAllAdsChatsStateFirebase ?? this.getAllAdsChatsStateFirebase,
//         getChatMassageStateFirebase: getChatMassageStateFirebase ?? this.getChatMassageStateFirebase,
//         sendMassageStateFirebase: sendMassageStateFirebase??this.sendMassageStateFirebase
//     );
//   }
// }
//
//
// class GetAllChatsSuccessStateFirebase extends BaseSuccessState {
//   final List<MessagesEntityFirebase> massages;
//
//   GetAllChatsSuccessStateFirebase(this.massages);
// }
//
//
// class GetChatMassageSuccessStateFirebase extends BaseSuccessState {
//   final MessagesAllDataFirebaseEntity massages;
//
//   GetChatMassageSuccessStateFirebase(this.massages);
// }
//
// class SendMessageSuccessStateFirebase extends BaseSuccessState {
//   final MessagesEntityFirebase massage;
//
//   SendMessageSuccessStateFirebase(this.massage);
// }
//
abstract class ChatStateFirebase{}


class ChatFirebaseInitialState extends ChatStateFirebase{}
class ChatFirebaseLoadingState extends ChatStateFirebase{}

class SendMessageSuccessState extends ChatStateFirebase {
  SendMessageSuccessState();
}
class SendMessageErrorState extends ChatStateFirebase {


  SendMessageErrorState();
}


class GetAllAdsChatsLoadingState extends ChatStateFirebase{}

class GetAllAdsChatsSuccessState extends ChatStateFirebase {
  GetAllAdsChatsSuccessState();
}
class GetAllAdsErrorState extends ChatStateFirebase {


  GetAllAdsErrorState();
}

class GetMessagesSuccessState extends ChatStateFirebase {
  GetMessagesSuccessState();
}