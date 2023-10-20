
import 'package:wadeema/data/models/ads_details/entity/ads_details_entity.dart';

import '../../../core/bloc/states/base_init_state.dart';
import '../../../core/bloc/states/base_states.dart';
import '../../../core/bloc/states/base_success_state.dart';
import '../../../core/models/empty_entity.dart';
import '../../../data/models/ads/entity/ads_entity.dart';
import '../../../data/models/messages/entity/messages_entity.dart';
import '../../../data/models/notifications/entity/notifications_entity.dart';
import '../../../data/models/sponsors/entity/sponsors_entity.dart';

class NotificationsState {

  GeneralState getAllNotificationsState;
  GeneralState readNotificationState;
  GeneralState removeNotificationState;
  GeneralState changeNotificationState;


  NotificationsState({
    required this.getAllNotificationsState,
    required this.readNotificationState,
    required this.removeNotificationState,
    required this.changeNotificationState,

  });

  factory NotificationsState.initialState() => NotificationsState(

    readNotificationState: BaseInitState(),
    getAllNotificationsState: BaseInitState(),
    removeNotificationState: BaseInitState(),
    changeNotificationState: BaseInitState(),

  );

  NotificationsState copyWith({

    GeneralState? getAllNotificationsState,
    GeneralState? readNotificationState,
    GeneralState? removeNotificationState,
    GeneralState? changeNotificationState,


  }) {
    return NotificationsState(

      readNotificationState: readNotificationState ?? this.readNotificationState,
      getAllNotificationsState: getAllNotificationsState ?? this.getAllNotificationsState,
      removeNotificationState: removeNotificationState ?? this.removeNotificationState,
      changeNotificationState: changeNotificationState ?? this.changeNotificationState,
    );
  }
}


class GetAllNotificationsSuccessState extends BaseSuccessState {
  final List<ItemsNotificationsEntity> notifications;

  GetAllNotificationsSuccessState(this.notifications);
}



class ReadNotificationSuccessState extends BaseSuccessState {
  final EmptyEntity notification;

  ReadNotificationSuccessState(this.notification);
}

class RemoveNotificationSuccessState extends BaseSuccessState {
  final EmptyEntity notification;

  RemoveNotificationSuccessState(this.notification);
}
class ChangeNotificationSuccessState extends BaseSuccessState {
  final EmptyEntity notification;

  ChangeNotificationSuccessState(this.notification);
}