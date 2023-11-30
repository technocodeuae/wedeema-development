
import 'package:wadeema/data/models/ads_details/entity/ads_details_entity.dart';

import '../../../core/bloc/states/base_init_state.dart';
import '../../../core/bloc/states/base_states.dart';
import '../../../core/bloc/states/base_success_state.dart';
import '../../../core/models/empty_entity.dart';
import '../../../data/models/ads/entity/ads_entity.dart';
import '../../../data/models/messages/entity/messages_entity.dart';
import '../../../data/models/messages_firebase/entity/messages_entity_firebase.dart';
import '../../../data/models/sponsors/entity/sponsors_entity.dart';

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

class GetAdsInfoSuccessState extends ChatStateFirebase {
  GetAdsInfoSuccessState();
}



class ChatStateFirebaseSuccess extends ChatStateFirebase {
  final String? messages;
  final int? conversations;
  ChatStateFirebaseSuccess(this.messages,this.conversations);
}
class DeleteMessagesLoadingState extends ChatStateFirebase {
  DeleteMessagesLoadingState();
}
class DeleteMessagesSuccessState extends ChatStateFirebase {
  DeleteMessagesSuccessState();
}
class DeleteMessagesErrorState extends ChatStateFirebase {
  final String? error;
  DeleteMessagesErrorState(this.error);
}
