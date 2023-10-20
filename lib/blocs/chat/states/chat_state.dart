
import 'package:wadeema/data/models/ads_details/entity/ads_details_entity.dart';

import '../../../core/bloc/states/base_init_state.dart';
import '../../../core/bloc/states/base_states.dart';
import '../../../core/bloc/states/base_success_state.dart';
import '../../../core/models/empty_entity.dart';
import '../../../data/models/ads/entity/ads_entity.dart';
import '../../../data/models/messages/entity/messages_entity.dart';
import '../../../data/models/sponsors/entity/sponsors_entity.dart';

class ChatState {

  GeneralState getAllChatsState;
  GeneralState getChatMassageState;
  GeneralState sendMassageState;


  ChatState({
    required this.getAllChatsState,
    required this.getChatMassageState,
    required this.sendMassageState,
  });

  factory ChatState.initialState() => ChatState(

    getChatMassageState: BaseInitState(),
    getAllChatsState: BaseInitState(),
    sendMassageState: BaseInitState(),

  );

  ChatState copyWith({

    GeneralState? getAllChatsState,
    GeneralState? getChatMassageState,
    GeneralState? sendMassageState,


  }) {
    return ChatState(

        getAllChatsState: getAllChatsState ?? this.getAllChatsState,
        getChatMassageState: getChatMassageState ?? this.getChatMassageState,
        sendMassageState: sendMassageState??this.sendMassageState
    );
  }
}


class GetAllChatsSuccessState extends BaseSuccessState {
  final List<MessagesEntity> massages;

  GetAllChatsSuccessState(this.massages);
}


class GetChatMassageSuccessState extends BaseSuccessState {
  final MessagesAllDataEntity massages;

  GetChatMassageSuccessState(this.massages);
}

class SendMessageSuccessState extends BaseSuccessState {
  final MessagesEntity massage;

  SendMessageSuccessState(this.massage);
}