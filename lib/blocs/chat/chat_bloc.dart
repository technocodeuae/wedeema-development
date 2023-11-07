import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wadeema/blocs/chat/states/chat_state.dart';
import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/bloc/states/base_wait_state.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../repos/chat/chat_repo_i.dart';
import '../../ui/work_focus_version/chat/args/argument_message.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatFacade adsRepo;

  ChatCubit(
    this.adsRepo,
  ) : super(ChatState.initialState());

  void init() {
    final sharedPrefs = DIManager.findDep<SharedPrefs>();
  }

  Future<void> getAllChats() async {
    emit(state.copyWith(getAllChatsState: BaseLoadingState()));
    final result = await adsRepo.getAllChats();
    if (result.hasDataOnly) {
      emit(state.copyWith(getAllChatsState: GetAllChatsSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getAllChatsState: BaseFailState(
            result.error,
            callback: () => this.getAllChats(),
          ),
        ),
      );
    }
  }


  Future<void> getChatMessages(int id) async {
    emit(state.copyWith(getChatMassageState: BaseLoadingState()));
    final result = await adsRepo.getChatMessages(id);
    if (result.hasDataOnly) {
      emit(state.copyWith(getChatMassageState: GetChatMassageSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getChatMassageState: BaseFailState(
            result.error,
            callback: () => this.getChatMessages(id),
          ),
        ),
      );
    }
  }


  Future<void> sendMassage(ArgumentMessage arg) async  {
    emit(state.copyWith(sendMassageState: BaseLoadingState()));
    final result = await adsRepo.sendMessage(arg);
    if (result.hasDataOnly) {
      emit(state.copyWith(sendMassageState: SendMessageSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          sendMassageState: BaseFailState(
            result.error,
            callback: () => this.sendMassage(arg),
          ),
        ),
      );
    }
  }
}
