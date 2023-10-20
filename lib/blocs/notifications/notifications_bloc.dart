import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wadeema/blocs/notifications/states/notifications_state.dart';
import 'package:wadeema/blocs/notifications/states/notifications_state.dart';
import 'package:wadeema/blocs/sponsors/states/sponsors_state.dart';

import '../../../../core/bloc/states/base_fail_state.dart';
import '../../../../core/bloc/states/base_success_state.dart';
import '../../../../core/bloc/states/base_wait_state.dart';
import '../../../../core/di/di_manager.dart';
import '../../../../core/shared_prefs/shared_prefs.dart';
import '../../repos/notifications/notifications_repo_i.dart';
import '../../repos/sponsors/sponsors_repo_i.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsFacade notificationsRepo;

  NotificationsCubit(
    this.notificationsRepo,
  ) : super(NotificationsState.initialState());

  void init() {
    final sharedPrefs = DIManager.findDep<SharedPrefs>();
  }

  Future<void> getAllNotifications() async {
    emit(state.copyWith(getAllNotificationsState: BaseLoadingState()));
    final result = await notificationsRepo.getAllNotifications();
    if (result.hasDataOnly) {
      emit(state.copyWith(
          getAllNotificationsState:
              GetAllNotificationsSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          getAllNotificationsState: BaseFailState(
            result.error,
            callback: () => this.getAllNotifications(),
          ),
        ),
      );
    }
  }

  Future<void> readNotifications(int id) async {
    emit(state.copyWith(readNotificationState: BaseLoadingState()));
    final result = await notificationsRepo.readNotifications(id);
    if (result.hasDataOnly) {
      emit(state.copyWith(
          readNotificationState:
              ReadNotificationSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          readNotificationState: BaseFailState(
            result.error,
            callback: () => this.readNotifications(id),
          ),
        ),
      );
    }
  }
  Future<void> removeNotifications(int id) async {
    emit(state.copyWith(removeNotificationState: BaseLoadingState()));
    final result = await notificationsRepo.removeNotifications(id);
    if (result.hasDataOnly) {
      emit(state.copyWith(
          removeNotificationState:
              RemoveNotificationSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          removeNotificationState: BaseFailState(
            result.error,
            callback: () => this.removeNotifications(id),
          ),
        ),
      );
    }
  }
  Future<void> changeNotificationStatus(int active) async {
    emit(state.copyWith(changeNotificationState: BaseLoadingState()));
    final result = await notificationsRepo.changeNotificationStatus(active);
    if (result.hasDataOnly) {
      emit(state.copyWith(
          changeNotificationState:
          ChangeNotificationSuccessState(result.data!)));
    } else {
      emit(
        state.copyWith(
          changeNotificationState: BaseFailState(
            result.error,
            callback: () => this.changeNotificationStatus(active),
          ),
        ),
      );
    }
  }

}
