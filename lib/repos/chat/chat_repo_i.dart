import '../../../core/results/result.dart';
import '../../data/models/messages/entity/messages_entity.dart';
import '../../ui/work_focus_version/chat/args/argument_message.dart';

abstract class ChatFacade {
  Future<Result<List<MessagesEntity>>> getAllChats();

  Future<Result<MessagesAllDataEntity>> getChatMessages(int id);

  Future<Result<MessagesEntity>> sendMessage(ArgumentMessage arg);
}
